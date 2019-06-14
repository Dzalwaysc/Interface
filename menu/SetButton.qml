/****************************************************************************
**设置按钮  （预留）
**用户属性：
       posX和posY就是x和y 为了方便在main.qml中直接更改设置其相对位置
**信号：
       trigger()
       用于与其它按钮间的相互作用，
       例如：点击设置按钮，则其它按钮、界面及选项卡应处于关闭状态
            点击其它按钮，设置按钮、界面及其选项卡应处于关闭状态
****************************************************************************/

import QtQuick 2.0

Rectangle{
    id: setButton
    radius: 5
    x: posX; y: posY
    width: 50
    height:50
    color: "transparent"
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
            PropertyChanges {target: setButton; opacity:1; x: posX-3; y: posY-3}
        },
        State {
            name: ""
            PropertyChanges {target: setButton; opacity:0.5}
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

