/**
 * 解析控制台传入参数
 *
 * @auth: aszswaz
 * @date: 2022-03-09 22:06:10
 */
#ifndef MESSAGE_OPTIONS
#define MESSAGE_OPTIONS

#include <memory>
#include <QSystemTrayIcon>

using namespace std;

namespace bicycle {
    /**
     * 消息类型
     */
    enum MessageType {
        NONE, DEBUG, INFO, WARN, ERROR
    };

    /**
     * 选项参数
     */
    class Options {
        private:
            /**
             * 消息类型
             */
            MessageType mtype{};
            /**
             * 标题
             */
            char *title{};
            /**
             * 内容
             */
            char *content{};
            /**
             * 消息停留时间
             */
            int time{};

        public:
            // ~Options();

        public:
            void setMtype(MessageType mtype) {
                this->mtype = mtype;
            }

            void setTitle(char *title) {
                this->title = title;
            }

            void setContent(char *content) {
                this->content = content;
            }

            void setTime(int time) {
                this->time = time;
            }

            MessageType getMtype() {
                return this->mtype;
            }

            char *getTitle() {
                return this->title;
            }

            char *getContent() {
                return this->content;
            }

            int getTime() {
                return this->time;
            }
    };

    /**
     * 解析控制台传入参数
     */
    shared_ptr<Options> parseOptions(int argc, char **argv);

    /**
     * 根据日志级别，选择对应图标
     */
    QSystemTrayIcon::MessageIcon switchMIcon(MessageType mtype);
}

#endif
