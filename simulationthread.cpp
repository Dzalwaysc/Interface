#include "simulationthread.h"

SimulationThread::SimulationThread(QObject *parent)
    : QObject (parent)
{
    m_thread = new QThread;
    m_simulate.moveToThread(m_thread);
    connect(this, &SimulationThread::simulationRun, &m_simulate, &Simulation::onSimulationRun);
    connect(this, &SimulationThread::simulationStop, &m_simulate, &Simulation::onSimulationStop);
    connect(this, &SimulationThread::simulationReset, &m_simulate, &Simulation::onSimulationReset);
    connect(&m_simulate, &Simulation::dataUpdate, this, &SimulationThread::onDataUpdate);
    m_thread->start();
}

SimulationThread::~SimulationThread()
{
    // 问题: QObject::killTimer: Timers cannot be stopped from another thread
    //      QObject::~QObject: Timers cannot be stopped from another thread
    // 解决方法如下
    if(!m_thread->isFinished()){ // 对应打开仿真后，直接关闭
        emit simulationStop();
        QThread::sleep(1);
        m_thread->quit();
        m_thread->wait();
    }else { // 对应打开仿真后，按了停止，再关闭
        m_thread->start();
        emit simulationStop();
        QThread::sleep(1);
        m_thread->quit();
        m_thread->wait();
    }
    qDebug()<<"simulationThread is finished";
}

void SimulationThread::run()
{
    // 如果线程被关闭了，则先打开线程
    if(m_thread->isFinished()){
        m_thread->start();
    }

    // 如果线程已打开，则发射run信号
    if(m_thread->isRunning()){
        emit simulationRun();
    }
}

void SimulationThread::stop()
{
    // 如果线程已打开，则发射stop信号
    if(m_thread->isRunning()){
        emit simulationStop();
        m_thread->quit();
        m_thread->wait();
    }
}

void SimulationThread::reset()
{
    if(m_thread->isRunning()){
        emit simulationReset();
        m_thread->quit();
        m_thread->wait();
    }

    if(m_thread->isFinished()){
        m_thread->start();
        emit simulationReset();
        m_thread->quit();
        m_thread->wait();
    }
}

void SimulationThread::onDataUpdate(std::vector<double> data)
{
    m_x = data[0];
    m_y = data[1];
    m_yaw = data[2];
    m_u = data[3];
    m_v = data[4];
    m_r = data[5];
    emit shipDataUpdate();
}

// qml属性方法
double SimulationThread::x()
{
    return m_x;
}

double SimulationThread::y()
{
    return m_y;
}

double SimulationThread::yaw()
{
    return m_yaw;
}

double SimulationThread::u()
{
    return m_u;
}

double SimulationThread::v()
{
    return m_v;
}

double SimulationThread::r()
{
    return m_r;
}

