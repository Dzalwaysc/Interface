import QtQuick 2.0
import QtGraphicalEffects 1.0
import io.tcpclient 1.0
import "../button"

Rectangle{
    id: wlanClientMessage
    width: 380; height: 200
    color: Qt.rgba(255, 0, 0, .4)
    border.color: Qt.rgba(255, 0, 0, .4)
    border.width: 2
    opacity: 0
    radius: 4
    x: -380
    y: 150

    //字体
    property string fontfamily: "Monaco"
    property color fontcolor: "white"

    // 在单击start按钮后，等待执行完onClicked的操作后发送该信号，对TCP/UDP进行操作，暴露给外部使用
    signal startTrigger()

    // 暴露给外部使用
    property alias recvScreen: recvScreen

    states:  State {
        name: "active"
        PropertyChanges {target: wlanClientMessage; opacity: 1; x: -2}
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
        width: 125; height: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: agreeName.bottom
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: 13
            focus: true
            text: "TCP client"
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    Text {
        id: portName
        anchors.top: agreeInfo.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "服务器端口: "
        color: fontcolor
        font.family: fontfamily
    }

    Rectangle{
        id:portInfo
        width: 125; height: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: portName.bottom
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: 13
            focus: true
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
            text: tcpClient.port.toString()
            onAccepted: {
                tcpClient.port = Number(portInfo.text)
                console.log(tcpClient.port)
            }
        }
    }

    Text{
        id: addrName
        anchors.top: portInfo.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "服务器地址: "
        color: fontcolor
        font.family: fontfamily
    }

    Rectangle{
        id:addrInfo
        width: 125; height: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: addrName.bottom
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: 13
            focus: true
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
            text: tcpClient.hostName
            onAccepted: {
                tcpClient.hostName = addrInfo.text
            }
        }
    }

    Text{
        id: showName
        anchors.top: addrInfo.bottom; anchors.topMargin: 15
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "服务器断开... "
        color: fontcolor
        font.pixelSize: 13
        font.family: fontfamily
    }

    ButtonOne{
        id: goButton
        x:150; y:155
        btnWidth: 80; btnHeight: 30
        btnText: "连接"
        onClicked: {
            showName.text = "服务器已连接..."
            tcpClient.startFortune(tcpClient.hostName, tcpClient.port);
        }
    }

    ButtonOne{
        id: downButton
        x:250; y:155
        btnWidth: 80; btnHeight: 30
        btnText: "断开连接"
        onClicked: {
            tcpClient.closeFortune();
            showName.text = "服务器断开..."
        }
    }

    Text {
        id: accept
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 145
        text: "网络数据接收: "
        color: fontcolor
        font.family: fontfamily
    }

    // 选项卡中的文字框
    TextScreen{
        id: recvScreen
        border.color: fontcolor
        x: 145; y:35
    }

    Rectangle{
        width: 185; height: 20
        x:145; y:125
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            id:input
            anchors.verticalCenter: parent.verticalCenter
            color: fontcolor
            selectByMouse: true
            font.pixelSize: 13
            focus: true
            font.family: fontfamily
            text:"你好帅你好帅你好帅你好帅"
        }
    }

    ButtonOne{
        id: sentButton
        x:345; y:125
        btnWidth: 30; btnHeight: 20
        btnText: "发送"
    }

    TcpClient{
        id: tcpClient
        port: 8000
        hostName: "192.168.3.154"
    }

    Image {
        id: name
        width: 200; height: 200
        source: "image/bian.png"
        anchors.right: wlanClientMessage.right
        anchors.rightMargin: -62
        anchors.top: wlanClientMessage.top
        opacity: 0.15
    }

    Glow {
        anchors.fill: wlanClientMessage
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
        opacity: wlanClientMessage.opacity
    }
}
