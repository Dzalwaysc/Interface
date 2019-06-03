import QtQuick 2.0
import QtGraphicalEffects 1.0


Item {
    id: wlan
    property real posX: 0
    property real posY: 0
    property real delegate_width: 80
    property real delegate_height: 16

    property real highligth_opacity: 1
    Behavior on highligth_opacity{SpringAnimation { spring: 2; damping: 0.2 }}

    states: State {
                name: "active"
                PropertyChanges {target: wlanB; state: "active"}
    }

    Rectangle{
        id: wlanB
        x: posX; y: posY // 最终位置为x:650  y:45
        opacity: 1
        width: delegate_width*4; height: delegate_height
        radius: 2
        color: "ivory"
        border.color: "black"

        states:State {
                name: "active"
                PropertyChanges {target: wlanB; opacity: 1; y: posY+90}
                PropertyChanges {target: wlanB_shadow; opacity: 1}
        }

        ListModel{
            id: contactModel
            ListElement{name: "empty"}
            ListElement{name: "empty"}
            ListElement{name: "empty"}
            ListElement{name: "empty"}
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
            enabled: wlanB.opacity == 1
            hoverEnabled: wlanB.opacity == 1
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
            enabled: wlanB.opacity == 1
            hoverEnabled: wlanB.opacity == 1
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
            enabled: wlanB.opacity == 1
            hoverEnabled: wlanB.opacity == 1
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
            enabled: wlanB.opacity == 1
            hoverEnabled: wlanB.opacity == 1
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
        id: wlanB_shadow
        anchors.fill: wlanB
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8
        samples: 17
        color: "black"
        opacity: 0
        source: wlanB
    }

}
