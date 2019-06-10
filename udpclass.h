#ifndef UDPCLASS_H
#define UDPCLASS_H

#include <QObject>
#include <QUdpSocket>

class udpClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString localHostName READ localHostName WRITE setlocalHostName NOTIFY localHostNameChanged)
    Q_PROPERTY(int localPort READ localPort WRITE setlocalPort NOTIFY localPortChanged)
    Q_PROPERTY(QString targetHostName READ targetHostName WRITE settargetHostName NOTIFY targetHostNameChanged)
    Q_PROPERTY(int targetPort READ targetPort WRITE settargetPort NOTIFY targetPortChanged)
    Q_PROPERTY(QByteArray response READ response WRITE setresponse NOTIFY responseChanged)
public:
    udpClass(QObject* parent = nullptr);
    void processPendingData();
    Q_INVOKABLE void bindSocket();
    Q_INVOKABLE void closeSocket();
    Q_INVOKABLE void sendData();
private:
    QUdpSocket* udpSocket = nullptr;
    QString m_localHostName;
    int m_localPort;
    QString m_targetHostName;
    int m_targetPort;
    QByteArray m_response;

public:
    QString localHostName();
    int localPort();
    QString targetHostName();
    int targetPort();
    QByteArray response();

    void setlocalHostName(const QString &hostName);
    void settargetHostName(const QString &hostName);
    void setlocalPort(int port);
    void settargetPort(int port);
    void setresponse(const QByteArray &response);
signals:
    void localHostNameChanged();
    void targetHostNameChanged();
    void localPortChanged();
    void targetPortChanged();
    void responseChanged();
};

#endif // UDPCLASS_H
