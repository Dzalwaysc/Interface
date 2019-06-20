#ifndef Simulation_H
#define Simulation_H

#include <QString>
#include <QTimer>
#include <QDebug>
#include <QFile>
#include <iostream>

class Simulation : public QObject
{
    Q_OBJECT

public:
    explicit Simulation(QObject *parent = nullptr);
    ~Simulation();
public:
    void readTxtData(); // 读取文本数据
    QList<QByteArray> m_txtlist;
    std::vector<double> m_data;
    QTimer *m_timer;

signals:
    void dataUpdate(std::vector<double> data);

public slots:
    void onSimulationRun();
    void onSimulationStop();
    void onSimulationReset();
    void onTimeout();
};

#endif // Simulation_H
