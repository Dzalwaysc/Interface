import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle{
    id: wlanButton
    radius: 5
    x: posX; y: posY
    width: 50
    height:50
    color: "ivory"
    opacity: 0.5
    property real posX: 0
    property real posY: 0

    // 当点击了该按钮，该按钮的MouseArea中的onClicked执行完后，发送此信号到外部
    signal trigger()


    states: [
        State {
            name: "hover"
            PropertyChanges { target: wlanButton; opacity:1}

        },
        State {
            name:"active"
            PropertyChanges {target: wlanButton;opacity:1; x: posX-3; y: posY-3}
        }
    ]
    Behavior on opacity { NumberAnimation{duration: 100; easing.type: Easing.Linear}}
    Behavior on x { NumberAnimation{duration: 100; easing.type: Easing.Linear}}
    Behavior on y { NumberAnimation{duration: 100; easing.type: Easing.Linear}}

    Image {
        id: setImage
        source: "image/wlan.png"
        anchors.fill: parent
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        enabled: true
        hoverEnabled: true
        onClicked: {
            if(wlanButton.state === "hover") wlanButton.state = "active";
            else if (wlanButton.state === "active" ) wlanButton.state = "hover";
            trigger();
        }
        onEntered: {
            if(wlanButton.state === "") wlanButton.state = "hover";
        }
        onExited: {
            if(wlanButton.state === "hover") wlanButton.state = "";
        }
    }
}

