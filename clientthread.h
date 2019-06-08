#ifndef ClientThread_H
#define ClientThread_H

#include <QThread>
#include <QMutex>
#include <QWaitCondition>
#include <QtNetwork>

class ClientThread : public QThread
{
    Q_OBJECT
    Q_PROPERTY(QString hostName READ hostName WRITE sethostName NOTIFY hostNameChanged)
    Q_PROPERTY(int port READ port WRITE setport NOTIFY portChanged)
public:
    ClientThread(QObject *parent = nullptr);
    ~ClientThread() override;

    Q_INVOKABLE void requestFortune(const QString &hostName, quint16 port);
    Q_INVOKABLE void closeFortune();
    void run() override;

signals:
    void error(int socketError, const QString &message);
    void hostNameChanged();
    void portChanged();

private:
    QString m_hostName;
    int m_port;
    QMutex m_mutex;
    bool m_quit;

public:
    QString hostName();
    int port();
    void sethostName(const QString &hostName);
    void setport(int port);
};

#endif // ClientThread_H
