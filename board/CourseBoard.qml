import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0


Rectangle {
    id:biao
    width: 150
    height: 150
    color: "transparent"
    property double currentValue: 0
    property string fontfamily: "Monaco"

    CircularGauge {
        id: gauge
        maximumValue: 180
        minimumValue: -180
        anchors.centerIn: parent
        anchors.fill: parent

        value: currentValue

        style: CircularGaugeStyle {
            id: style

            maximumValueAngle:180
            minimumValueAngle:-180

            labelStepSize:30

            needle: Rectangle {
                y: outerRadius * 0.15
                implicitWidth: outerRadius * 0.03
                implicitHeight: outerRadius * 0.9
                antialiasing: true
                color: "#e34c22"
            }

            //指针中间旋钮
            foreground: Item {
                Rectangle {
                    id: circular
                    width: outerRadius * 0.2
                    height: width
                    radius: width / 2
                    color: "#494d53"
                    anchors.centerIn: parent
                }
            }

            //刻度标签颜色
            tickmarkLabel:  Text {
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: styleData.value
                color: styleData.value >= -150 ? Qt.lighter("#06B9D1") : Qt.lighter("black")
                antialiasing: true
                font.family: fontfamily
            }

            //标签距离
            labelInset:20

            tickmarkStepSize:30

            //大刻度线加红
            tickmark: Rectangle {
                implicitWidth: outerRadius * 0.03
                antialiasing: true
                implicitHeight: outerRadius * 0.15
                color: Qt.lighter("#06B9D1")
            }

            //去掉红格后面的小刻度线
            minorTickmark: Rectangle {
                implicitWidth: outerRadius * 0.01
                antialiasing: true
                implicitHeight: outerRadius * 0.07
                color: Qt.lighter("#06B9D1")
            }
        }

        Text {
            id: indexText
            text:  currentValue
            color: Qt.lighter("#06B9D1")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 30
            font.pixelSize: 12
            font.bold: true
            font.family: fontfamily
        }
    }

}
