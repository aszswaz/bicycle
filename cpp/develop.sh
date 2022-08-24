WORKING_DIR="$PWD"

cd "$(dirname $0)"

alias make="env -C $PWD/build make"

for module in build/src/*; do
    module_path="$(realpath $module)"
    [[ ! $PATH =~ $module_path ]] && PATH="$module_path:$PATH"
done

cd "$WORKING_DIR"
unset WORKING_DIR
