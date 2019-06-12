/**************************
**
**橘子图标
**图标：宽=高=max（主宽*0.0135，主高*0.02）
**
**分别定义四个鼠标区域点击，以弹性动画效果展示
**MySerialPortMessage 定义两个串口信息
***************************/

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: serialportButton
    width: 50
    height: 50
    x: posX; y: posY
    radius: 5
    color:Qt.lighter("#CCC")//"ivory"
    opacity: 0.5
    // 用户属性
    property real posX: 0
    property real posY: 0

    // 当点击了该按钮，该按钮的MouseArea中的onClicked执行完后，发送此信号到外部
    signal trigger()

    states: [
        State {
            name: "hover"
            PropertyChanges { target: serialportButton; opacity:1}
        },
        State {
            name:"active"
            PropertyChanges {target: serialportButton;opacity:1; x: posX-3; y: posY-3}
        }
    ]
    Behavior on opacity { NumberAnimation{duration: 100; easing.type: Easing.Linear}}
    Behavior on x { NumberAnimation{duration: 100; easing.type: Easing.Linear}}
    Behavior on y { NumberAnimation{duration: 100; easing.type: Easing.Linear}}

    Image {
        anchors.fill: parent
        source: "image/serialBtn.png"
    }

    MouseArea{
        id: mouse
        anchors.fill: parent
        enabled: true
        hoverEnabled: true
        onClicked: {
            if(serialportButton.state === "hover"){
                serialportButton.state = "active"
            }else if (serialportButton.state === "active" ){
                serialportButton.state = "hover";
            }
            trigger();
        }
        onEntered: {
            if(serialportButton.state === "") serialportButton.state = "hover";
        }
        onExited: {
            if(serialportButton.state === "hover") serialportButton.state = "";
        }
    }
}
