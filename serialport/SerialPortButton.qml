import QtQuick 2.0
import "../button"

Item {
    id: item

    property string circleInterSource: "image/circleInter1.png"
    property string circleOuterSource: "image/circleOuter.png"

    property alias circleOuter: circleOuter

    signal dialogOn()
    signal dialogOff()

    property alias circleInter: circleInter
    property alias dialog1: dialog1
    property alias dialog2: dialog2
    property alias dialog3: dialog3
    property alias circleInterMouse: circleInterMouse
    property alias heartTimer: heartTimer

    states: [
        State {
            name: ""
            PropertyChanges {target: circleInter; scale: 1; opacity: 0.5}
            PropertyChanges {target: circleOuter; opacity:0}
        },
        State {
            name: "hover_non"
            PropertyChanges {target: circleInter; scale: 1; opacity: 1}
            PropertyChanges {target: circleOuter; opacity:0}
        },
        State {
            name: "active"
            PropertyChanges {target: circleInter; scale: 1; opacity:1}
            PropertyChanges {target: circleOuter; opacity:1}
        },
        State {
            name: "hover_active"
            PropertyChanges {target: circleInter; scale: 1; opacity:1}
            PropertyChanges {target: circleOuter; opacity:1}
        }
    ]

    Image{
        id: circleOuter
        opacity: 0
        width: 38; height: 38
        anchors.centerIn: parent
        source: circleOuterSource
    }

    Image{
        id: circleInter
        width: 30; height: 30
        opacity: 0.5
        anchors.horizontalCenter: circleOuter.horizontalCenter
        anchors.verticalCenter: circleOuter.verticalCenter
        source: circleInterSource

        signal leftClicked
        signal rightClicked
        MouseArea{
            id: circleInterMouse
            anchors.fill: parent
            enabled: parent.opacity == 0.5 || parent.opacity == 1 ? true : false
            hoverEnabled: parent.opacity == 0.5 || parent.opacity == 1 ? true : false
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            // 鼠标进入后，状态必然为"hover_non" 或者 "active"
            onEntered: {
                if(item.state === ""){
                    item.state = "hover_non";
                }
            }

            // 在鼠标移出后，状态必然为"" 或者 "active"
            onExited: {
                if(item.state === "hover_non" || item.state === "" ){
                    item.state = "";
                }
            }

            // 鼠标左键点击，将状态变成"" 或者 "active"
            // 鼠标右键点击，当前状态不改变
            onClicked: {
                // 如果状态转成""，无论如何关闭定时发送
                // 无论如何都做一次点击动画
                // 无论如何关闭对话框
                if(mouse.button === Qt.LeftButton){
                    if(item.state === "" || item.state === "hover_non"){
                        item.state = "active"
                    }else if(item.state === "active"){
                        item.state = ""
                        dialog2.btnText = "定时发送"
                    }
                    clickAnimation.start(); // 开始点击的动画
                    dialogOpacity = 0; // 关闭对话框
                    dialogOff(); // 发送给SerialPortList
                    circleInter.leftClicked(); // 发送给SerialPort
                }

                // 鼠标右键，弹出信息框或者关闭信息框
                else if(mouse.button === Qt.RightButton){
                    if(dialogOpacity == 0){
                        dialogOpacity = 1;
                        dialogOn();
                    }else{
                        dialogOpacity = 0;
                        dialogOff();
                    }

                    circleInter.rightClicked();
                }
            }
        }
    }

    // 点击动画
    SequentialAnimation{
        id: clickAnimation
        running: false
        ParallelAnimation{
            NumberAnimation { target: circleInter; property: "scale"; duration: 100; from: 1; to:0.8 }
            NumberAnimation { target: circleOuter; property: "scale"; duration: 100; from: 1; to:0.8 }
        }
        ParallelAnimation{
            NumberAnimation { target: circleInter; property: "scale"; duration: 100; from: 0.8; to:1}
            NumberAnimation { target: circleOuter; property: "scale"; duration: 100; from: 0.8; to:1}
        }
    }

    // 激活后的旋转
    Timer{
        id: rotationTimer
        running: dialogOpacity == 0 && item.state === "active" ? true : false
        repeat: true; interval: 250;
        onTriggered: {
            var rotation = circleOuter.rotation;
            rotation = (rotation + 5) % 360;
            circleOuter.rotation = rotation;
        }
    }


    // 右键弹出的对话框
    // 点击一次后，就消失
    property double dialogOpacity: 0

    // 信息选项按钮
    ButtonOne{
        id: dialog1
        color: "transparent"
        border.color: "white"
        opacity: dialogOpacity
        btnText: "信息选项"
        anchors.left: circleOuter.right
        anchors.top: circleOuter.top
        btnWidth: 60
        onClicked: {
            dialogOpacity = 0;
            dialogOff();
        }
    }

    // 定时发送按钮
    ButtonOne{
        id: dialog2
        color: "transparent"
        border.color: "white"
        opacity: dialogOpacity
        btnText: "定时发送"
        anchors.left: circleOuter.right
        anchors.top: dialog1.bottom; anchors.topMargin: 5
        btnWidth: 60

        // 左键点击，如果当前状态为激活状态，这可以控制，否则不可以控制
        signal dialog2Clicked();
        onClicked: {
            dialogOpacity = 0;
            dialogOff();
            if(item.state === "active"){
                if(dialog2.btnText == "定时发送"){
                    dialog2.btnText = "关闭定时"
                }else{
                    dialog2.btnText = "定时发送"
                }
                dialog2Clicked()
            }
        }
    }

    // 发送按钮
    ButtonOne{
        id: dialog3
        color: "transparent"
        border.color: "white"
        opacity: dialogOpacity
        btnText: "发送"
        anchors.left: circleOuter.right
        anchors.top: dialog2.bottom; anchors.topMargin: 5
        btnWidth: 60

        // 左键点击，如果当前状态为激活状态，这可以控制，否则不可以控制
        signal dialog3Clicked();

        onClicked: {
            if(item.state === "active"){
                dialog3Clicked()
            }
        }
    }


    // 心跳动画
    SequentialAnimation{
        id: heartBeat
        running: false
        ParallelAnimation{
            NumberAnimation { target: circleOuter; property: "scale"; duration: 100; from: 1; to:1.3}
        }
        ParallelAnimation{
            NumberAnimation { target: circleOuter; property: "scale"; duration: 100; from: 1.3; to:1}
        }
    }

    // 用来控制心跳动画
    Timer{
        id: heartTimer
        running: false;
        repeat: false;
        onTriggered: heartBeat.start();
    }

}
