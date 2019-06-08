import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../button"
import io.tcpserver 1.0
Rectangle{
    id: wlanServerMessage
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
        PropertyChanges {target: wlanServerMessage; opacity: 1; x: -2}
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
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
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
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
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
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
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
        anchors.top: localaddrInfo.bottom; anchors.topMargin: 5
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "未监听... "
        color: fontcolor
        font.pixelSize: 13
        font.family: fontfamily
    }

    ButtonOne{
        id: goButton
        x:10; y:170
        btnWidth: 60; btnHeight: 20
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
        x:75; y:170
        btnWidth: 60; btnHeight: 20
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
        border.color: "black"
        x: 145; y:35
    }

    Rectangle{
        id:input
        width: 185; height: 20
        x:145; y:125
        color: "white"
        border.color: "black"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            color: "black"
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
}
