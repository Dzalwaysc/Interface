#ifndef FORTUNESERVER_H
#define FORTUNESERVER_H

#include <QTcpServer>
#include <QHostAddress>
#include "fortunethread.h"
class FortuneServer : public QTcpServer
{
    Q_OBJECT
    Q_PROPERTY(QString hostName READ hostName WRITE sethostName NOTIFY hostNameChanged)
    Q_PROPERTY(int port READ port WRITE setport NOTIFY portChanged)

public:
    FortuneServer(QObject *parent = nullptr);

protected:
    void incomingConnection(qintptr socketDescriptor) Q_DECL_OVERRIDE;

public:
    Q_INVOKABLE void startListen(QString hostName, int port);
    Q_INVOKABLE void closeListen();
    int m_port;
    QString m_hostName;

signals:
    void hostNameChanged();
    void portChanged();

public:
    QString hostName();
    int port();
    void sethostName(const QString &hostName);
    void setport(int port);
};

#endif // FORTUNESERVER_H
