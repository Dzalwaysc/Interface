/************
**value表示当前鼠标位置
       暴露currentValue，用currValue从外界获取当前值
**动画效果使指针摆动更真实，没有动画效果指针会直接跳到当前值
***********/


import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

Rectangle {
    id:biao
    width: 200
    height: 200
    color: "transparent"
    property double currentValue: 0
    property string fontfamily: "Monaco"

    CircularGauge {
        id: dashboard

        value:  currentValue

        anchors.centerIn: parent
        anchors.fill: parent

        style: CircularGaugeStyle {

            maximumValueAngle: 120
            minimumValueAngle: -120

      //指针
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
          color: styleData.value >= 80 ? "#e34c22" : Qt.lighter("#06B9D1")
          antialiasing: true
          font.family: fontfamily
      }

      //标签距离
      labelInset:20

      //大刻度线加红
      tickmark: Rectangle {
          visible: styleData.value < 80 || styleData.value % 10 == 0
          implicitWidth: outerRadius * 0.03
          antialiasing: true
          implicitHeight: outerRadius * 0.15
          color: styleData.value >= 80 ? "#e34c22" : Qt.lighter("#06B9D1")        //e5e5e5
      }

      //去掉红格后面的小刻度线
      minorTickmark: Rectangle {
          visible: styleData.value < 80
          implicitWidth: outerRadius * 0.01
          antialiasing: true
          implicitHeight: outerRadius * 0.07
          color: Qt.lighter("#06B9D1")
      }

      //橙色线以示警告
      function degreesToRadians(degrees) {
          return degrees * (Math.PI / 180);
      }

        background: Canvas {
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                ctx.beginPath();
                ctx.strokeStyle = "#e34c22";
                ctx.lineWidth = outerRadius * 0.03;

                //{x,y,r,起始角,终止角}请注意，在转换为弧度之前，我们减去90度，因为我们的原点是北，画布是东。
                ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                  degreesToRadians(valueToAngle(80) - 90), degreesToRadians(valueToAngle(100) - 90));
                ctx.stroke();
            }
        }
    }

        Behavior on value {
            NumberAnimation {duration: 500}
        }
    }

    CircularGauge{
        id: small

        value: accelerating ? maximumValue : 0
        property bool accelerating: false

        Keys.onSpacePressed: accelerating = true
        Keys.onReleased: {
            if (event.key === Qt.Key_Space) {
                 accelerating = false;
                 event.accepted = true;
             }
        }

        Component.onCompleted: forceActiveFocus()

        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 30
        anchors.horizontalCenter: parent.horizontalCenter

        maximumValue: 10
        minimumValue: 0

        style: CircularGaugeStyle {

            maximumValueAngle: 215
            minimumValueAngle: 145

            needle: Rectangle {
                y: outerRadius * 0.1
                implicitWidth: outerRadius * 0.03
                implicitHeight: outerRadius * 0.7
                antialiasing: true
                color:"#7CFC00"// Qt.lighter("#00FF80")
            }

            tickmarkLabel:  Text {
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: styleData.value
                color: "#7CFC00"//Qt.lighter("#00FF80")
                antialiasing: true
                font.family: fontfamily
            }

            tickmark: Rectangle {
                implicitWidth: outerRadius * 0.02
                antialiasing: true
                implicitHeight: outerRadius * 0.10
                color: "#7CFC00"//Qt.lighter("#00FF80")
            }

            minorTickmark: Rectangle {
                implicitWidth: outerRadius * 0.005
                antialiasing: true
                implicitHeight: outerRadius * 0.03
                color: "#7CFC00"//Qt.lighter("#00FF80")
            }

            labelInset: 45
            tickmarkInset: 30
            minorTickmarkInset: 30
            tickmarkStepSize: 2
            minorTickmarkCount: 3
        }

        Behavior on value {
            NumberAnimation {duration: 500}
        }
    }


    Text {
        id: unitText
        text: "km/h"
        color: Qt.lighter("#06B9D1")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        font.pixelSize: 12
        font.family: fontfamily
    }

    Text {
        id: indexText
        text: dashboard.value.toFixed(1)
        color: Qt.lighter("#06B9D1")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 40
        font.pixelSize: 12
        font.bold: true
        font.family: fontfamily
    }

}
