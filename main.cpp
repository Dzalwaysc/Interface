#include <QApplication>
#include <QQmlApplicationEngine>
#include "slavethread.h"                // 串口
#include "clientthread.h"               // TCP客户端
#include "fortuneserver.h"              // TCP服务端
#include "udpclass.h"                   // UDP
#include "simulation.h"                 // 仿真测试
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    qmlRegisterType<SlaveThread>("io.serialport", 1, 0, "Comm");
    qmlRegisterType<ClientThread>("io.tcpclient", 1, 0, "TcpClient");
    qmlRegisterType<FortuneServer>("io.tcpserver", 1, 0, "TcpServer");
    qmlRegisterType<udpClass>("io.udp", 1, 0, "Udp");
    qmlRegisterType<Simulation>("io.simulation", 1, 0, "Simulation");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    qDebug()<<"main thread: " << QThread::currentThreadId();
    return app.exec();
}
