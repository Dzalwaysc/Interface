/***********************************************************
 ** 问题: 打开Interface之后，直接关闭，报错:"Interface"意外退出
 ** 解决: 将QQmlApplicationEngine engine; 改为
 **        QQmlApplicationEngine *engine;
**********************************************************/

#include <QApplication>
#include <QQmlApplicationEngine>
#include "slavethread.h"                // 串口
#include "clientthread.h"               // TCP客户端
#include "fortuneserver.h"              // TCP服务端
#include "udpclass.h"                   // UDP
#include "simulationthread.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    qmlRegisterType<SlaveThread>("io.serialport", 1, 0, "Comm");
    qmlRegisterType<ClientThread>("io.tcpclient", 1, 0, "TcpClient");
    qmlRegisterType<FortuneServer>("io.tcpserver", 1, 0, "TcpServer");
    qmlRegisterType<udpClass>("io.udp", 1, 0, "Udp");
    qmlRegisterType<SimulationThread>("io.simulation", 1, 0, "Simulation");

    QQmlApplicationEngine* engine = new QQmlApplicationEngine;
    engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine->rootObjects().isEmpty())
        return -1;

    qDebug()<<"main thread: " << QThread::currentThreadId();
    return app.exec();
}
