#include <QApplication>
#include <QQmlApplicationEngine>
#include "slavethread.h"
#include "clientthread.h"
#include "fortuneserver.h"
#include "udpclass.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    qmlRegisterType<SlaveThread>("io.serialport", 1, 0, "Comm");
    qmlRegisterType<ClientThread>("io.tcpclient", 1, 0, "TcpClient");
    qmlRegisterType<FortuneServer>("io.tcpserver", 1, 0, "TcpServer");
    qmlRegisterType<udpClass>("io.udp", 1, 0, "Udp");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
