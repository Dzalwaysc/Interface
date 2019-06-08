/**************************
**
** #include <QSerialPort>
** 需要在.pro文件中加上一句:
**        QT += serialport
**
***************************/

#include "slavethread.h"

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

void SlaveThread::startSlave(const QString &portName, const QString &response)
{
    const QMutexLocker locker(&m_mutex);
    m_portName = portName;
    m_response = response;
    m_quit = false;

    if(!isRunning())
        start();
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

    int Timeout = 5*1000;
    QString currentRespone = m_response;
    m_mutex.unlock();


    m_serial.setBaudRate(QSerialPort::Baud9600);
    m_serial.setDataBits(QSerialPort::Data8);
    m_serial.setStopBits(QSerialPort::OneStop);
    m_serial.setParity(QSerialPort::NoParity);

    while(!m_quit){
        if(currentPortNameChanged){
            m_serial.close();
            m_serial.setPortName(currentPortName);

            if(!m_serial.open(QIODevice::ReadWrite)){
                emit error(tr("Can't open %1, error code %2")
                           .arg(m_portName)
                           .arg(m_serial.error() ));
                return;
            }
        }

        if(m_serial.waitForReadyRead(Timeout)){
            //read request
            QByteArray requestData = m_serial.readAll();
            while(m_serial.waitForReadyRead(10))
                requestData += m_serial.readAll();
            //show request
            standardOutput << requestData << endl;
            m_recvMsg = requestData;
            emit this->recvMsgChanged();
            //write response
            const QByteArray responseData = currentRespone.toUtf8();
            m_serial.write(responseData);
            if(!m_serial.waitForBytesWritten(Timeout)){
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

        currentRespone = m_response;
        m_mutex.unlock();
    }
}

// property函数
QString SlaveThread::portName()
{
    return m_portName;
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

void SlaveThread::setresponse(const QString &response)
{
    if(m_response == response)
        return;
    m_response = response;
    emit responseChanged();
}

void SlaveThread::closeSlave()
{
    m_mutex.lock();
    m_quit = true;
    m_mutex.unlock();
    wait();
}

void SlaveThread::sendResponse()
{
    //write response
    const QByteArray responseData = "currentRespone.toUtf8()";
    m_serial.write(responseData);
}
