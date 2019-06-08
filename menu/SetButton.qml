/****************************************************************************
**设置按钮  （预留）
**用户属性：
       posX和posY就是x和y 为了令其在active状态下能够移动，定义了这两个属性
**信号：
       shadowTrig()
       用于Dropshadow连接，在相应的DropShadow的Connection中被使用
****************************************************************************/

import QtQuick 2.0

Rectangle{
    id: setButton
    radius: 5
    x: posX; y: posY
    width: 50
    height:50
    color: "ivory"
    opacity: 0.5

    // 定义这两个属性是因为我们要在该Btn激活的时候，让它的位置移动
    property real posX: 0
    property real posY: 0

    // 当点击了该按钮，该按钮的MouseArea中的onClicked执行完后，发送此信号到外部
    signal trigger()

    states: [
        State {
            name: "hover"
            PropertyChanges { target: setButton; opacity:1}

        },
        State {
            name:"active"
            PropertyChanges {target: setButton;opacity:1; x: posX-3; y: posY-3}
        }
    ]
    Behavior on opacity { NumberAnimation{duration: 100; easing.type: Easing.Linear}}
    Behavior on x { NumberAnimation{duration: 100; easing.type: Easing.Linear}}
    Behavior on y { NumberAnimation{duration: 100; easing.type: Easing.Linear}}

    Image {
        id: setImage
        source: "image/setBtn.png"
        anchors.fill: parent
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        enabled: true
        hoverEnabled: true
        onClicked: {
            if(setButton.state === "hover") setButton.state = "active";
            else if (setButton.state === "active" ) setButton.state = "hover";
            trigger();
        }
        onEntered: {
            if(setButton.state === "") setButton.state = "hover";
        }
        onExited: {
            if(setButton.state == "hover") setButton.state = "";
        }
    }
}

