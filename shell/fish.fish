if status is-interactive
    set WORK_DIR "$PWD"

    set bicycle_path "$HOME/.bicycle"
    cd $bicycle_path/shell
    source alias/index.fish
    source profile.fish

    cd $bicycle_path/bicycle-config/
    source profile.fish

    cd $WORK_DIR
    set -e WORK_DIR bicycle_path
end
