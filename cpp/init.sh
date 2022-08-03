pacman_install cmake make gcc

log_info "Compiling a c++ program..."
# 编译项目
[ -d "./builder" ] || mkdir builder
cd builder/
cmake -DCMAKE_INSTALL_PREFIX="$PROJECT_DIR" ../
make
make install
cd ../
log_info "The C++ program compiles successfully."
