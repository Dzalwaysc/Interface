import QtQuick 2.0
import QtGraphicalEffects 1.0
import io.tcpclient 1.0

Item {
    id: wlan
    property real posX: 0
    property real posY: 0
    property real delegate_width: 80
    property real delegate_height: 16

    property real highligth_opacity: 1
    Behavior on highligth_opacity{SpringAnimation { spring: 2; damping: 0.2 }}

    // 暴露给外部使用的属性
    property alias listView: listView

    //字体
    property string fontfamily: "Monaco"
    property color fontcolor: "black"

    // 点击WlanBtn时，关闭Message窗口
    signal close()
    onClose: {
        clientMessage.state = ""
        serverMessage.state = ""
        udpMessage.state = ""
    }

    Rectangle{
        id: listView
        x: posX; y: -45 // 最终位置为x:posX  y:posY
        opacity: 1
        width: delegate_width*4; height: delegate_height
        radius: 2
        color: "transparent"
        border.color: "white"

        states:[
            State {
                name: "active"
                PropertyChanges {target: listView; opacity: 1; y: posY}
            },
            State {
                name: ""
                PropertyChanges {target: listView; opacity: 0; y: -45}
            }
        ]

        ListModel{
            id: contactModel
            ListElement{name: "服务器"}
            ListElement{name: "客户端"}
            ListElement{name: "数据报"}
            ListElement{name: "预留网络"}
        }

        Component{
            id: contactDelegate
            Item{
                id: item
                width: delegate_width; height: delegate_height
                Text {
                    id: contactInfo
                    anchors.centerIn: parent
                    color: "white"
                    text: name
                    font.family: fontfamily
                }
            }
        }

        Component{
            id: highlight
            Rectangle{
                id: high_rect
                width: delegate_width; height: delegate_height-20
                radius: 2.5
                color: "lightsteelblue"
                border.color: "black"
                opacity: highligth_opacity
            }
        }

        ListView{
            id: list
            anchors.fill: parent
            model: contactModel
            delegate: contactDelegate
            highlight: highlight
            highlightFollowsCurrentItem: true
            orientation: ListView.Horizontal
        }

        MouseArea{
            id: mousearea1
            x:0; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: listView.opacity == 1
            onEntered: {
                highligth_opacity = 0.5
                list.currentIndex = 0
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        MouseArea{
            id: mousearea2
            x:delegate_width; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: listView.opacity == 1
            onEntered: {
                highligth_opacity = 0.5
                list.currentIndex = 1
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        MouseArea{
            id: mousearea3
            x:delegate_width*2; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: listView.opacity == 1
            onEntered: {
                highligth_opacity = 0.5
                list.currentIndex = 2
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        MouseArea{
            id: mousearea4
            x:delegate_width*3; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: listView.opacity == 1
            onEntered: {
                highligth_opacity = 0.5
                list.currentIndex = 3
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        Component.onCompleted: {
            highligth_opacity = 0
        }
    }

    Glow {
        anchors.fill: listView
        radius: 7            //半径决定辉光的柔和度，半径越大辉光的边缘越模糊  样本值=1+半径*2
        samples: 13           //每个像素采集的样本值，值越大，质量越好，渲染越慢
        color: "#ddd"
        source: Rectangle{
            width: delegate_width*4; height: delegate_height
            radius: 2
            color: "transparent"
            border.color: "white"
        }

        spread: 0.5          //在光源边缘附近增强辉光颜色的大部分
        opacity: 1
    }

    WlanServerMessage{
        id: serverMessage
        Connections{
            target: mousearea1
            onClicked: {
                clientMessage.state = ""
                udpMessage.state = ""
                if(serverMessage.state === "") serverMessage.state = "active";
                else if(serverMessage.state === "active") serverMessage.state = "";
            }
        }

    }

    WlanClientMessage{
        id: clientMessage
        Connections{
            target: mousearea2
            onClicked: {
                serverMessage.state = ""
                udpMessage.state = ""
                if(clientMessage.state === "") clientMessage.state = "active";
                else if(clientMessage.state === "active") clientMessage.state = "";
            }
        }
    }

    WlanUDPMessage{
        id: udpMessage
        Connections{
            target: mousearea3
            onClicked: {
                serverMessage.state = ""
                clientMessage.state = ""
                if(udpMessage.state === "") udpMessage.state = "active";
                else if(udpMessage.state === "active") udpMessage.state = "";
            }
        }

    }
}
