import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0


Rectangle{
    id: arctank
    width: 300
    height: 300
    border.color: "transparent"
    color: "transparent"
    property string fontfamily: "Monaco"

    CircularGauge{
        id:tankborder
        width: 200; height: 200
        anchors.verticalCenter: arctank.verticalCenter
        anchors.horizontalCenter: arctank.horizontalCenter
        anchors.horizontalCenterOffset: -150

        minimumValue: 0
        maximumValue: 100

        value: 0


        Behavior on value {
            NumberAnimation{duration: 1000}
        }

        style: CircularGaugeStyle{
            id: tankstyle

            maximumValueAngle: 70
            minimumValueAngle: 110

            needle: Rectangle {
                y: -265
                implicitWidth: outerRadius * 0.1
                implicitHeight: outerRadius * 0.35
                antialiasing: true
                color: "#e34c22"
            }

            foreground: Item{
                Rectangle{
                    color:"transparent"
                }
            }

            tickmark: Rectangle {
                implicitWidth: outerRadius * 0.06
                antialiasing: true
                implicitHeight: outerRadius * 0.3
                color: Qt.lighter("#06B9D1")
            }

            minorTickmark: Rectangle {
                implicitWidth: outerRadius * 0.02
                antialiasing: true
                implicitHeight: outerRadius * 0.15
                color: Qt.lighter("#06B9D1")
            }

            tickmarkLabel:  Text {
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: styleData.value
                color: Qt.lighter("#06B9D1")
                antialiasing: true
                font.family: fontfamily
            }

            labelInset: -160
            tickmarkInset: -200
            minorTickmarkInset: -200
            tickmarkStepSize: 20
            minorTickmarkCount: 5
        }
    }
}
