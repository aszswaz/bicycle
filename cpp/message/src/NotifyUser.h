/**
 * 将消息通过右下角弹窗的形式通知用户
 *
 * @auth: aszswaz
 * @date: 2022-03-10
 */

#ifndef NOTIFY_USER
#define NOTIFY_USER

#include "./MessageOptions.h"

using namespace bicycle;
using namespace std;

namespace bicycle {
    /**
     * 通知用户信息
     */
    void notifyMessage(shared_ptr<Options> options);
}

#endif
