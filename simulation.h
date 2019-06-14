/*********************************************************
** 仿真类
** 连接:
**      QTimer::timeout()信号和槽函数update()
**   --> connect(timer, SIGNAL(timeout()), this, SLOT(update()));
** qml接口:
**      属性: actualX, actualY, actualYaw
**      方法: runTest(), stopTest()
** 函数介绍:
**   runTest():
**      1. 首先读取.txt文件中的数据，将其放入m_textlist中
**          m_textlist每一行都是一次仿真迭代数据
**      2. 然后激活update()
**          update()中，每次给qml属性赋值m_textlist第一行的数据，然后将其删除
**   stopTest():
**      1. 停止定时器
*********************************************************/

#ifndef Simulation_H
#define Simulation_H

#include <QObject>
#include <QString>
#include <QTimer>
#include <QFile>

class Simulation : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float actualX READ actualX WRITE setActualX NOTIFY actualXChanged)
    Q_PROPERTY(float actualY READ actualY WRITE setActualY NOTIFY actualYChanged)
    Q_PROPERTY(float actualYaw READ actualYaw WRITE setActualYaw NOTIFY actualYawChanged)


public:
    explicit Simulation(QObject *parent = nullptr);

    float actualX();
    float actualY();
    float actualYaw();

    void setActualX(float actualX);
    void setActualY(float actualY);
    void setActualYaw(float actualYaw);

signals:
    void actualXChanged();
    void actualYChanged();
    void actualYawChanged();
    void updateGo();

private:
    float m_actualX;
    float m_actualY;
    float m_actualYaw;

public:
    void readTxtData(); // 读取文本数据
    QList<QByteArray> m_txtlist;

    // 测试
    QTimer *timer;
    Q_INVOKABLE void runTest();
    Q_INVOKABLE void stopTest();
    private slots: void update();
};

#endif // Simulation_H
