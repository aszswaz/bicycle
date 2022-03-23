#include <iostream>
#include <memory>
#include <QApplication>
#include "./src/NotifyUser.h"

using namespace std;
using namespace bicycle;

int main(int argc, char **argv) {
    try {
        // 解析传入参数
        shared_ptr<Options> options = parseOptions(argc, argv);
        QApplication application(argc, argv);

        // 通知用户
        notifyMessage(options);

        return EXIT_SUCCESS;
    } catch (exception &e) {
        std::cerr << "\033[31m" << e.what() << "\033[0m" << std::endl;
        return EXIT_FAILURE;
    }
}
