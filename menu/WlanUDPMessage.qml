import QtQuick 2.0
import "../button"
import io.udp 1.0

Rectangle{
    id: wlanUDPMessage
    width: 380; height: 200
    color: "ivory"
    border.color: "black"
    border.width: 2
    opacity: 0
    radius: 4
    x: -380
    y: 10

    property string fontfamily: "Monaco"
    property color fontcolor: "black"


    states:  State {
        name: "active"
        PropertyChanges {target: wlanUDPMessage; opacity: 1; x: -2}
    }

    transitions: [
        Transition {
            from: "";  to: "active"; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 500; easing.type: Easing.Linear}
        },
        Transition {
            from: "active"; to: ""; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 150; easing.type: Easing.Linear}
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
    }

    Rectangle{
        id:agreeInfo
        width: 100; height: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: agreeName.bottom
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
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
    }

    Rectangle{
        id:localIPInfo
        width: 120; height: 20
        anchors.left: parent.left; anchors.leftMargin: 120
        anchors.top: localIPName.bottom
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
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
    }

    Rectangle{
        id:localprInfo
        width: 100; height: 20
        anchors.top: localprName.bottom
        anchors.left: localprName.left
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
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
    }

    Rectangle{
        id:targetIPInfo
        width: 120; height: 20
        anchors.top: targgetIPName.bottom
        anchors.left: targgetIPName.left
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
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
    }

    Rectangle{
        id:targetprInfo
        width: 100; height: 20
        anchors.top: targetprName.bottom
        anchors.left: targetprName.left
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
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
        color: "white"
        border.color: "black"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            color: "black"
            selectByMouse: true
            font.pixelSize: 13
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
        x:245; y:110
        text: "未绑定... "
        color: fontcolor
        font.pixelSize: 13
        font.family: fontfamily
    }

    // 开始关闭按钮
    ButtonOne{
        id: goButton
        x: 245; y:135
        btnWidth: 60; btnHeight: 20
        btnText: "连接"
        onClicked: {
            udp.bindSocket();
            showName.text = "已绑定..."
        }
    }

    ButtonOne{
        id: downButton
        x: 310; y:135
        btnWidth: 60; btnHeight: 20
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
}
