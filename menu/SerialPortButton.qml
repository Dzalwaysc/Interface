/**************************
** 串口按钮
** 图标：宽=高=50
** 图标三种状态， 空状态"", 悬停状态"hover"， 活动状态"active"
               空状态""————————————透明度为0.5
               悬停状态"hover"——————透明度为1.0
               活动状态"active"——————透明度为1.0，x，y值减三，有个跳动效果，点击感强

    问题：刚开始states中没有写空状态""的State，导致程序运行过程中，悬停状态"hover"和空状态""
         频繁切换下会导致按钮图标透明度一直为1.0，使程序默认空状态下图标透明度为1.0
    解决：在states中补写一个State，关于串口按钮空状态""下的状态
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
    color: "transparent" //"ivory"
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
        },
        State {
            name: ""
            PropertyChanges {target: serialportButton; opacity:0.5}
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
            if(serialportButton.state === "hover") serialportButton.state = "active"
            else if (serialportButton.state === "active" )serialportButton.state = "hover";
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
