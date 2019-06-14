#include "simulation.h"

Simulation::Simulation(QObject *parent) :
    QObject (parent)
{
    m_actualX = 0;
    m_actualY = 0;
    m_actualYaw = 0;
    m_txtlist.clear();
    timer = new QTimer(this);

    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
}

float Simulation::actualX()
{
    return m_actualX;
}

float Simulation::actualY()
{
    return m_actualY;
}

float Simulation::actualYaw()
{
    return m_actualYaw;
}

void Simulation::setActualX(float actualX)
{
    m_actualX = actualX;
    emit actualXChanged();
}

void Simulation::setActualY(float actualY)
{
    m_actualY = actualY;
    emit actualYChanged();
}

void Simulation::setActualYaw(float actualYaw)
{
    m_actualYaw = actualYaw;
    emit actualYawChanged();

}

void Simulation::readTxtData()
{
    QFile file("C:/Users/Administrator/Desktop/out.txt");
//    QFile file("/Users/oliver/C++Projects/3Ddemo/out.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        return;
    }

    while(!file.atEnd()){
        m_txtlist.append(file.readLine());
    }

    file.close();
}

void Simulation::runTest()
{
    if(m_txtlist.isEmpty())
        readTxtData();

    timer->start(50);
}

void Simulation::stopTest()
{
    if(timer != nullptr)
        timer->stop();
}

void Simulation::update()
{
    if(!m_txtlist.isEmpty()){
        setActualX(m_txtlist[0].split('\t')[0].toFloat());
        setActualY(m_txtlist[0].split('\t')[1].toFloat());
        setActualYaw(m_txtlist[0].split('\t')[2].toFloat());
        emit updateGo();
        m_txtlist.pop_front();
    }
}
