import QtQuick 2.1
import QtQuick.Controls 2.1
import "PhotpConsoleRes.js" as Script
import "../../button"

Item {
    id: photoElectric
    width: 450; height: 265
//    border.color: "white"
//    color: "transparent"
    property string fontFamily: "Monaco"
    property color fontColor: "white"
    property double fontSize: 10

    // 由该控件产生的发送内容
    property string sendMsg
    signal getSendMsg()

    // 外置控件
    property alias whiteLightControl_textInput1: whiteLightControl_textInput1
    property alias stabilityControl_textInput1: stabilityControl_textInput1
    property alias stabilityControl_textInput2: stabilityControl_textInput2
    property alias trackTest_textInput1: trackTest_textInput1
    property alias trackTest_textInput2: trackTest_textInput2
    property alias trackTest_textInput3: trackTest_textInput3

    // 白光控制
    Rectangle{
        id: whiteLightControl
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 5
        border.color: "#979393"
        color: "transparent"
        radius: 4
        width: 160
        height: 90

        // 标题
        Rectangle{
            width: whiteLightControlName.width
            height: whiteLightControlName.height
            implicitHeight: whiteLightControlName.height
            anchors.top: parent.top; anchors.topMargin: -height/2
            color: Qt.hsla(230, 0.64, 0.06, 1)
            x: 10
            opacity: 1
            Text{
                id: whiteLightControlName
                text: "白光控制"
                font.pixelSize: fontSize
                font.family: fontFamily
                color: fontColor
                renderType: TextInput.NativeRendering
                font.hintingPreference: Font.PreferVerticalHinting
            }
        }

        // 按钮
        Grid{
            anchors.left: parent.left; anchors.leftMargin: 8
            anchors.top: parent.top; anchors.topMargin: 13
            rows: 3; rowSpacing: 4
            columns: 3; columnSpacing: 4

            // 放大
            ButtonOne{
                btnText: "放大"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.whiteLightControl_row1column1();
            }

            // 手动调焦
            ButtonOne{
                btnText: "手动调焦"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.whiteLightControl_row1column2();
            }

            // 调焦+
            ButtonOne{
                btnText: "调焦+"
                btnWidth: 45
                fontpielSize: fontSize
            }

            // 缩小
            ButtonOne{
                btnText: "缩小"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.whiteLightControl_row2column1()
            }

            // 自动调焦
            ButtonOne{
                btnText: "自动调焦"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.whiteLightControl_row2column2()
            }

            // 调焦-
            ButtonOne{
                btnText: "调焦-"
                btnWidth: 45
                fontpielSize: fontSize
            }

            // 停止
            ButtonOne{
                btnText: "停止"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.whiteLightControl_row3column1()
            }

            // 变倍
            Rectangle{
                width: 45
                height: 20
                color: "transparent"
                Rectangle{
                    id: timesRect
                    width: 40; height: 20
                    color: "transparent"
                    border.color: "white"
                    TextInput{
                        id: whiteLightControl_textInput1
                        anchors.left: parent.left; anchors.leftMargin: 2
                        anchors.verticalCenter: parent.verticalCenter
                        text: "5"
                        font.family: fontFamily
                        font.pixelSize: fontSize
                        color: fontColor
                        selectByMouse: true
                    }
                }
                ButtonOne{
                    anchors.left: timesRect.right; anchors.leftMargin: 2
                    anchors.top: timesRect.top
                    btnText: "变倍"
                    btnWidth: 45
                    fontpielSize: fontSize
                    onClicked: Script.whiteLightControl_row3column2()
                }
            }
        }

    }

    // 跟踪测试
    Rectangle{
        id: trackTest
        anchors.top: whiteLightControl.bottom; anchors.topMargin: 10
        anchors.left: whiteLightControl.left
        border.color: "#979393"
        color: "transparent"
        radius: 4
        width: 220
        height: 140

        // 标题
        Rectangle{
            width: trackTestName.width
            height: trackTestName.height
            implicitHeight: trackTestName.height
            anchors.top: parent.top; anchors.topMargin: -height/2
            color: Qt.hsla(230, 0.64, 0.06, 1)
            x: 10
            opacity: 1
            Text{
                id: trackTestName
                text: "跟踪测试"
                font.pixelSize: fontSize
                font.family: fontFamily
                color: fontColor
                renderType: TextInput.NativeRendering
                font.hintingPreference: Font.PreferVerticalHinting
            }
        }

        // 按钮
        Grid{
            anchors.left: parent.left; anchors.leftMargin: 8
            anchors.top: parent.top; anchors.topMargin: 13
            rows: 5; rowSpacing: 4
            columns: 3; columnSpacing: 4

            // 白光中心跟踪
            ButtonOne{
                btnText: "白光中心跟踪"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row1column1()
            }

            // 白光坐标跟踪
            ButtonOne{
                btnText: "白光坐标跟踪"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row1column2()
            }

            // 输入框1
            Rectangle{
                width: 65; height: 20
                color: "transparent"
                border.color: "white"
                TextInput{
                    id: trackTest_textInput1
                    anchors.left: parent.left; anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    text: "10,10"
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    color: fontColor
                    selectByMouse: true
                }
            }

            // 红外中心跟踪
            ButtonOne{
                btnText: "红外中心跟踪"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row2column1()
            }

            // 红外坐标跟踪
            ButtonOne{
                btnText: "红外坐标跟踪"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row2column2()
            }

            // 停止跟踪
            ButtonOne{
                btnText: "停止跟踪"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row2column3()
            }

            // 白光跟踪尺寸
            ButtonOne{
                btnText: "白光跟踪尺寸"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row3column1()
            }

            // 红外跟踪尺寸
            ButtonOne{
                btnText: "红外跟踪尺寸"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row3column2()
            }

            // 输入框2
            Rectangle{
                width: 65; height: 20
                color: "transparent"
                border.color: "white"
                TextInput{
                    id: trackTest_textInput2
                    anchors.left: parent.left; anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    text: "输入框"
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    color: fontColor
                    selectByMouse: true
                }
            }


            // 白光跟踪参数
            ButtonOne{
                btnText: "白光跟踪参数"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row4column1()
            }

            // 红外跟踪参数
            ButtonOne{
                btnText: "红外跟踪参数"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row4column2()
            }

            // 输入框3
            Rectangle{
                width: 65; height: 20
                color: "transparent"
                border.color: "white"
                TextInput{
                    id: trackTest_textInput3
                    anchors.left: parent.left; anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    text: "输入框"
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    color: fontColor
                    selectByMouse: true
                }
            }

            // 跟踪信息查询
            ButtonOne{
                btnText: "跟踪信息查询"
                btnWidth: 65
                fontpielSize: fontSize
                onClicked: Script.trackTest_row5column1()
            }

            CheckBox{
                id: trackTest_checkBox1
                width: 65; height: 20
                text: "跟踪特性"

                indicator: Image{
                    height: 13
                    width: 13
                    anchors.verticalCenter: parent.verticalCenter
                    source: parent.checked ? "image/checked.png" : "image/unchecked.png"
                }

                contentItem: Text{
                    id: text
                    anchors.left: parent.left; anchors.leftMargin: 10
                    text: parent.text
                    color: fontColor
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    if (trackTest_checkBox1.checked) Script.trackTest_row5column2_open();
                    else Script.trackTest_row5column2_close();
                }
            }
        }

    }

    // 稳台控制
    Rectangle{
        id: stabilityControl
        anchors.top: whiteLightControl.top
        anchors.left: whiteLightControl.right; anchors.leftMargin: 5
        border.color: "#979393"
        color: "transparent"
        radius: 4
        width: 270
        height: 90

        // 标题
        Rectangle{
            width: stabilityControlName.width
            height: stabilityControlName.height
            implicitHeight: stabilityControlName.height
            anchors.top: parent.top; anchors.topMargin: -height/2
            color: Qt.hsla(230, 0.64, 0.06, 1)
            x: 10
            opacity: 1
            Text{
                id: stabilityControlName
                text: "稳台控制"
                font.pixelSize: fontSize
                font.family: fontFamily
                color: fontColor
                renderType: TextInput.NativeRendering
                font.hintingPreference: Font.PreferVerticalHinting
            }
        }

        // 上
        ButtonOne{
            id: top
            anchors.left: parent.left; anchors.leftMargin: 32
            anchors.top: parent.top; anchors.topMargin: 13
            btnText: "上"
            btnWidth: 20
            fontpielSize: fontSize
            onClicked: Script.stabilityControl_top()
        }

        // 左
        ButtonOne{
            id: left
            anchors.left: parent.left; anchors.leftMargin: 8
            anchors.top: top.bottom; anchors.topMargin: 4
            btnText: "左"
            btnWidth: 20
            fontpielSize: fontSize
            onClicked: Script.stabilityControl_left()
        }

        // 停
        ButtonOne{
            id: stop
            anchors.left: top.left
            anchors.top: left.top
            btnText: "停"
            btnWidth: 20
            fontpielSize: fontSize
            onClicked: Script.stabilityControl_stop()
        }

        // 右
        ButtonOne{
            id: right
            anchors.left: stop.right; anchors.leftMargin: 4
            anchors.top: left.top
            btnText: "右"
            btnWidth: 20
            fontpielSize: fontSize
            onClicked: Script.stabilityControl_right()
        }

        // 下
        ButtonOne{
            id: down
            anchors.left: top.left
            anchors.top: stop.bottom; anchors.topMargin: 4
            btnText: "下"
            btnWidth: 20
            fontpielSize: fontSize
            onClicked: Script.stabilityControl_down()
        }

        // 按钮组合1
        Grid{
            anchors.left: right.right ; anchors.leftMargin: 8
            anchors.top: top.top
            rows: 3; rowSpacing: 4
            columns: 3; columnSpacing: 4

            // 两轴稳像
            ButtonOne{
                btnText: "两轴稳像"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row1column1()
            }

            // 水平稳像
            ButtonOne{
                btnText: "水平稳像"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row1column2()
            }

            // 俯仰稳像
            ButtonOne{
                btnText: "俯仰稳像"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row1column3()
            }

            // 释放
            ButtonOne{
                btnText: "释放"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row2column1()
            }

            // 展开
            ButtonOne{
                btnText: "展开"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row2column2()
            }


            // 零位设置
            ButtonOne{
                btnText: "零位设置"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row2column3()
            }

            // 两轴锁定
            ButtonOne{
                btnText: "两轴锁定"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row3column1()
            }

            // 撤收
            ButtonOne{
                btnText: "撤收"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row3column2()
            }

            // 指定角度
            ButtonOne{
                btnText: "指定角度"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.stabilityControl_row3column3()
            }
        }

        // 输入组合1
        Grid{
            anchors.right: parent.right; anchors.rightMargin: 8
            anchors.top: parent.top; anchors.topMargin: 13
            rows: 2; rowSpacing: 4
            columns: 1; columnSpacing: 4

            // 输入框1
            Rectangle{
                width: 30; height: 20
                color: "transparent"
                border.color: "white"
                TextInput{
                    id: stabilityControl_textInput1
                    anchors.left: parent.left; anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    text: "90"
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    color: fontColor
                    selectByMouse: true
                }
            }

            // 输入框2
            Rectangle{
                width: 30; height: 20
                color: "transparent"
                border.color: "white"
                TextInput{
                    id: stabilityControl_textInput2
                    anchors.left: parent.left; anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    text: "90"
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    color: fontColor
                    selectByMouse: true
                }
            }
        }

    }

    // 红外控制
    Rectangle{
        id: infraredControl
        anchors.top: trackTest.top
        anchors.left: trackTest.right; anchors.leftMargin: 5
        border.color: "#979393"
        color: "transparent"
        radius: 4
        width: 210
        height: 90

        // 标题
        Rectangle{
            width: infraredControlName.width
            height: infraredControlName.height
            implicitHeight: infraredControlName.height
            anchors.top: parent.top; anchors.topMargin: -height/2
            color: Qt.hsla(230, 0.64, 0.06, 1)
            x: 10
            opacity: 1
            Text{
                id: infraredControlName
                text: "白光控制"
                font.pixelSize: fontSize
                font.family: fontFamily
                color: fontColor
                renderType: TextInput.NativeRendering
                font.hintingPreference: Font.PreferVerticalHinting
            }
        }

        // 按钮
        Grid{
            anchors.left: parent.left; anchors.leftMargin: 8
            anchors.top: parent.top; anchors.topMargin: 13
            rows: 2; rowSpacing: 4
            columns: 4; columnSpacing: 4
            signal checkBoxMutex()

            // 调焦+
            ButtonOne{
                btnText: "调焦+"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.infraredControl_row1column1()
            }

            // 调焦-
            ButtonOne{
                btnText: "调焦-"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.infraredControl_row1column2()
            }

            // 调焦停止
            ButtonOne{
                btnText: "调焦停止"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.infraredControl_row1column3()
            }

            // 自动调焦
            ButtonOne{
                btnText: "自动调焦"
                btnWidth: 45
                fontpielSize: fontSize
                onClicked: Script.infraredControl_row1column4()

            }

            // 黑热
            CheckBox{
                id: infraredControlCheck1
                width: 45; height: 20
                text: "黑热"
                indicator: Image{
                    height: 13
                    width: 13
                    anchors.verticalCenter: parent.verticalCenter
                    source: parent.checked ? "image/checked.png" : "image/unchecked.png"
                }

                contentItem: Text{
                    id: checkText1
                    anchors.left: parent.left; anchors.leftMargin: 10
                    text: parent.text
                    color: fontColor
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if(infraredControlCheck1.checked){
                        Script.infraredControl_row2column1();
                        infraredControlCheck2.checked = false;
                        infraredControlCheck3.checked = false;
                        infraredControlCheck4.checked = false;
                    }
                }
            }

            // 白热
            CheckBox{
                id: infraredControlCheck2
                width: 45; height: 20
                text: "白热"

                indicator: Image{
                    height: 13
                    width: 13
                    anchors.verticalCenter: parent.verticalCenter
                    source: parent.checked ? "image/checked.png" : "image/unchecked.png"
                }

                contentItem: Text{
                    id: checkText2
                    anchors.left: parent.left; anchors.leftMargin: 10
                    text: parent.text
                    color: fontColor
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if(infraredControlCheck2.checked){
                        Script.infraredControl_row2column2();
                        infraredControlCheck1.checked = false;
                        infraredControlCheck3.checked = false;
                        infraredControlCheck4.checked = false;
                    }
                }
            }

            // 铁锈红
            CheckBox{
                id: infraredControlCheck3
                width: 45; height: 20
                text: "铁锈红"

                indicator: Image{
                    height: 13
                    width: 13
                    anchors.verticalCenter: parent.verticalCenter
                    source: parent.checked ? "image/checked.png" : "image/unchecked.png"
                }

                contentItem: Text{
                    id: checkText3
                    anchors.left: parent.left; anchors.leftMargin: 12
                    text: parent.text
                    color: fontColor
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if(infraredControlCheck3.checked){
                        Script.infraredControl_row2column3();
                        infraredControlCheck1.checked = false;
                        infraredControlCheck2.checked = false;
                        infraredControlCheck4.checked = false;
                    }
                }
            }

            // 彩虹
            CheckBox{
                id: infraredControlCheck4
                width: 45; height: 20
                text: "彩虹"

                indicator: Image{
                    height: 13
                    width: 13
                    anchors.verticalCenter: parent.verticalCenter
                    source: parent.checked ? "image/checked.png" : "image/unchecked.png"
                }

                contentItem: Text{
                    id: checkText4
                    anchors.left: parent.left; anchors.leftMargin: 10
                    text: parent.text
                    color: fontColor
                    font.family: fontFamily
                    font.pixelSize: fontSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if(infraredControlCheck4.checked){
                        Script.infraredControl_row2column4();
                        infraredControlCheck1.checked = false;
                        infraredControlCheck2.checked = false;
                        infraredControlCheck3.checked = false;
                    }
                }
            }
        }
    }
}
