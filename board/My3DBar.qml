import QtQuick 2.0
import QtDataVisualization 1.2
Item {
    width: 300
    height: 300
    x: 50
    y: 100
    z:-1

    property double cameraRotationX: 0 // 初始的相机旋转角度
    property double cameraRotationY: 0 // 初始的相机旋转角度
    property alias dataModel_1: dataModel_1
    property alias dataModel_2: dataModel_2
    property alias dataModel_3: dataModel_3
    property alias dataModel_4: dataModel_4

    property string color_velocity: "#74F4B8"
    property string color_course: "#63635E"
    property string color_cte: "#EA74F5"
    property string color_distance: "#F5F574"
    property string color_high: "blue"

    property real fontpixelSize: 13

    // 主体
    ThemeColor{
        id: color1
        color: color_velocity
    }
    ThemeColor{
        id: color2
        color: color_course
    }
    ThemeColor{
        id: color3
        color: color_cte
    }
    ThemeColor{
        id: color4
        color: color_distance
    }

    Theme3D{
        id: dynamicColorTheme
        type: Theme3D.ThemeEbony
        baseColors: [color1,color2,color3,color4]
        backgroundColor: Qt.hsla(230, 0.64, 0.06, 1)
        windowColor: Qt.hsla(230, 0.64, 0.06, 1) // 应用窗口的背景颜色
        labelBorderEnabled: false
        labelBackgroundColor: "transparent"
        labelTextColor: "transparent"
        gridEnabled: false
        font.pointSize: 50
    }

    // 值大小
    ValueAxis3D{
        id: valueAxis
        min: 0
        max: 100
    }

    // 主体
    Bars3D {
        id: bar3D
        width: parent.width
        height: parent.height
        theme: dynamicColorTheme
        scene.activeCamera.xRotation: cameraRotationX
        scene.activeCamera.yRotation: cameraRotationY
        scene.activeCamera.zoomLevel: 150
        valueAxis: valueAxis
        barThickness: 5
        barSpacing: Qt.size(0.5,0.5)
        Bar3DSeries {
            id: barSer
            itemLabelFormat: "@colLabel, @rowLabel: @valueLabel"
            ItemModelBarDataProxy {
                itemModel: dataModel_1
                rowRole: "rowLabel"
                columnRole: "columnLabel"
                valueRole: "expense"
            }
        }

        Bar3DSeries {
            itemLabelFormat: "@colLabel, @rowLabel: @valueLabel"
            ItemModelBarDataProxy {
                itemModel: dataModel_2
                rowRole: "rowLabel"
                columnRole: "columnLabel"
                valueRole: "expense"
            }
        }
        Bar3DSeries {
            itemLabelFormat: "@colLabel, @rowLabel: @valueLabel"
            ItemModelBarDataProxy {
                itemModel: dataModel_3
                rowRole: "rowLabel"
                columnRole: "columnLabel"
                valueRole: "expense"
            }
        }
        Bar3DSeries {
            itemLabelFormat: "@colLabel, @rowLabel: @valueLabel"
            ItemModelBarDataProxy {
                itemModel: dataModel_4
                rowRole: "rowLabel"
                columnRole: "columnLabel"
                valueRole: "expense"
            }
        }
    }

    // 数字ListModel
    ListModel {
        id: dataModel_1
        ListElement{ columnLabel: "速度偏差"; rowLabel: "值";    expenses: 30}
    }

    ListModel {
        id: dataModel_2
        ListElement{ columnLabel: "艏向偏差"; rowLabel: "值";    expenses: 10}
    }

    ListModel {
        id: dataModel_3
        ListElement{ columnLabel: "横侧偏差"; rowLabel: "值";    expenses: 40}
    }

    ListModel {
        id: dataModel_4
        ListElement{ columnLabel: "目标距离"; rowLabel: "值";    expenses: 50}
    }

    // 旋转区域
    Rectangle{
        id: mouseArea
        x:42; y:44; z: -1
        width: 215; height: 106
        border.color: "transparent"
        color: "transparent"

        property double lastX
        property double lastY
        property double currentX
        property double currentY

        MouseArea{
            property bool isCameraRotation: false
            anchors.fill: parent
            onDoubleClicked: {
                bar3D.scene.activeCamera.xRotation = 0
                bar3D.scene.activeCamera.yRotation = 0
                color1.color = color_velocity
                color2.color = color_course
                color3.color = color_cte
                color4.color = color_distance
            }
        }
    }

    // 图例1
    Rectangle{
        id: box_1
        x: 270; y: 40
        width: 150; height: 20
        color: "transparent"; border.color: "white"

        SequentialAnimation{
            id: animation1
            running: false
            NumberAnimation{
                target: box_1; property: "scale"
                from:1; to:0.8; duration: 100;
            }
            NumberAnimation{
                target: box_1; property: "scale"
                from:0.8; to:1; duration: 100
            }
        }

        // 图例
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 22
            anchors.bottom: parent.bottom
            color: "white"
            text: "速度偏差: " + dataModel_1.get(0).expenses + "米/秒"
            font.family: "Monaco"
            font.pixelSize: fontpixelSize
        }

        Rectangle{
            width: 15; height: 15
            color: color_velocity
            anchors.left: parent.left
            anchors.leftMargin: 2.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2.5
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                animation1.start()
                color2.color = color_course
                color3.color = color_cte
                color4.color = color_distance
                if(color1.color != color_high)
                    color1.color = color_high;
            }
        }
    }

    // 图例2
    Rectangle{
        id: box_2
        x: 270; y: 70
        width: 150; height: 20
        color: "transparent"; border.color: "white"

        SequentialAnimation{
            id: animation2
            running: false
            NumberAnimation{
                target: box_2; property: "scale"
                from:1; to:0.8; duration: 100;
            }
            NumberAnimation{
                target: box_2; property: "scale"
                from:0.8; to:1; duration: 100
            }
        }


        Text {
            anchors.left: parent.left
            anchors.leftMargin: 22
            anchors.bottom: parent.bottom
            color: "white"
            text: "艏向偏差: " + dataModel_2.get(0).expenses + "度"
            font.family: "Monaco"
            font.pixelSize: fontpixelSize
        }

        Rectangle{
            width: 15; height: 15
            color: color_course
            anchors.left: parent.left
            anchors.leftMargin: 2.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2.5
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                animation2.start()
                color3.color = color_cte
                color4.color = color_distance
                color1.color = color_velocity;
                if(color2.color != color_high)
                    color2.color = color_high
            }
        }
    }

    // 图例3
    Rectangle{
        id: box_3
        x: 270; y: 100
        width: 150; height: 20
        color: "transparent"; border.color: "white"

        SequentialAnimation{
            id: animation3
            running: false
            NumberAnimation{
                target: box_3; property: "scale"
                from:1; to:0.8; duration: 100;
            }
            NumberAnimation{
                target: box_3; property: "scale"
                from:0.8; to:1; duration: 100
            }
        }


        Text {
            anchors.left: parent.left
            anchors.leftMargin: 22
            anchors.bottom: parent.bottom
            color: "white"
            text: "横侧偏差: " + dataModel_3.get(0).expenses + "米"
            font.family: "Monaco"
            font.pixelSize: fontpixelSize
        }

        Rectangle{
            width: 15; height: 15
            color: color_cte
            anchors.left: parent.left
            anchors.leftMargin: 2.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2.5
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                animation3.start()
                color1.color = color_velocity;
                color2.color = color_course;
                color4.color = color_distance;
                if(color3.color != color_high)
                    color3.color = color_high;
            }
        }
    }

    // 图例4
    Rectangle{
        id: box_4
        x: 270; y: 130
        width: 150; height: 20
        color: "transparent"; border.color: "white"

        SequentialAnimation{
            id: animation4
            running: false
            NumberAnimation{
                target: box_4; property: "scale"
                from:1; to:0.8; duration: 100;
            }
            NumberAnimation{
                target: box_4; property: "scale"
                from:0.8; to:1; duration: 100
            }
        }


        Text {
            anchors.left: parent.left
            anchors.leftMargin: 22
            anchors.bottom: parent.bottom
            color: "white"
            text: "目标距离" + dataModel_4.get(0).expenses + "米"
            font.family: "Monaco"
            font.pixelSize: fontpixelSize
        }

        Rectangle{
            width: 15; height: 15
            color: color_distance
            anchors.left: parent.left
            anchors.leftMargin: 2.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2.5
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                animation4.start()
                color1.color = color_velocity;
                color2.color = color_course;
                color3.color = color_cte;
                if(color4.color != color_high)
                    color4.color = color_high;
            }
        }
    }

    // 值改变
    // 字的位置: bar在100的时候, y=10 && bar在0的时候, y=130, 即bar每变化1, y反向变化1.2
    // 当前的y = 130 - 当前时刻的bar * 1.2

    // 旋转
    // 计算的顺序为先旋转x，再旋转y。
    // 1. x旋转: 在0度的时候, x为32 && 在90度的时候, x为122, 在180度的时候, x为212
    //  从这里可得坐标初始点为(32, 130-当前时刻的bar*1.2)
    // 2. 求得x旋转半径，122 - 32 = 90
    // 3. 求得x旋转后的x坐标，90 - 90*cos(rotationX) + 32
    // 4. 求得y旋转半径，90*sin(rotationX)*sin(rotationY)
    // 5. 求得y旋转后的y坐标，90*sin(rotationX)*sin(rotationY) + 130-currentBar*1.2

    // 在0度, bar为30的时候, y为94 && 在90度，bar为30的时候, y为124
    // 半径为 dataModel_1.get(0).expenses * 1.2, 原点为130
    property double rotationX: bar3D.scene.activeCamera.xRotation
    property double rotationY: bar3D.scene.activeCamera.yRotation
    Text{
        id: data_1
        x: 122 - (122-32)*Math.cos(rotationX*Math.PI/180)
        y: 130 - dataModel_1.get(0).expenses*1.2  + 90 * Math.sin(rotationX*Math.PI/180) * Math.sin(rotationY*Math.PI/180)    //* Math.cos(rotationY*Math.PI/180)//130 - dataModel_1.get(0).expenses * 1.2
        text: dataModel_1.get(0).expenses.toFixed(1) + "m/s"
        font.family: "Monaco"
        font.pixelSize: fontpixelSize
        color: "white"
    }
    onRotationYChanged: {
        console.log(rotationY);
        console.log(rotationX)
    }

    Component.onCompleted: {
        console.log(dataModel_1.get(0).expenses);
        console.log(data_1.y)
    }
}
