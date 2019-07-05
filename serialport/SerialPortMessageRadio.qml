import QtQuick 2.9
import QtQuick.Controls 2.4
import "radio"
import "../button"

Message{
    id: message
    rectColor: "transparent"
    borderColor: "#ffffff"
    width: 450; height: 300
    activex: 60; posy: 200

    // 串口信息
    property string commPort: "COM1"
    property string buadRate: "19200"

    // 信息卡的信息
    property string commName: "数传电台"

    // 由此控件产生的 发送给下危机的信息
    property string sendMsg: "hello world"
    signal sendMsgAlready()

    // 最上面的文字
    Text{
        id: commNameText
        anchors.top: parent.top; anchors.topMargin: 1
        anchors.horizontalCenter: parent.horizontalCenter
        text: commName + "   波特率: " + buadRate
        font.pixelSize: fontpixelSize
        font.family: fontfamily
        color: fontcolor
        renderType: TextInput.NativeRendering
        font.hintingPreference: Font.PreferVerticalHinting
    }

    // 最上面的分割线
    Rectangle{
        id: dividLine
        width: 400; height: 1
        anchors.left: parent.left
        anchors.top: commNameText.bottom
        color: "white"
    }

    // flag1-flag7
    StackView{
        id: radioMessage
        anchors.left: parent.left; anchors.leftMargin: 5
        anchors.top: parent.top; anchors.topMargin: 25
        width: 450; height: 300



        // 连接 当前项的发送内容 和 StackView
        Connections{
            target: radioMessage.currentItem
            onGetSendMsg : {
                message.sendMsg = radioMessage.currentItem.sendMsg
                console.log(message.sendMsg)
                message.sendMsgAlready();
            }
        }

    }

    // 打开IO
    RoundButton{
        id: flag5
        width: 60; height: 20
        radius: 2
        text: "IO"
        property bool isActive: true

        anchors.bottom: parent.bottom; anchors.bottomMargin: 3
        anchors.left: parent.left; anchors.leftMargin: 9
        onClicked: {
            if(radioMessage.depth!=0)
                radioMessage.pop(radioMessage.initialItem);
            radioMessage.push("radio/IOConsole.qml");
        }
    }

    // 打开光电
    RoundButton{
        id: flag7
        width: 60; height: 20
        radius: 2
        text: "Photo"
        anchors.bottom: parent.bottom; anchors.bottomMargin: 3
        anchors.left: parent.left; anchors.leftMargin: 75
        onClicked: {
            if(radioMessage.depth!=0)
                radioMessage.pop(radioMessage.initialItem);
            radioMessage.push("radio/PhotoConsole.qml");
        }
    }
}
