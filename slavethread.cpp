/**************************
**
** #include <QSerialPort>
** 需要在.pro文件中加上一句:
**        QT += serialport
**
***************************/

#include "slavethread.h"

#include <QSerialPort>
#include <QTime>
#include <QDebug>

SlaveThread::SlaveThread(QObject *parent) :
    QThread(parent),
    standardOutput(stdout)
{
}

SlaveThread::~SlaveThread()
{
    m_mutex.lock();
    m_quit = true;
    m_mutex.unlock();
    wait();
}

void SlaveThread::startSlave(const QString &portName, int waitTimeout, const QString &response)
{
    const QMutexLocker locker(&m_mutex);
    m_portName = portName;
    m_waitTimeout = waitTimeout;
    m_response = response;
    m_quit = false;

    if(!isRunning())
        start();
    else
        m_cond.wakeOne();
}

void SlaveThread::run()
{
    bool currentPortNameChanged = false;

    m_mutex.lock();
    QString currentPortName;
    if(currentPortName != m_portName){
        currentPortName = m_portName;
        currentPortNameChanged = true;
    }

    int currentWaitTimeout = m_waitTimeout;
    QString currentRespone = m_response;
    m_mutex.unlock();

    QSerialPort serial;
    serial.setBaudRate(QSerialPort::Baud9600);
    serial.setDataBits(QSerialPort::Data8);
    serial.setStopBits(QSerialPort::OneStop);
    serial.setParity(QSerialPort::NoParity);

    while(!m_quit){
        if(currentPortNameChanged){
            serial.close();
            serial.setPortName(currentPortName);

            if(!serial.open(QIODevice::ReadWrite)){
                emit error(tr("Can't open %1, error code %2")
                           .arg(m_portName)
                           .arg(serial.error() ));
                return;
            }
        }

        if(serial.waitForReadyRead(currentWaitTimeout)){
            //read request
            QByteArray requestData = serial.readAll();
            while(serial.waitForReadyRead(10))
                requestData += serial.readAll();
            //show request
            standardOutput << requestData << endl;

            //write response
            const QByteArray responseData = currentRespone.toUtf8();
            serial.write(responseData);
            if(serial.waitForBytesWritten(m_waitTimeout)){
                const QString request = QString::fromUtf8(requestData);
                emit this->request(request);
            }else{
                emit timeout(tr("Wait write response timeout %1")
                             .arg(QTime::currentTime().toString() ));
            }
        }else{
            emit timeout(tr("Wait read request timeout %1")
                         .arg(QTime::currentTime().toString() ));
        }

        m_mutex.lock();
        if(currentPortName != m_portName){
            currentPortName = m_portName;
            currentPortNameChanged = true;
        }else{
            currentPortNameChanged = false;
        }
        currentWaitTimeout = m_waitTimeout;
        currentRespone = m_response;
        m_mutex.unlock();
    }
}

// property函数
QString SlaveThread::portName()
{
    return m_portName;
}

int SlaveThread::waitTimeout()
{
    return m_waitTimeout;
}

QString SlaveThread::response()
{
    return m_response;
}

QByteArray SlaveThread::recvMsg()
{
    return m_recvMsg;
}

void SlaveThread::setportName(const QString &portName)
{
    if(portName == m_portName)
        return;
    m_portName = portName;
    emit portNameChanged();
}

void SlaveThread::setwaitTimeout(int waitTimeout)
{
    if(waitTimeout == m_waitTimeout)
        return;
    m_waitTimeout = waitTimeout;
    emit waitTimeoutChanged();
}

void SlaveThread::setresponse(const QString &response)
{
    if(m_response == response)
        return;
    m_response = response;
    emit responseChanged();
}

void SlaveThread::suspendSlave()
{
    m_cond.wait(&m_mutex);
    m_recvMsg = "Hi";
}
