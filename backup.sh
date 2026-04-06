#!/bin/bash
# =====================================================
# 作业计时器系统 — 还原点管理脚本
# 用法：
#   ./backup.sh save [备注]   — 创建还原点
#   ./backup.sh list          — 列出所有还原点
#   ./backup.sh restore <id>  — 还原到指定还原点
#   ./backup.sh diff <id>     — 查看指定还原点与当前的差异
#   ./backup.sh delete <id>   — 删除指定还原点
# =====================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/.snapshots"
FILES=("yujia.html" "yuhan.html" "parent_dashboard.html" "index.html")

mkdir -p "$BACKUP_DIR"

# 颜色输出
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

show_help() {
    echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        作业计时器系统 — 还原点管理工具               ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${GREEN}save${NC}  [备注]    创建新的还原点快照"
    echo -e "  ${GREEN}list${NC}           列出所有还原点"
    echo -e "  ${GREEN}restore${NC} <id>   还原到指定还原点（自动先备份当前）"
    echo -e "  ${GREEN}diff${NC}    <id>   查看指定还原点与当前文件的差异"
    echo -e "  ${GREEN}delete${NC}  <id>   删除指定还原点"
    echo ""
}

cmd_save() {
    local note="${1:-手动备份}"
    local ts=$(date +%Y%m%d_%H%M%S)
    local snap_dir="$BACKUP_DIR/snap_$ts"
    mkdir -p "$snap_dir"

    local count=0
    for f in "${FILES[@]}"; do
        local src="$SCRIPT_DIR/$f"
        if [ -f "$src" ]; then
            cp "$src" "$snap_dir/$f"
            count=$((count+1))
        fi
    done

    # 写 meta 文件
    cat > "$snap_dir/meta.txt" <<EOF
id=snap_$ts
time=$(date '+%Y-%m-%d %H:%M:%S')
note=$note
files=$count
EOF

    echo -e "${GREEN}✅ 还原点已创建：${NC}snap_$ts"
    echo -e "   备注：$note"
    echo -e "   包含文件：$count 个"
    echo -e "   路径：$snap_dir"

    # 自动清理超过 30 个的旧快照
    local old_count=$(ls "$BACKUP_DIR" | grep "^snap_" | wc -l)
    if [ "$old_count" -gt 30 ]; then
        local oldest=$(ls "$BACKUP_DIR" | grep "^snap_" | sort | head -1)
        rm -rf "$BACKUP_DIR/$oldest"
        echo -e "${YELLOW}⚠️  自动清理最旧快照：$oldest${NC}"
    fi
}

cmd_list() {
    local snaps=$(ls "$BACKUP_DIR" 2>/dev/null | grep "^snap_" | sort -r)
    if [ -z "$snaps" ]; then
        echo -e "${YELLOW}暂无还原点。使用 ./backup.sh save 创建第一个还原点。${NC}"
        return
    fi

    echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  ID                     时间                  备注${NC}"
    echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
    local i=1
    while IFS= read -r snap; do
        local meta="$BACKUP_DIR/$snap/meta.txt"
        local time="--"
        local note="--"
        local files="--"
        if [ -f "$meta" ]; then
            time=$(grep "^time=" "$meta" | cut -d= -f2-)
            note=$(grep "^note=" "$meta" | cut -d= -f2-)
            files=$(grep "^files=" "$meta" | cut -d= -f2-)
        fi
        echo -e "  ${GREEN}[$i]${NC} $snap"
        echo -e "       时间：$time   文件：${files}个"
        echo -e "       备注：$note"
        i=$((i+1))
    done <<< "$snaps"
    echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
    echo -e "共 $(echo "$snaps" | wc -l | tr -d ' ') 个还原点"
}

cmd_restore() {
    local snap_id="$1"
    if [ -z "$snap_id" ]; then
        echo -e "${RED}❌ 请指定还原点 ID，例如：./backup.sh restore snap_20260406_120000${NC}"
        cmd_list
        return 1
    fi

    # 支持数字索引
    if [[ "$snap_id" =~ ^[0-9]+$ ]]; then
        local snaps=($(ls "$BACKUP_DIR" 2>/dev/null | grep "^snap_" | sort -r))
        local idx=$((snap_id-1))
        if [ "$idx" -lt 0 ] || [ "$idx" -ge "${#snaps[@]}" ]; then
            echo -e "${RED}❌ 无效的序号：$snap_id${NC}"
            return 1
        fi
        snap_id="${snaps[$idx]}"
    fi

    local snap_dir="$BACKUP_DIR/$snap_id"
    if [ ! -d "$snap_dir" ]; then
        echo -e "${RED}❌ 还原点不存在：$snap_id${NC}"
        return 1
    fi

    # 自动备份当前状态
    echo -e "${YELLOW}🔒 还原前自动备份当前状态...${NC}"
    cmd_save "还原前自动备份（还原到$snap_id）"

    # 执行还原
    local count=0
    for f in "${FILES[@]}"; do
        local src="$snap_dir/$f"
        local dst="$SCRIPT_DIR/$f"
        if [ -f "$src" ]; then
            cp "$src" "$dst"
            echo -e "   ${GREEN}✓${NC} $f"
            count=$((count+1))
        fi
    done

    local meta="$snap_dir/meta.txt"
    local note=$(grep "^note=" "$meta" 2>/dev/null | cut -d= -f2-)
    local time=$(grep "^time=" "$meta" 2>/dev/null | cut -d= -f2-)

    echo ""
    echo -e "${GREEN}✅ 已还原到快照：$snap_id${NC}"
    echo -e "   原始时间：$time"
    echo -e "   原始备注：$note"
    echo -e "   还原文件：$count 个"
    echo ""
    echo -e "${YELLOW}💡 提示：如需推送到 GitHub，请执行：${NC}"
    echo -e "   cd $SCRIPT_DIR && git add -A && git commit -m '还原: $snap_id' && git push"
}

cmd_diff() {
    local snap_id="$1"
    if [ -z "$snap_id" ]; then
        echo -e "${RED}❌ 请指定还原点 ID${NC}"
        return 1
    fi

    # 支持数字索引
    if [[ "$snap_id" =~ ^[0-9]+$ ]]; then
        local snaps=($(ls "$BACKUP_DIR" 2>/dev/null | grep "^snap_" | sort -r))
        local idx=$((snap_id-1))
        snap_id="${snaps[$idx]}"
    fi

    local snap_dir="$BACKUP_DIR/$snap_id"
    if [ ! -d "$snap_dir" ]; then
        echo -e "${RED}❌ 还原点不存在：$snap_id${NC}"
        return 1
    fi

    echo -e "${CYAN}══ 与还原点 $snap_id 的差异 ══${NC}"
    for f in "${FILES[@]}"; do
        local snap_f="$snap_dir/$f"
        local cur_f="$SCRIPT_DIR/$f"
        if [ -f "$snap_f" ] && [ -f "$cur_f" ]; then
            local diff_out=$(diff "$snap_f" "$cur_f" 2>/dev/null)
            if [ -n "$diff_out" ]; then
                echo -e "${YELLOW}📝 $f — 有变化${NC}"
                diff --color=always "$snap_f" "$cur_f" | head -50
            else
                echo -e "${GREEN}✓ $f — 无变化${NC}"
            fi
        elif [ -f "$cur_f" ] && [ ! -f "$snap_f" ]; then
            echo -e "${BLUE}➕ $f — 快照中不存在（新文件）${NC}"
        fi
    done
}

cmd_delete() {
    local snap_id="$1"
    if [ -z "$snap_id" ]; then
        echo -e "${RED}❌ 请指定还原点 ID${NC}"
        return 1
    fi

    # 支持数字索引
    if [[ "$snap_id" =~ ^[0-9]+$ ]]; then
        local snaps=($(ls "$BACKUP_DIR" 2>/dev/null | grep "^snap_" | sort -r))
        local idx=$((snap_id-1))
        snap_id="${snaps[$idx]}"
    fi

    local snap_dir="$BACKUP_DIR/$snap_id"
    if [ ! -d "$snap_dir" ]; then
        echo -e "${RED}❌ 还原点不存在：$snap_id${NC}"
        return 1
    fi

    read -p "$(echo -e "${YELLOW}⚠️  确定删除还原点 $snap_id？(y/N) ${NC}")" confirm
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        rm -rf "$snap_dir"
        echo -e "${GREEN}✅ 已删除：$snap_id${NC}"
    else
        echo "已取消"
    fi
}

# ===== 主入口 =====
case "$1" in
    save)    cmd_save "$2" ;;
    list)    cmd_list ;;
    restore) cmd_restore "$2" ;;
    diff)    cmd_diff "$2" ;;
    delete)  cmd_delete "$2" ;;
    *)       show_help ;;
esac
