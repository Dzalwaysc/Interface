import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../button"
import io.serialport 1.0
// 12312312
Rectangle{
    id: serialportMessage
    width: 380; height: 200
    color: Qt.rgba(255, 0, 0, .4)
    border.color: Qt.rgba(255, 0, 0, .4)
    border.width: 2
    opacity: 0
    radius: 4
    x: -380
    y: 230

    // 串口信息
    property string commName: "COM16"
    property string buadRate: "9600"
    property string dataBits: "Data8"
    property string stopBits: "OneStop"
    property string parity: "NoParity"
    //字体
    property string fontfamily: "Monaco"
    property color fontcolor: "white"
    property real fontpixelSize: 13

    states:  State {
        name: "active"
        PropertyChanges {target: serialportMessage; opacity: 1; x: 2}
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

    // 选项卡中的串口信息
    Text{
        id: comInfoName
        text: "遥控串口"
        font.family: fontfamily
        color: fontcolor
        anchors.top: parent.top; anchors.topMargin: 5
        anchors.left: parent.left; anchors.leftMargin: 12
        font.pixelSize: fontpixelSize
        Rectangle{
            width: 250; height: 1
            color: fontcolor
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
        Text{text:"串口: " + commName; color: fontcolor; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"波特率: " + buadRate; color: fontcolor; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"数据位: " + dataBits; color: fontcolor; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"停止位: " + stopBits; color: fontcolor; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"校验位: " + parity; color: fontcolor; font.family: fontfamily; font.pixelSize: fontpixelSize}
    }


    // 串口状态文本
    Text{
        id: comState
        text: "未连接..."
        font.family: fontfamily
        font.pixelSize: fontpixelSize
        color: fontcolor
        anchors.top: comInfoName.top
        anchors.left: comInfoName.right; anchors.leftMargin: 200
    }

    // 开始按钮
    ButtonOne{
        id: startBtn
        btnWidth: 80; btnHeight: 30
        btnText: "打开串口"
        anchors.top: comInfo.bottom; anchors.topMargin: 10
        anchors.left: comInfo.left;
        onClicked: {
            comm.startSlave(comm.portName, comm.response);
            comState.text = "已连接"
            console.log(comInfo.height)
        }
    }

    // 关闭按钮
    ButtonOne{
        id: stopBtn
        btnWidth: 80; btnHeight: 30
        btnText: "关闭串口"
        anchors.left: startBtn.right; anchors.leftMargin: 10
        anchors.top: startBtn.top
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
        font.pixelSize: fontpixelSize
        color: fontcolor
        anchors.top: comInfoName.bottom; anchors.topMargin: 5
        anchors.left: parent.left; anchors.leftMargin: 150
    }
    TextScreen{
        id: recvScreen
        border.color: fontcolor
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
        color: Qt.rgba(255, 0, 0, .4)
        border.color: fontcolor
        width: 185; height: 20
        anchors.top: recvScreen.bottom; anchors.topMargin: 10
        anchors.left: recvScreen.left
        TextInput{
            id: sendText
            anchors.left: parent.left; anchors.leftMargin: 2
            color: fontcolor
            font.family: fontfamily
            font.pixelSize: fontpixelSize
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
        anchors.verticalCenter: sendScreen.verticalCenter
        anchors.left: sendScreen.right; anchors.leftMargin: 5
        onClicked: comm.sendResponse();
    }

    // c++的serial port对象
    Comm{
        id: comm
        portName: commName
        response: sendText.text
    }

    Image {
        id: name
        width: 200; height: 200
        source: "image/bian.png"
        anchors.right: serialportMessage.right
        anchors.rightMargin: -62
        anchors.top: serialportMessage.top
        opacity: 0.15
    }

    Glow {
        anchors.fill: serialportMessage
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
        opacity: serialportMessage.opacity
    }
}
