import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Item {
    id: root

    property string color: "#FFFFFF"
    property string backgroundColor: "#80000000"
    property string startColor: "#0532FB"
    property string endColor: "#52E6FB"

    property string sourceOn: "" //开启和结束的图片路径
    property string sourceOff: ""
    property int sourceWidth: 36
    property int sourceHeight: 30
    property int spacing: 5 //控件间隔

    property int textWidth: 10
    property int textHeight: 10
    property string text: ""
    property int fontPixelSize: 20
    property int autoFontPixelSize: 14
    property color textColor: "#FFFFFF"
    property color autoTextColor: "#80FFFFFF"

    property bool switchStatus: false //开关状态 false关闭

    property int minValue: 0
    property int maxValue: 10
    property int value: 5
    property int stepSize: 1


    Rectangle {
        id: backroundRectangle
        anchors.fill: parent
        color: root.backgroundColor
        radius: 14

        Rectangle {
            id: innerRectangle
            width: getWidth()
            height: parent.height
            x: 0
            anchors.verticalCenter: parent.verticalCenter
            radius: 14

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: startColor }
                GradientStop { position: 1.0; color: endColor }
            }

            property real stepSize: backroundRectangle.width / (slider.to)//确定滑动块的步长

            function getWidth()
            {
                if(slider.value == slider.to)
                {
                    var width = (slider.value + 1) * stepSize //增加1，避免视觉上的突然停止或“卡顿”
                    if(width >= backroundRectangle.width)//设置不超过最大宽度
                    {
                        width = backroundRectangle.width
                    }

                    return width
                }
                else
                {
                    return slider.value * stepSize
                }
            }

            function getRadius()
            {
                switch(slider.value)
                {
                    case 1: return 2
                    case 2: return 4
                    case 3: return 6
                    case 4: return 8
                    case 5: return 10
                    case 6: return 12
                    default: return 14
                }
            }
        }

        Slider {
            id: slider
            anchors.fill: parent
            value: root.value
            from: minValue
            to: maxValue
            stepSize: root.stepSize
            focusPolicy: Qt.NoFocus//用于控制一个控件是否能够获取焦点,NoFocus无法获取焦点

            background: Rectangle {
                implicitWidth: 0
                implicitHeight: 0
                color: "transparent"
            }

            handle: Rectangle { //handle表示可拖动部分
                implicitWidth: 0 //0表示自适应父类宽度
                implicitHeight: 0
                color: "transparent"
            }

            onValueChanged: {//通过这个信号将滑块值传递给父类
                // console.log("### value: " + value)
                root.value = value
            }
        }
    }
}
