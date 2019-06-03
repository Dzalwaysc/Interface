import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item{
    SerialPortButton{
        id: serialPort
        x: 900; y: 50


    }

    SetButton{
        id: setBtn
        posX: 950; posY: 50
        width: 30
        height: 30
    }

    DropShadow{
        id: setBtn_shadow
        anchors.fill: setBtn
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "black"
        opacity: 0
        source: setBtn

        states: State {
            name: "active"
            PropertyChanges {target: setBtn_shadow; opacity: 1}
        }
        Behavior on opacity {NumberAnimation{duration: 100; easing.type: Easing.Linear}}

        Connections{
            target: setBtn
            onShadowTrig: {
                if(setBtn.state == "active") setBtn_shadow.state = "active";
                else if(setBtn.state == "hover") setBtn_shadow.state = "";
                console.log("hi")
            }
        }
    }
}

