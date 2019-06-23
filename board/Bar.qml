import QtQuick 2.0
import QtCharts 2.0

Rectangle {
    width: 430
    height: 200
    color: "transparent"
    property real bobValue1: 37
    property real bobValue2: 14
    property real bobValue3: 83
    property real bobValue4: 52

    ChartView {
        title:" "
        titleColor: "transparent"
        backgroundColor: "transparent"
        anchors.fill:parent
        antialiasing:true
        legend.visible: false

        ValueAxis{
            id: axisX
            min: 0
            max: 100
            labelsColor: "white"
            lineVisible: true
            labelsVisible: true
            gridVisible: true
        }

        HorizontalBarSeries {
            axisY:BarCategoryAxis{
                categories:{["目标距离","横测偏差","速度偏差","艏向偏差"]}
                labelsColor: "white"
                lineVisible: true
                labelsVisible: true
                gridVisible: false
                labelsFont.pixelSize: 12
            }
            axisX: axisX
            BarSet{
                label: "bob"; values: [bobValue1, bobValue2, bobValue3, bobValue4]
                color: "#24B300"
            }
        }
    }
}
