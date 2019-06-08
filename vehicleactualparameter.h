#ifndef VEHICLEACTUALPARAMETER_H
#define VEHICLEACTUALPARAMETER_H

#include <QObject>
#include <QString>
#include <QTimer>
#include <QFile>

class VehicleActualParameter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float actualX READ actualX WRITE setActualX NOTIFY actualXChanged)
    Q_PROPERTY(float actualY READ actualY WRITE setActualY NOTIFY actualYChanged)
    Q_PROPERTY(float actualYaw READ actualYaw WRITE setActualYaw NOTIFY actualYawChanged)

public:
    explicit VehicleActualParameter(QObject *parent = nullptr);

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

#endif // VEHICLEACTUALPARAMETER_H
