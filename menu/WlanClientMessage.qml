import QtQuick 2.0
import io.tcpclient 1.0
import "../button"

Rectangle{
    id: wlanClientMessage
    width: 380; height: 200
    color: "ivory"
    border.color: "black"
    border.width: 2
    opacity: 0
    radius: 4
    x: -380
    y: 10

    //字体
    property string fontfamily: "Monaco"
    property color fontcolor: "black"

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
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
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
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
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
        anchors.top: addrInfo.bottom; anchors.topMargin: 5
        anchors.left: parent.left; anchors.leftMargin: 10
        text: "服务器断开... "
        color: fontcolor
        font.pixelSize: 13
        font.family: fontfamily
    }

    ButtonOne{
        id: goButton
        x:10; y:170
        btnWidth: 60; btnHeight: 20
        btnText: "连接"
        onClicked: {
            if(goButton.state == ""){
                showName.text = "服务器已连接..."
                downButton.state = ""
                tcpClient.requestFortune(tcpClient.hostName, tcpClient.port);
            }
        }
    }

    ButtonOne{
        id: downButton
        x:75; y:170
        btnWidth: 60; btnHeight: 20
        btnText: "断开连接"
        onClicked: {
            if(downButton.state == ""){
                goButton.state = ""
                showName.text = "服务器断开..."
                tcpClient.closeFortune();
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

    // 选项卡中的文字框
    TextScreen{
        id: recvScreen
        border.color: "black"
        x: 145; y:35
    }

    Rectangle{
        width: 185; height: 20
        x:145; y:125
        color: "white"
        border.color: "black"
        TextInput{
            id:input
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
        id: sentButton
        x:345; y:125
        btnWidth: 30; btnHeight: 20
        btnText: "发送"
    }

    TcpClient{
        id: tcpClient
        port: 8000
        hostName: "127.0.0.1"
    }
}
