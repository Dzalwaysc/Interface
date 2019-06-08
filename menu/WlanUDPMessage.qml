import QtQuick 2.0
import "../button"

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
        width: 100; height: 20
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
            text: "我"
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    Text{
        id: localprName
        anchors.top: localIPInfo.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 120
        text: "本地端口: "
        color: fontcolor
        font.family: fontfamily
    }

    Rectangle{
        id:localprInfo
        width: 100; height: 20
        anchors.left: parent.left; anchors.leftMargin: 120
        anchors.top: localprName.bottom
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
            focus: true
            text: "最"
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    Text{
        id: targetprName
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 230
        text: "目标端口: "
        color: fontcolor
        font.family: fontfamily
    }

    Rectangle{
        id:targetprInfo
        width: 100; height: 20
        anchors.left: parent.left; anchors.leftMargin: 230
        anchors.top: targetprName.bottom
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
            focus: true
            text: "最"
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

    Text{
        id: targgetIPName
        anchors.top: targetprInfo.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 230
        text: "目标IP: "
        color: fontcolor
        font.family: fontfamily
    }

    Rectangle{
        id:targetIPInfo
        width: 100; height: 20
        anchors.left: parent.left; anchors.leftMargin: 230
        anchors.top: targgetIPName.bottom
        color: "white"
        border.color: "#a3a380"
        TextInput{
            anchors.verticalCenter: parent.verticalCenter
            x:10
            color: "black"
            font.pixelSize: 13
            focus: true
            text: "帅"
            font.family: fontfamily
            selectByMouse: true
            selectedTextColor: "red"
        }
    }

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
            text:"你好帅你好帅你好帅"
        }
    }

    ButtonOne{
        id: sentButton
        x:195; y:170
        btnWidth: 30; btnHeight: 25
        btnText: "发送"
    }

    Text{
        id: showName
        x:245; y:110
        text: "未绑定... "
        color: fontcolor
        font.pixelSize: 13
        font.family: fontfamily
    }

    ButtonOne{
        id: goButton
        x: 245; y:135
        btnWidth: 60; btnHeight: 20
        btnText: "连接"
        onClicked: {
            if(goButton.state == ""){
                downButton.state = ""
                showName.text = "已绑定..."
            }
        }
    }

    ButtonOne{
        id: downButton
        x: 310; y:135
        btnWidth: 60; btnHeight: 20
        btnText: "断开连接"
        onClicked: {
            if(downButton.state == ""){
                showName.text = "未绑定..."
                goButton.state = ""
            }
        }
    }
}
