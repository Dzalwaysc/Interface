/****************************************************************************
**     该文件在SerialPortListView中使用
**           单击ListView中的内容后，从屏幕最左边弹出一个选项卡
**串口消息
**串口名称，数据位，停止位，奇偶性
**Column定义显示文本
**在窗口右下角'openbutton'定义一个开始/关闭按钮
**
** signal: state_transition 用于其他对象控制此状态。
** 例如我们可以用鼠标敲击: xxx.state_tansition()
** 然后，该对象将有一个动画
** signal: close 用于控制 state "active" to state ""

**用户接口
** property: commPort, dataBits, stopBits, parity
** 分别对于串口名称，数据位，停止位，奇偶性
** property: source, imgname
** 这两项属性对应选项卡的图片，和图片下面的文本
****************************************************************************/

import QtQuick 2.0
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../button"
import io.serialport 1.0

Message{
    rectColor: "transparent"
    borderColor: "#ffffff"

    // 串口信息
    property string commPort: "COM10"
    property string buadRate: "9600"

    // 信息卡的信息
    property string commName: "空置串口"
}

