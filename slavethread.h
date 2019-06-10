#ifndef SLAVETHREAD_H
#define SLAVETHREAD_H

#include <QThread>
#include <QSerialPort>

class SlaveThread : public QThread
{
    Q_OBJECT

    Q_PROPERTY(QString portName READ portName WRITE setportName NOTIFY portNameChanged)
    Q_PROPERTY(QByteArray response READ response WRITE setresponse NOTIFY responseChanged)
    Q_PROPERTY(QByteArray recvMsg READ recvMsg NOTIFY recvMsgChanged)

public:
    explicit SlaveThread(QObject *parent = nullptr);
    ~SlaveThread() override;

    Q_INVOKABLE void startSlave();
    Q_INVOKABLE void closeSlave();
    Q_INVOKABLE void sendResponse();

private slots:
    void handleReadyRead();
    void handleError(QSerialPort::SerialPortError error);
    void handleBytesWritten(qint64 bytes);

private:
    QSerialPort m_serial;

    QString m_portName;
    QByteArray m_response;
    QByteArray m_recvMsg;
    qint64 m_bytesWritten = 0;
signals:
    // 属性信号
    void portNameChanged();
    void responseChanged();
    void recvMsgChanged();

public:
    // 属性函数
    QString portName();
    void setportName(const QString &portName);
    QByteArray response();
    void setresponse(const QByteArray &response);
    QByteArray recvMsg();
};

#endif // SLAVETHREAD_H
