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
import io.serialport 1.0

Rectangle{
    id: serialportMessage
    width: 350; height: 200
    color: "ivory"
    border.color: "black"
    border.width: 2
    opacity: 0
    radius: 4
    x: -200
    y: 10
    property string commName
    property string dataBits
    property string stopBits
    property string parity

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
            NumberAnimation{properties: "opacity, x"; duration: 500; easing.type: Easing.Linear}
        },
        Transition {
            from: "active"; to: ""; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 150; easing.type: Easing.Linear}
        }
    ]

    // 选项卡中的图片和图片下方的ID
    Rectangle{
        id: serialImgRect
        width: 80; height: 62
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        color: "ivory"
        border.color: "black"; border.width: 1.5
        radius: 4
        Image{
            id: serialImg
            anchors.centerIn: parent
            width: 60; height: 50
        }
        Text {
            id: serialText
            text: imgName
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom; anchors.topMargin: 5
        }
    }

    // 选项卡中的串口信息
    Column{
        anchors.top: serialImgRect.top
        anchors.left: serialImgRect.right; anchors.leftMargin: 50
        spacing: 10
        Text{text:"&nbsp;&nbsp;comm name: " + commName/*"Comm1"*/; color: "black"; textFormat: Text.StyledText}
        Text{text:"&nbsp;&nbsp;data bits: " + dataBits/*"Data8"*/; color: "black"; textFormat: Text.StyledText}
        Text{text:"&nbsp;&nbsp;stop bits: " + stopBits/*"OneStop"*/; color: "black"; textFormat: Text.StyledText}
        Text{text:"&nbsp;&nbsp;parity: " + parity/*"NoParity"*/; color: "black"; textFormat: Text.StyledText}
    }

    // 选项卡中的start/close按钮
    Image{
        id: openbutton
        width: 20; height: 20
        opacity: 1
        anchors.bottom: parent.bottom; anchors.bottomMargin: 5
        anchors.right: parent.right; anchors.rightMargin: 5
        source: openbutton.state == "active" ? "image/close.png" : "image/start.png"

        states: State {name: "active"}

        MouseArea{
            anchors.fill: parent
            enabled: true

            onClicked: {
                if(openbutton.state === ""){
                    comm.startSlave(comm.portName, comm.waitTimeout, comm.response);
                    openbutton.state = "active"
                }
                else{
                    comm.suspendSlave();
                    openbutton.state = ""
                    receScreen.receive(comm.recvMsg);
                }
            }
        }
    }

    // c++的serial port对象
    Comm{
        id: comm
        portName: commName
        waitTimeout: 10000     
        response: "hello"
    }

    // 选项卡中的文字框
    TextScreen{
        id: receScreen
        border.color: "black"
        x: 10; y:120
    }
}
