#include "vehicleactualparameter.h"

VehicleActualParameter::VehicleActualParameter(QObject *parent) :
    QObject (parent)
{
    m_actualX = 0;
    m_actualY = 0;
    m_actualYaw = 0;
    m_txtlist.clear();
    timer = new QTimer(this);

    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
}

float VehicleActualParameter::actualX()
{
    return m_actualX;
}

float VehicleActualParameter::actualY()
{
    return m_actualY;
}

float VehicleActualParameter::actualYaw()
{
    return m_actualYaw;
}

void VehicleActualParameter::setActualX(float actualX)
{
    m_actualX = actualX;
    emit actualXChanged();
}

void VehicleActualParameter::setActualY(float actualY)
{
    m_actualY = actualY;
    emit actualYChanged();
}

void VehicleActualParameter::setActualYaw(float actualYaw)
{
    m_actualYaw = actualYaw;
    emit actualYawChanged();

}

void VehicleActualParameter::readTxtData()
{
    QFile file("C:/Users/Administrator/Desktop/X/zhu/Qt/3Ddemo/out.txt");
//    QFile file("/Users/oliver/C++Projects/3Ddemo/out.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        return;
    }

    while(!file.atEnd()){
        m_txtlist.append(file.readLine());
    }

    file.close();
}

void VehicleActualParameter::runTest()
{
    if(m_txtlist.isEmpty())
        readTxtData();

    timer->start(50);
}

void VehicleActualParameter::stopTest()
{
    if(timer != nullptr)
        timer->stop();
}

void VehicleActualParameter::update()
{
    if(!m_txtlist.isEmpty()){
        setActualX(m_txtlist[0].split('\t')[0].toFloat());
        setActualY(m_txtlist[0].split('\t')[1].toFloat());
        setActualYaw(m_txtlist[0].split('\t')[2].toFloat());
        m_txtlist.pop_front();
    }
}
