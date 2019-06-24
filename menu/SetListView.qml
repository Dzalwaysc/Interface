import QtQuick 2.0
import QtGraphicalEffects 1.0
Item {
    id: set

    property real posX: 0
    property real posY: 0
    property real delegate_width: 80
    property real delegate_height: 16

    property real highligth_opacity: 1

    // 暴露给外部使用的属性
    property alias listView: listView

    // 字体
    property string fontfamily: "Monaco"
    property color fontcolor: "black"
    property real fontpixelSize: 15

    // 将simulationMessage暴露给外部使用，因为仿真数据需要传导参数面板和坐标轴上
    property alias simulationMessage: simulationMessage

    // 点击setBtn是，关闭Message窗口
    signal close()

    onClose: {
        simulationMessage.state = "";
    }

    Rectangle{
        id: listView
        x: posX; y: -45 // 最终位置为x:posX y:poxY
        opacity: 1
        width: delegate_width; height: delegate_height
        radius: 2
        //color: "ivory"
        color: "transparent"
        border.color: "white"

        states: [
            State {
                name: "active"
                PropertyChanges {target: listView; opacity: 1; y: posY}
            },
            State {
                name: ""
                PropertyChanges {target: listView; opacity: 0; y: -45}
            }
        ]

        ListModel{
            id: contactModel
            ListElement{name: "仿真"}
        }


        Component{
            id: contactDelegate
            Item{
                id: item
                width: delegate_width; height: delegate_height
                Text {
                    id: contactInfo
                    anchors.centerIn: parent
                    font.family: fontfamily
                    font.pixelSize: fontpixelSize
                    color: "white" //highligth_opacity == 0.1 ? Qt.lighter("black") : Qt.lighter("white") //Qt.lighter("black")
                    text: name
                }
            }
        }

        Component{
            id: highlight
            Rectangle{
                id: high_rect
                width: delegate_width; height: delegate_height-20
                radius: 2.5
                color: "lightsteelblue"
                border.color: "black"
                opacity: highligth_opacity
            }
        }

        ListView{
            id: list
            anchors.fill: parent
            model: contactModel
            delegate: contactDelegate
            highlight: highlight
            highlightFollowsCurrentItem: true
            orientation: ListView.Horizontal
        }

        MouseArea{
            id: mousearea1
            x: 0; y: 0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: listView.opacity == 1
            onEntered: {
                highligth_opacity = 0.1
                list.currentIndex = 0
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        Component.onCompleted: {
            highligth_opacity = 0;
        }
    }

    Glow {
        anchors.fill: listView
        radius: 3             //半径决定辉光的柔和度，半径越大辉光的边缘越模糊  样本值=1+半径*2
        samples: 13           //每个像素采集的样本值，值越大，质量越好，渲染越慢
        color: "#ddd"
        source: Rectangle{
            width: delegate_width; height: delegate_height
            radius: 2
            color: "transparent"
            border.color: "white"
        }
        spread: 0.5           //在光源边缘附近增强辉光颜色的大部分
        opacity: 0.8
    }

    SetSimulationMessage{
        id: simulationMessage
        Connections{
            target: mousearea1
            onClicked: {
                if(simulationMessage.state === "") simulationMessage.state = "active";
                else if(simulationMessage.state === "active") simulationMessage.state = "";
            }
        }
    }

}
