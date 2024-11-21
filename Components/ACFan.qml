import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "../Components"

// 空调风量
//Popup显示浮动窗口的控件，通常用作菜单、对话框或工具提示等。
//它能够在屏幕的指定位置显示，并允许用户与其内容进行交互。
//Popup 不会直接作为主要 UI 的一部分显示，而是通过触发事件显式打开或关闭。
Popup {
    id: root

    property string backgroundColor: "#222A3B"
    property int realLevel: 5 //最开始显示的挡位，风扇的实际挡位
    property int fanLevel: fanSlider.value //根据滑动条的值确定的挡位

    property int delay: 3000 //延迟时间，popup弹窗显示的时间

    onOpened: { //被打开时重新计时
        timer.restart()
    }

    closePolicy: Popup.CloseOnPressOutside //弹窗关闭策略，点击弹窗外自动关闭
    modal: false //弹出后是否还能背景内容进行交互，false是可以继续交互
    parent: Overlay.overlay //设置弹窗的父组件，Overlay.overlay是显示在所有弹窗之上

    //Transition定义界面元素在状态变化时的过渡效果的元素
    enter: Transition { //enter:popup组件显示时的动画效果
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 300
            easing: {type: Easing.OutQuad}//easing动画的缓动效果，Easing.OutQuad开始快，结束慢
        }
    }

    exit: Transition {//enter:popup组件消失时的动画效果
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 300
            easing: {type: Easing.OutQuad}
        }
    }

    Timer {
        id: timer
        interval: root.delay
        repeat: false

        onTriggered: { //信号触发时的效果
            root.close()
        }
    }

    // 风量
    background: Rectangle {
        id: backgroundRectangle
        anchors.fill: parent
        radius: 63
        color: backgroundColor
        opacity: 0.7
    }

    ColorSlider {
        id: fanSlider
        width: 535
        height: 19
        anchors.centerIn: parent
        minValue: 0
        maxValue: 10
        value: ui.acFanLevel

        onValueChanged: {
            timer.restart()
            ui.acFanLevel = value
        }
    }

    // 风量-按钮
    Button {
        id: subButton
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.leftMargin: 39
        anchors.verticalCenter: parent.verticalCenter
        hoverEnabled: false
        autoRepeat: true //长按是否可以触发
        autoRepeatInterval: 200//长按触发间隔

        background: Image {
            width: 21
            height: 21
            anchors.centerIn: parent
            source: "qrc:/Images/ACFan/fan_sub.png"
            fillMode: Image.PreserveAspectFit
            opacity: parent.down ? 0.6 : 1
        }

        onPressed: timer.restart() //按下重新计时

        onClicked: {
            timer.restart()
            if(fanSlider.value > 0)
            {
                fanSlider.value -= 1
            }
        }
        onPressAndHold: {
            timer.restart()
            if(fanSlider.value > 0)
            {
                fanSlider.value -= 1
            }
        }
    }

    // 风量+按钮
    Button {
        id: addButton
        width: 50
        height: 50
        anchors.right: parent.right
        anchors.rightMargin: 39
        anchors.verticalCenter: parent.verticalCenter
        hoverEnabled: false
        autoRepeat: true
        autoRepeatInterval: 200

        background: Image {
            width: 33
            height: 33
            anchors.centerIn: parent
            source: "qrc:/Images/ACFan/fan_add.png"
            fillMode: Image.PreserveAspectFit
            opacity: parent.down ? 0.6 : 1
        }

        onPressed: timer.restart()

        onClicked: {
            timer.restart()
            if(fanSlider.value < 10)
            {
                fanSlider.value += 1
            }
        }

        onPressAndHold: {
            timer.restart()
            if(fanSlider.value < 10)
            {
                fanSlider.value += 1
            }
        }
    }
}
