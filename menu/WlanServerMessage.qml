import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../button"
import io.tcpserver 1.0
Rectangle{
    id: wlanServerMessage
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


    states:  State {
        name: "active"
        PropertyChanges {target: wlanServerMessage; opacity: 1; x: 4}
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
            text: "TCP server"
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    Text {
        id: localportName
        anchors.top: agreeInfo.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "本地端口: "
        color: fontcolor
        font.family: fontfamily
    }

    Rectangle{
        id:localportInfo
        width: 125; height: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: localportName.bottom
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: 13
            focus: true
            text: tcpServer.port
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    Text{
        id: localaddrName
        anchors.top: localportInfo.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "本地地址: "
        color: fontcolor
        font.family: fontfamily
    }

    Rectangle{
        id:localaddrInfo
        width: 125; height: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: localaddrName.bottom
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: fontcolor
            font.pixelSize: 13
            focus: true
            text: tcpServer.hostName
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
            onAccepted: {
                tcpServer.hostName = text;
            }
        }
    }

    Text{
        id: showName
        anchors.top: localaddrInfo.bottom; anchors.topMargin: 15
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "未监听... "
        color: fontcolor
        font.pixelSize: 13
        font.family: fontfamily
    }

    ButtonOne{
        id: goButton
        x:150; y:155
        btnWidth: 80; btnHeight: 30
        btnText: "开始监听"
        onClicked: {
            if(goButton.state == ""){
                tcpServer.startListen(tcpServer.hostName, tcpServer.port);
                downButton.state = ""
                showName.text = "已监听..."
            }
        }
    }

    ButtonOne{
        id: downButton
        x: 250; y:155
        btnWidth: 80; btnHeight: 30
        btnText: "停止监听"
        onClicked: {
            if(downButton.state == ""){
                tcpServer.closeListen();
                showName.text = "未监听..."
                goButton.state = ""
            }
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

    TextScreen{
        id: recvScreen
        border.color: fontcolor
        x: 145; y:35
    }

    Rectangle{
        id:input
        width: 185; height: 20
        x:145; y:125
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        TextInput{
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
        id: sendButton
        x:345; y:125
        btnWidth: 30; btnHeight: 20
        btnText: "发送"
    }

    TcpServer{
        id: tcpServer
        port: 8000
        hostName: "192.168.3.143"
    }

    Image {
        id: name
        width: 200; height: 200
        source: "image/bian.png"
        anchors.right: wlanServerMessage.right
        anchors.rightMargin: -62
        anchors.top: wlanServerMessage.top
        opacity: 0.15
    }

    Glow {
        anchors.fill: wlanServerMessage
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
        opacity: wlanServerMessage.opacity
    }
}
