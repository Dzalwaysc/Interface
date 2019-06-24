/****************************************************************************
**     该文件在SerialPortListView中使用
**           单击ListView中的内容后，从屏幕最左边弹出一个选项卡
**串口消息
**串口名称，数据位，停止位，奇偶性
**Column定义显示文本
**在窗口右下角'openbutton'定义一个开始/关闭按钮
**
** signal: state_transition 用于其他对象控制此状态。
** 例如我们可以用鼠标敲击: xxx.state_tansition()
** 然后，该对象将有一个动画
** signal: close 用于控制 state "active" to state ""

**用户接口
** property: commName, dataBits, stopBits, parity
** 分别对于串口名称，数据位，停止位，奇偶性
** property: source, imgname
** 这两项属性对应选项卡的图片，和图片下面的文本
****************************************************************************/

import QtQuick 2.0
import QtGraphicalEffects 1.0
import io.serialport 1.0

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
    property string commName
    property string buadRate
    property string dataBits
    property string stopBits
    property string parity

    //字体
    property string fontfamily: "Monaco"
    property real fontpixelSize: 13


    // 这个属性暴露给外部，令其能够改变serialport的图片，这两项属性均在下面的serialImgRect中
    property alias source: serialImg.source
    property alias imgname: serialText.text

    states:  State {
        name: "active"
        PropertyChanges {target: serialportMessage; opacity: 1; x: -2}
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

    // 选项卡中的图片和图片下方的ID
    Rectangle{
        id: serialImgRect
        width: 80; height: 62
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        color: Qt.rgba(255, 0, 0, .4)
        border.color: "white"; border.width: 1.5
        radius: 4
        Image{
            id: serialImg
            anchors.centerIn: parent
            width: 60; height: 50
        }
        Text {
            id: serialText
            text: imgName
            color: "white"
            font.family: fontfamily
            font.pixelSize: fontpixelSize
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom; anchors.topMargin: 5
        }
    }

    // 选项卡中的串口信息
    Column{
        anchors.top: serialImgRect.top
        anchors.left: serialImgRect.right; anchors.leftMargin: 50
        spacing: 2
        Text{text:"串 口: " + commName/*"Comm1"*/; color: "white"; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"波特率: " + buadRate/*"9600"*/; color: "white"; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"数据位: " + dataBits/*"Data8"*/; color: "white"; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"停止位: " + stopBits/*"OneStop"*/; color: "white"; font.family: fontfamily; font.pixelSize: fontpixelSize}
        Text{text:"校验位: " + parity/*"NoParity"*/; color: "white"; font.family: fontfamily; font.pixelSize: fontpixelSize}
    }

    // 选项卡中的start/close按钮
    Image{
        id: openbutton
        width: 20; height: 20
        opacity: 1
        anchors.bottom: parent.bottom; anchors.bottomMargin: 5
        anchors.right: parent.right; anchors.rightMargin: 5
        source: openbutton.state == "active" ? "image/stop.png" : "image/start.png"

        states: State {name: "active"}

        MouseArea{
            anchors.fill: parent
            enabled: true

            onClicked: {
                if(openbutton.state === ""){
                    comm.startSlave(comm.portName, comm.response);
                    openbutton.state = "active"
                }
                else{
                    comm.suspendSlave();
                    openbutton.state = ""
                }
            }
        }
    }

    // c++的serial port对象
    Comm{
        id: comm
        portName: commName   
        response: "hello"
    }

    // 选项卡中的文字框
    TextScreen{
        id: recvScreen
        border.color: "white"
        x: 10; y:120
        Connections{
            target: comm
            onRecvMsgChanged: recvScreen.receive(comm.recvMsg)
        }
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
