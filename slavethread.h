#ifndef SLAVETHREAD_H
#define SLAVETHREAD_H

#include <QMutex>
#include <QThread>
#include <QWaitCondition>
#include <QTextStream>
#include <QSerialPort>

class SlaveThread : public QThread
{
    Q_OBJECT

    Q_PROPERTY(QString portName READ portName WRITE setportName NOTIFY portNameChanged)
    Q_PROPERTY(QString response READ response WRITE setresponse NOTIFY responseChanged)
    Q_PROPERTY(QByteArray recvMsg READ recvMsg NOTIFY recvMsgChanged)

public:
    explicit SlaveThread(QObject *parent = nullptr);
    ~SlaveThread() override;

    Q_INVOKABLE void startSlave(const QString &portName, const QString &response);
    Q_INVOKABLE void closeSlave();
    Q_INVOKABLE void sendResponse();

signals:
    // 串口数据处理信号
    void error(const QString &s);
    void timeout(const QString &s);

private:
    void run() override;

    QString m_portName;
    QString m_response;
    QMutex m_mutex;
    bool m_quit = false;

    QSerialPort m_serial;
    QByteArray m_recvMsg;
    QTextStream standardOutput;

signals:
    // 属性信号
    void portNameChanged();
    void responseChanged();
    void recvMsgChanged();

public:
    // 属性函数
    QString portName();
    void setportName(const QString &portName);
    QString response();
    void setresponse(const QString &response);
    QByteArray recvMsg();
};

#endif // SLAVETHREAD_H
