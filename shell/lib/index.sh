# 本文件夹下的 shell 脚本，并不作为独立的工具使用，仅仅只是给别的脚本提供通用的function、alias
# author: aszswaz
# date: 2022-03-09 16:15:01

function log_info() {
    echo -e "\033[92m"$@"\033[0m"
}

# 打印错误信息
function log_error() {
    echo -e "\033[91m"$@"\033[0m" >&2
}

# 添加 PATH 变量，主要是避免重复的添加，导致对 PATH 产生了污染，参考 /etc/profile
function append_path() {
    case ":$PATH:" in
    *:"$1":*) ;;

    *)
        PATH="${PATH:+$PATH:}$1"
        ;;
    esac
}

# 使用 pacman 安装软件包
function pacman_install() {
    if command -v "pacman" >>/dev/null 2>&1; then
        local need_install=()
        local args=($@)
        local local_packages=($(pacman -Qq))

        for item in $args; do
            local is_install=1
            for item02 in $local_packages; do
                if [[ $item == $item02 ]]; then
                    is_install=0
                    break
                fi
            done
            [[ $is_install == 1 ]] && need_install[$((${#need_install[@]} + 1))]=$item
        done

        [[ $need_install != "" ]] && {sudo pacman -Sy --noconfirm $need_install || return 1}
        unset item item02
        return 0
    else
        log_error "pacman not found"
        return 1
    fi
}

# 使用 yay 安装软件包
function yay_install() {
    pacman_install "yay" || return 1

    local local_packages=($(yay -Qq))
    local need_install=()
    local args=($@)

    for item in $args; do
        local is_install=1
        for item02 in $local_packages; do
            if [[ $item == $item02 ]]; then
                is_install=0
                break
            fi
        done
        [[ $is_install == 1 ]] && need_install[$((${#need_install[@]} + 1))]=$item
    done

    [[ $need_install != "" ]] && yay -Sy --noconfirm $need_install
    unset item item02
    return 0
}

# 销毁从本脚本加载的变量和函数
function shell_lib_desyory() {
    unset -f log_error append_path pacman_install yay_install
}
