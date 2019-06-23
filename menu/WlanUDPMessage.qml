import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../button"
import io.udp 1.0

Rectangle{
    id: wlanUDPMessage
    width: 380; height: 200
    color: Qt.rgba(255, 0, 0, .4)
    border.color: fontcolor
    border.width: 1
    opacity: 0
    radius: 4
    x: -380
    y: 230

    property string fontfamily: "Monaco"
    property color fontcolor: "white"
    property real fontpixelSize: 13

    states:  State {
        name: "active"
        PropertyChanges {target: wlanUDPMessage; opacity: 1; x: 4}
    }

    transitions: [
        Transition {
            from: "";  to: "active"; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        },
        Transition {
            from: "active"; to: ""; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        }
    ]

    // 协议类型
    Text {
        id: agreeName
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "协议类型: "
        color: fontcolor
        font.family: fontfamily
        font.pixelSize: fontpixelSize
    }

    Rectangle{
        id:agreeInfo
        width: 100; height: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: agreeName.bottom
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: fontpixelSize
            focus: true
            text: "UDP"
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    // 本地IP
    Text {
        id: localIPName
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 120
        text: "本地IP: "
        color: fontcolor
        font.family: fontfamily
        font.pixelSize: fontpixelSize
    }

    Rectangle{
        id:localIPInfo
        width: 120; height: 20
        anchors.left: parent.left; anchors.leftMargin: 120
        anchors.top: localIPName.bottom
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: fontpixelSize
            focus: true
            text: udp.localHostName
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    // 本地端口
    Text{
        id: localprName
        anchors.top: localIPName.top;
        anchors.left: localIPName.left; anchors.leftMargin: 140
        text: "本地端口: "
        color: fontcolor
        font.family: fontfamily
        font.pixelSize: fontpixelSize
    }

    Rectangle{
        id:localprInfo
        width: 100; height: 20
        anchors.top: localprName.bottom
        anchors.left: localprName.left
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: fontpixelSize
            focus: true
            text: udp.localPort
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    // 目标IP
    Text{
        id: targgetIPName
        anchors.top: localIPInfo.bottom; anchors.topMargin: 10
        anchors.left: localIPInfo.left
        text: "目标IP: "
        color: fontcolor
        font.family: fontfamily
        font.pixelSize: fontpixelSize
    }

    Rectangle{
        id:targetIPInfo
        width: 120; height: 20
        anchors.top: targgetIPName.bottom
        anchors.left: targgetIPName.left
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: fontpixelSize
            focus: true
            text: udp.targetHostName
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    // 目标端口
    Text{
        id: targetprName
        anchors.top: targgetIPName.top;
        anchors.left: targgetIPName.left; anchors.leftMargin: 140
        text: "目标端口: "
        color: fontcolor
        font.family: fontfamily
        font.pixelSize: fontpixelSize
    }

    Rectangle{
        id:targetprInfo
        width: 100; height: 20
        anchors.top: targetprName.bottom
        anchors.left: targetprName.left
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: fontpixelSize
            focus: true
            text: udp.targetPort
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    // 接受框
    Text {
        id: accept
        anchors.top: parent.top; anchors.topMargin: 90
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "网络数据接收: "
        color: fontcolor
        font.family: fontfamily
        font.pixelSize: fontpixelSize
    }

    TextScreen{
        id: recvScreen
        border.color: "black"
        height: 50
        x: 10; y:110
    }

    // 发送框
    Rectangle{
        id:input
        width: 180; height: 25
        x:10; y:170
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            x:10
            anchors.verticalCenter: parent.verticalCenter
            color: fontcolor
            selectByMouse: true
            font.pixelSize: fontpixelSize
            focus: true
            font.family: fontfamily
            text: udp.response
            onAccepted: udp.response = text;
        }
    }

    ButtonOne{
        id: sentButton
        x:195; y:170
        btnWidth: 30; btnHeight: 25
        btnText: "发送"
        onClicked: udp.sendData();
    }

    // 状态栏
    Text{
        id: showName
        x:245; y:105
        text: "未绑定... "
        color: fontcolor
        font.pixelSize: fontpixelSize
        font.family: fontfamily
    }

    // 开始关闭按钮
    ButtonOne{
        id: goButton
        x: 250; y: 125
        btnWidth: 80; btnHeight: 30
        btnText: "连接"
        onClicked: {
            udp.bindSocket();
            showName.text = "已绑定..."
        }
    }

    ButtonOne{
        id: downButton
        x: 250; y:165
        btnWidth: 80; btnHeight: 30
        btnText: "断开连接"
        onClicked: {
            udp.closeSocket();
            showName.text = "未绑定..."
        }
    }

    // UDP对象
    Udp{
        id: udp
        localHostName: "192.168.3.143"
        targetHostName: "192.168.3.154"
        localPort: 8000
        targetPort: 8000
        response: "hello"
    }

    Image {
        id: name
        width: 200; height: 200
        source: "image/bian.png"
        anchors.right: wlanUDPMessage.right
        anchors.rightMargin: -62
        anchors.top: wlanUDPMessage.top
        opacity: 0.15
    }

    Glow {
        anchors.fill: wlanUDPMessage
        radius: 7            //半径决定辉光的柔和度，半径越大辉光的边缘越模糊  样本值=1+半径*2
        samples: 13           //每个像素采集的样本值，值越大，质量越好，渲染越慢
        color: "#ddd"
        source: Rectangle{
            width: 380; height: 200
            radius: 2
            color: "transparent"
            border.color: "white"
        }
        spread: 0.5         //在光源边缘附近增强辉光颜色的大部分
        opacity: wlanUDPMessage.opacity
    }
}
