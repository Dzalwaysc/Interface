import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: control

    // 暴露给外部使用的属性
    property alias listView: listView

    // 将simulationMessage暴露给外部使用，因为仿真数据需要传导参数面板和坐标轴上
    property alias simulationMessage: simulationMessage

    // 点击controlBtn是，关闭Message窗口
    signal close()

    onClose: {
        simulationMessage.state = "";
    }

    ControlList{
        id: listView
    }

    SimulationMessage{
        id: simulationMessage
        Connections{
            target: listView.mousearea1
            onClicked: {
                if(simulationMessage.state === "") simulationMessage.state = "active";
                else if(simulationMessage.state === "active") simulationMessage.state = "";
            }
        }
    }

}
