import QtQuick 2.0
import QtQuick 2.0
import "../button"
import io.serialport 1.0

Rectangle{
    id: serialportMessage
    width: 380; height: 200
    color: "ivory"
    border.color: "black"
    border.width: 2
    opacity: 0
    radius: 4
    x: -380
    y: 10

    // 串口信息
    property string commName: "COM16"
    property string buadRate: "9600"
    property string dataBits: "Data8"
    property string stopBits: "OneStop"
    property string parity: "NoParity"
    //字体
    property string fontfamily: "Monaco"
    property color fontcolor: "black"

    states:  State {
        name: "active"
        PropertyChanges {target: serialportMessage; opacity: 1; x: -2}
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

    // 选项卡中的串口信息
    Text{
        id: comInfoName
        text: "遥控手柄串口"
        font.family: fontfamily
        anchors.top: parent.top; anchors.topMargin: 5
        anchors.left: parent.left; anchors.leftMargin: 12
        font.pixelSize: 15
        Rectangle{
            width: 250; height: 1
            color: "black"
            anchors.top: parent.bottom
            anchors.left: parent.left
        }
    }
    Grid{
        id: comInfo
        anchors.top: comInfoName.bottom; anchors.topMargin: 5
        anchors.left: parent.left; anchors.leftMargin: 12
        rows: 5
        spacing: 5
        Text{text:"串口: " + commName; color: fontcolor; font.family: fontfamily}
        Text{text:"波特率: " + buadRate; color: fontcolor; font.family: fontfamily}
        Text{text:"数据位: " + dataBits; color: fontcolor; font.family: fontfamily}
        Text{text:"停止位: " + stopBits; color: fontcolor; font.family: fontfamily}
        Text{text:"校验位: " + parity; color: fontcolor; font.family: fontfamily}
    }


    // 串口状态文本
    Text{
        id: comState
        text: "未连接..."
        font.family: fontfamily
        font.pixelSize: 15
        anchors.top: comInfoName.top
        anchors.left: comInfoName.right; anchors.leftMargin: 200
    }

    // 开始按钮
    ButtonOne{
        id: startBtn
        btnWidth: 80; btnHeight: 20
        btnText: "打开串口"
        anchors.top: comInfo.bottom; anchors.topMargin: 5
        anchors.left: comInfo.left;
        onClicked: {
            comm.startSlave(comm.portName, comm.response);
            comState.text = "已连接"
        }
    }

    // 关闭按钮
    ButtonOne{
        id: stopBtn
        btnWidth: 80; btnHeight: 20
        btnText: "关闭串口"
        anchors.top: startBtn.bottom; anchors.topMargin: 5
        anchors.left: comInfo.left;
        onClicked: {
            comm.closeSlave();
            comState.text = "未连接..."
        }
    }

    // 接受框
    Text{
        id: recvName
        text: "串口接受数据:"
        font.family: fontfamily
        anchors.top: comInfoName.bottom; anchors.topMargin: 5
        anchors.left: parent.left; anchors.leftMargin: 150
    }
    TextScreen{
        id: recvScreen
        border.color: "black"
        anchors.top: recvName.bottom; anchors.topMargin: 5
        anchors.left: recvName.left
        Connections{
            target: comm
            onRecvMsgChanged: recvScreen.receive(comm.recvMsg)
        }
    }

    // 发送框
    Rectangle{
        id: sendScreen
        color: "ivory"
        border.color: "black"
        width: 185; height: 20
        anchors.top: recvScreen.bottom; anchors.topMargin: 10
        anchors.left: recvScreen.left
        TextInput{
            id: sendText
            anchors.left: parent.left; anchors.leftMargin: 2
            color: fontcolor
            font.family: fontfamily
            selectedTextColor: "red"
            selectByMouse: true
            text: "hello"
        }
    }

    // 发送按钮
    ButtonOne{
        id: sendBtn
        btnWidth: 30; btnHeight: 20
        btnText: "发送"
        anchors.top: sendScreen.top;
        anchors.left: sendScreen.right; anchors.leftMargin: 5
        onClicked: comm.sendResponse();
    }

    // c++的serial port对象
    Comm{
        id: comm
        portName: commName
        response: sendText.text
    }
}
