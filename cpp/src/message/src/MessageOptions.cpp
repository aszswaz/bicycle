/**
 * 解析控制台传入参数
 */

#include "MessageOptions.h"
#include <string>
#include <string.h>
#include <stdexcept>
#include <iostream>

using namespace std;

namespace bicycle {
    /**
     * 根据字符串获取消息类型对应的枚举
     */
    MessageType switchMtype(char *str) {
        if (!strcmp(str, "none")) {
            return MessageType::NONE;
        } else if (!strcmp(str, "debug")) {
            return MessageType::DEBUG;
        } else if (!strcmp(str, "info")) {
            return MessageType::INFO;
        } else if (!strcmp(str, "warn")) {
            return MessageType::WARN;
        } else if (!strcmp(str, "error")) {
            return MessageType::ERROR;
        } else {
            string message = "Unknown message type: ";
            message.append(str);
            throw runtime_error(message);
        }
    }

    /**
     * 获取选项的值
     */
    char *getOptValue(char **argv, int argc, int i) {
        char *option = argv[i];
        i++;
        if (i == argc) {
            string message = "Invalid value for option ";
            message.append(option).append(".");
            throw runtime_error(message);
        }
        return argv[i];
    }

    /**
     * 将传入参数解析为结构体
     */
    shared_ptr<Options> parseOptions(int argc, char **argv) {
        shared_ptr<Options> options(new Options);
        for (int i = 1; i < argc; i++) {
            char *option = argv[i];
            if (!strncmp(option, "--", 2)) {
                option += 2;

                if (!strcmp(option, "mtype")) {
                    options->setMtype(switchMtype(getOptValue(argv, argc, i++)));
                } else if (!strcmp(option, "title")) {
                    options->setTitle(getOptValue(argv, argc, i++));
                } else if (!strcmp(option, "content")) {
                    options->setContent(getOptValue(argv, argc, i++));
                } else if (!strcmp(option, "time")) {
                    options->setTime(stoi(getOptValue(argv, argc, i++)));
                } else {
                    string message = "Unknown option: ";
                    option -= 2;
                    message.append(option);
                    throw runtime_error(message);
                }
            }
        }
        return options;
    }

    /**
     * 根据日志级别，选择对应图标
     */
    QSystemTrayIcon::MessageIcon switchMIcon(MessageType mtype) {
        switch (mtype) {
        case NONE:
        case MessageType::DEBUG:
        case MessageType::INFO:
            return QSystemTrayIcon::Information;
        case MessageType::WARN:
            return QSystemTrayIcon::Warning;
        case MessageType::ERROR:
            return QSystemTrayIcon::Critical;
        default:
            throw logic_error("Unknown MessageType enumeration.");
        }
    }
}
