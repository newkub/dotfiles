# Starship git segment: latest commit, latest push, dirty count.
# Read path uses bash builtins only; git runs only on state change or after TTL.
# The expensive refresh runs in the background and the cached value is shown meanwhile.

ttl=3

short_rel() {
    local r=$1 n u
    [ "$r" = "now" ] && { printf 'now'; return; }
    n=${r%% *}
    case "$r" in
        *second*) u=s ;;
        *minute*) u=m ;;
        *hour*) u=h ;;
        *day*) u=d ;;
        *week*) u=w ;;
        *month*) u=mo ;;
        *year*) u=y ;;
        *) printf '%s' "$r"; return ;;
    esac
    printf '%s%s ago' "$n" "$u"
}

root=$PWD
while [ "$root" != "/" ] && [ "$root" != "//" ] && [ ! -e "$root/.git" ]; do
    root=${root%/*}
    [ -z "$root" ] && root=/
done
[ -e "$root/.git" ] || exit 0

gitdir=$root/.git
if [ -f "$gitdir" ]; then
    IFS= read -r gline < "$gitdir" 2>/dev/null
    case "$gline" in
        gitdir:*)
            gd=${gline#gitdir:}
            gd=${gd# }
            case "$gd" in
                /*|[A-Za-z]:/*) ;;
                *) gd=$root/$gd ;;
            esac
            gitdir=$gd
            ;;
    esac
fi

commondir=$gitdir
if [ -f "$gitdir/commondir" ]; then
    IFS= read -r cmon < "$gitdir/commondir" 2>/dev/null
    case "$cmon" in
        /*|[A-Za-z]:/*) ;;
        *) cmon=$gitdir/$cmon ;;
    esac
    [ -n "$cmon" ] && commondir=$cmon
fi

cache_dir=$HOME/.cache/starship-prompt
[ -d "$cache_dir" ] || mkdir -p "$cache_dir" 2>/dev/null || exit 0

key_hash() {
    local s=${1,,} h=2166136261 i c
    for ((i = 0; i < ${#s}; i++)); do
        printf -v c '%d' "'${s:i:1}"
        h=$(((h ^ c) * 16777619 & 0xffffffff))
    done
    printf '%08x' "$h"
}
cache=$cache_dir/$(key_hash "$root")

headfile=$gitdir/HEAD
ref=""
IFS= read -r head < "$headfile" 2>/dev/null
case "$head" in
    "ref: "*) ref=$commondir/${head#ref: } ;;
esac
if [ -z "$ref" ] || [ ! -e "$ref" ]; then
    ref=$commondir/packed-refs
fi

stamp=0
upfile=""
text=""
if [ -e "$cache" ]; then
    { IFS= read -r stamp; IFS= read -r upfile; IFS= read -r text; } < "$cache" 2>/dev/null
fi

state_same=0
if [ -e "$cache" ] && [ "$cache" -nt "$headfile" ]; then
    state_same=1
    if [ -e "$ref" ] && [ ! "$cache" -nt "$ref" ]; then
        state_same=0
    fi
    if [ -n "$upfile" ] && [ -e "$upfile" ] && [ ! "$cache" -nt "$upfile" ]; then
        state_same=0
    fi
fi

now=${EPOCHSECONDS:-$(date +%s)}
case "$stamp" in ''|*[!0-9]*) stamp=0 ;; esac
age=$((now - stamp))

render() {
    cd "$root" || return 0
    local status logline rel up reflog line dirty=0 esc=$'\033' t="" push=""

    status=$(git status --porcelain=v2 2>/dev/null)
    while IFS= read -r line; do
        [ -n "$line" ] && dirty=$((dirty + 1))
    done <<< "$status"

    logline=$(git log -1 --format='%cr' 2>/dev/null)
    rel=$logline

    up=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
    upfile=""
    if [ -n "$up" ]; then
        local upref=$commondir/refs/remotes/$up
        if [ -e "$upref" ]; then
            upfile=$upref
        elif [ -e "$commondir/packed-refs" ]; then
            upfile=$commondir/packed-refs
        fi
        reflog=$(git reflog show --date=relative "$up" 2>/dev/null)
        while IFS= read -r line; do
            case "$line" in
                *"update by push"*)
                    line=${line#*@\{}
                    push=$(short_rel "${line%%\}*}")
                    break
                    ;;
            esac
        done <<< "$reflog"
    fi

    if [ -n "$rel" ]; then
        t="${esc}[1;36m󰜘${esc}[0m $(short_rel "$rel")"
    fi
    if [ -n "$push" ]; then
        [ -n "$t" ] && t+="  "
        t+="${esc}[1;35m󰕒${esc}[0m ${push}"
    fi
    if [ "$dirty" -gt 0 ]; then
        [ -n "$t" ] && t+="  "
        t+="${esc}[1;33m󰏫${esc}[0m ${dirty}"
    fi

    printf '%s\n%s\n%s' "${EPOCHSECONDS:-$(date +%s)}" "$upfile" "$t" > "$cache"
    rm -f "$cache.lock"
    text=$t
}

if [ "$state_same" = 1 ] && [ "$age" -lt "$ttl" ]; then
    printf '%s' "$text"
    exit 0
fi

lock=$cache.lock
if [ -e "$lock" ]; then
    lstamp=""
    IFS= read -r lstamp < "$lock" 2>/dev/null
    case "$lstamp" in ''|*[!0-9]*) lstamp=0 ;; esac
    if [ $((now - lstamp)) -gt 30 ]; then
        rm -f "$lock"
    fi
fi

if [ "$state_same" = 1 ]; then
    if (set -o noclobber; printf '%s' "$now" > "$lock") 2>/dev/null; then
        ( render ) >/dev/null 2>&1 </dev/null &
    fi
    printf '%s' "$text"
    exit 0
fi

if (set -o noclobber; printf '%s' "$now" > "$lock") 2>/dev/null; then
    render >/dev/null 2>&1
fi
printf '%s' "$text"
exit 0
