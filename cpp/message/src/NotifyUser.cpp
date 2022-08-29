/**
 * 将信息通知给用户
 */

#include "./NotifyUser.h"
#include <QSystemTrayIcon>
#include <QApplication>
#include "./MessageOptions.h"

using namespace bicycle;
using namespace std;

namespace bicycle {

    /**
     * 通知用户信息
     */
    void notifyMessage(shared_ptr<Options> options) {
        QSystemTrayIcon mtray;
        mtray.setVisible(true);
        mtray.show();
        mtray.showMessage(
            QApplication::tr(options->getTitle()),
            QApplication::tr(options->getContent()),
            switchMIcon(options->getMtype()),
            options->getTime()
        );
    }
}
