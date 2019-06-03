/**************************
**
**时间表
**长是主长0.06倍
**高是时间内容高的两倍
**
***************************/


import QtQuick 2.0

Item {
    id: clock
    width: myWindow.width*0.06
    height: time.contentHeight*2
    Rectangle{
        anchors.fill: parent
        color: "black"
        Timer{
            id: timer
            interval: 500
            running: true
            repeat: true
            onTriggered: time.text = Qt.formatDateTime(new Date(), "ddd HH:mm:ss")
        }

        Text {
            id: time
            width: parent.width
            anchors.centerIn: parent
            clip: true
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: parent.width*0.14
            color: "white"
        }
    }

    Component.onCompleted: {
        timer.start();
    }
}
