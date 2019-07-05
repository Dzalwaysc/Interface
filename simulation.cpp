#include "simulation.h"

Simulation::Simulation(QObject *parent) :
    QObject (parent)
{
    m_data.resize(6);
    m_txtlist.clear();
    readTxtData();
}

Simulation::~Simulation()
{
    m_timer->stop();
    qDebug()<<"simulation is finished";

}

void Simulation::readTxtData()
{
    QFile file("/Users/oliver/C++Projects/Interface/out.txt");
    //QFile file("/Users/oliver/C++Projects/Interface/out.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        return;
    }

    while(!file.atEnd()){
        m_txtlist.append(file.readLine());
    }

    file.close();
}

void Simulation::onSimulationRun()
{
    m_timer = new QTimer(this);
    m_timer->start(50);
    connect(m_timer, &QTimer::timeout, this, &Simulation::onTimeout);
}

void Simulation::onSimulationStop()
{
    m_timer->stop();
}

void Simulation::onSimulationReset()
{
    m_timer->stop();
    m_txtlist.clear();
    readTxtData();
}

void Simulation::onTimeout()
{
    if(!m_txtlist.isEmpty()){
        m_data[0] = m_txtlist[0].split('\t')[0].toDouble();
        m_data[1] = m_txtlist[0].split('\t')[1].toDouble();
        m_data[2] = m_txtlist[0].split('\t')[2].toDouble();
        m_data[3] = m_txtlist[0].split('\t')[3].toDouble() * 2;
        m_data[4] = m_txtlist[0].split('\t')[4].toDouble();
        m_data[5] = m_txtlist[0].split('\t')[5].toDouble();
        m_txtlist.pop_front();
        emit dataUpdate(m_data);
    }
}
