import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle{
    id: parapadbutton
    width: 20; height: 120
    x: posX; y: posY
    radius: 1
    color:"transparent"//"#FF534D"
    opacity: 1
    property real posX: 0
    property real posY: 0

    property string fontfamily: "Monaco"

    signal parapadTrigger()

    states: [
        State {
            name: "active"
            PropertyChanges {target: parapadbutton; x: posX-8}
        },
        State {
            name: "hover"
            PropertyChanges {target: parapadbutton; x: posX-8}
        }
    ]

    Behavior on x {NumberAnimation{duration: 100; easing.type: Easing.Linear}}

    MouseArea{
        anchors.fill: parent
        enabled: true
        hoverEnabled: true
        onClicked: {
            if(parapadbutton.state == "hover") parapadbutton.state = "active"
            else if(parapadbutton.state == "active") parapadbutton.state = "hover"
            parapadTrigger()
        }
        onEntered: {
            if(parapadbutton.state == "") parapadbutton.state = "hover"
        }
        onExited: {
            if(parapadbutton.state == "hover") parapadbutton.state = ""
        }
    }

    Image {
        id: goimage
        source: parapadbutton.state === "active"? "image/back.png" : "image/go.png"
        height: 20; width: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
