import QtQuick 2.0

Rectangle{
    id: ioBtn
    border.color: "white"
    color: "transparent"
    width: btnWidth; height: btnHeight
    radius: 5
    scale: 1

    // 用户属性
    property real btnWidth: 30
    property real btnHeight: 30

    //用户信号
    signal clicked()

    states: [
        State {
            name: ""
            PropertyChanges {target: ioBtn; border.color: "white"}
            PropertyChanges {target: img; source: "image/switchoff.png"}
        },
        State {
            name: "active"
            PropertyChanges {target: ioBtn; border.color: "#B1FFA2"}
            PropertyChanges {target: img; source: "image/switchon.png"}
        }
    ]

    SequentialAnimation{
        id: animation
        running: false
        NumberAnimation{
            target: ioBtn; property: "scale"
            from:1; to:0.8; duration: 100;
        }
        NumberAnimation{
            target: ioBtn; property: "scale"
            from:0.8; to:1; duration: 100
        }
    }

    Image{
        id: img
        anchors.centerIn: parent
        width: 20; height: 20
        source: "image/switchoff.png"
    }


    MouseArea{
        anchors.fill: parent
        enabled: parent.opacity == 1 ? true : false
        onClicked: {
            animation.start();
            if(ioBtn.state === "") ioBtn.state = "active";
            else ioBtn.state = "";
            ioBtn.clicked();
        }
    }
}
