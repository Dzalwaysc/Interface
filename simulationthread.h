/*********************************************************
** 仿真类: Simulation
** 线程类: SimulationThread
** 暴露给外部的接口类: SimulationThread
**
** 接口流:
** 1. first: SimulationThread -> run() -> emit: simulationRun()
**    second: -> Simulation -> onSimulationRun() -> 打开定时器 -> onTimeout()
**    third: -> emit: dataUpdate(data) -> SimulationThread -> onDataUpdate(data)
**    fourth: -> emit: shipDataUpdate() -> 外部
** 在此之前，在SimulationThread -> run()中 开启线程
**
** 2. first: SimulationThread -> stop() -> emit: simulationStop()
**    second:  -> Simulation -> onSimulationStop() -> 停止定时器
** 在此之后，在SimulationThread -> stop()中 关闭线程
**
** 3. first: SimulationThread -> reset() -> emit: simulationReset()
**    second:  -> Simulation -> onReset() -> 关闭线程
**             -> qml -> onReset()
** 值得注意的是，在reset过程中，数据是在SimulationThread中直接赋值为0，
**                          没有从Simulation传上来
**
**
** 问题:
**  QObject::~QObject: Timers cannot be stopped from another thread
**  出这个问题的时候，析构函数如下:
**  emit simulationStop();
    m_thread->quit();
    m_thread->wait();
**  原因是这个时候，Simulation中的timer还没停止，析构已完成。
**  因此，进一步分析此时的析构情况：
**   1.如果m_thread已经结束，此时Simulation还没被析构，且m_thread已被关闭，无法主动关闭Simulation中的timer
**   2.如果m_thread正在进行，此时能够主动析构
**   针对这两种情况，有-> 1.先打开m_thread，在通过信号关闭Simulation中的timer，然后再关闭m_thread
**                  -> 2.先关闭Simulaiton中的timer，然后在关闭m_thread.
*********************************************************/

#ifndef SIMULATIONTHREAD_H
#define SIMULATIONTHREAD_H

#include <QtCore>
#include <QThread>
#include <iostream>
#include "simulation.h"

class SimulationThread : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double x READ x)
    Q_PROPERTY(double y READ y)
    Q_PROPERTY(double yaw READ yaw)
    Q_PROPERTY(double u READ u)
    Q_PROPERTY(double v READ v)
    Q_PROPERTY(double r READ r)

public:
    explicit SimulationThread(QObject *parent = nullptr);
    ~SimulationThread();
public:
    Simulation m_simulate;
    QThread *m_thread;

    // 外部使用的方法
    Q_INVOKABLE void run();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void reset();

signals:
    void simulationRun();
    void simulationStop();
    void simulationReset();


public slots:
    void onDataUpdate(std::vector<double> data);

// qml属性方法
public:
    double m_x;   double x();
    double m_y;   double y();
    double m_yaw; double yaw();
    double m_u;   double u();
    double m_v;   double v();
    double m_r;   double r();

signals:
    void shipDataUpdate();
};

#endif // SIMULATIONTHREAD_H
