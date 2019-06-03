#ifndef SLAVETHREAD_H
#define SLAVETHREAD_H

#include <QMutex>
#include <QThread>
#include <QWaitCondition>
#include <QTextStream>

class SlaveThread : public QThread
{
    Q_OBJECT

    Q_PROPERTY(QString portName READ portName WRITE setportName NOTIFY portNameChanged)
    Q_PROPERTY(qreal waitTimeout READ waitTimeout WRITE setwaitTimeout NOTIFY waitTimeoutChanged)
    Q_PROPERTY(QString response READ response WRITE setresponse NOTIFY responseChanged)
    Q_PROPERTY(QByteArray recvMsg READ recvMsg NOTIFY recvMsgChanged)

public:
    explicit SlaveThread(QObject *parent = nullptr);
    ~SlaveThread() override;

    Q_INVOKABLE void startSlave(const QString &portName, int waitTimeout, const QString &response);
    Q_INVOKABLE void suspendSlave();

signals:
    // 串口数据处理信号
    void request(const QString &s);
    void error(const QString &s);
    void timeout(const QString &s);

private:
    void run() override;

    QString m_portName;
    QString m_response;
    int m_waitTimeout;
    QMutex m_mutex;
    bool m_quit = false;
    QWaitCondition m_cond;


    QByteArray m_recvMsg;
    QTextStream standardOutput;

signals:
    // 属性信号
    void portNameChanged();
    void waitTimeoutChanged();
    void responseChanged();
    void recvMsgChanged();

public:
    // 属性函数
    QString portName();
    void setportName(const QString &portName);
    int waitTimeout();
    void setwaitTimeout(int waitTimeout);
    QString response();
    void setresponse(const QString &response);
    QByteArray recvMsg();
};

#endif // SLAVETHREAD_H
