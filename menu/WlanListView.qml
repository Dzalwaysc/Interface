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
        x: posX; y: posY // 最终位置为x:650  y:45
        opacity: 1
        width: delegate_width*4; height: delegate_height
        radius: 2
        color: "ivory"
        border.color: "black"

        states:State {
                name: "active"
                PropertyChanges {target: listView; opacity: 1; y: posY+90}
                PropertyChanges {target: listView_shadow; opacity: 1}
        }

        ListModel{
            id: contactModel
            ListElement{name: "Server"}
            ListElement{name: "Client"}
            ListElement{name: "UDP"}
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
                    textFormat: Text.StyledText
                    color: Qt.lighter("black")
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
                y:list.currentItem.y
                Behavior on y { SpringAnimation{ spring: 3; damping: 0.2} }
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
                highligth_opacity = 1
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
                highligth_opacity = 1
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
                highligth_opacity = 1
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
                highligth_opacity = 1
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

    DropShadow{
        id: listView_shadow
        anchors.fill: listView
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8
        samples: 17
        color: "black"
        opacity: 0
        source: listView
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
