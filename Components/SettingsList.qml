﻿import QtQuick
import QtQuick.Controls

// 设置列表
Item {
    id: root

    property int contentWidth: root.width * 0.9
    property int contentHeight: 3000

    property int itemPadding: 115 //内边距
    property int functionValue: ui.settingsFunctionValue //面板输入值

    signal moveStarted
    signal moveEnded

    onFunctionValueChanged: {
        console.log("y: " + y)
        switch(functionValue)
        {
            case 0: flickable.contentY = 0; break
            case 1: flickable.contentY = 430; break
            case 2: flickable.contentY = 980; break
            case 3: flickable.contentY = 1480; break
            case 4: flickable.contentY = 1740; break
            case 5: flickable.contentY = 1980; break
            case 6: flickable.contentY = 2220; break
            case 7: flickable.contentY = 2470; break
        }
    }

    Flickable { //创建一个可以滚动和拖动的区域
        id: flickable
        width: root.width
        height: root.height
        x: 0
        y: 0
        clip: true
        contentWidth: root.width
        contentHeight: root.contentHeight
        // flickDeceleration: 5000
        maximumFlickVelocity: 5000

        onFlickStarted: {
            console.log("Flick Started")
        }

        onFlickEnded: {
            console.log("Flick Ended")
        }

        onMovementStarted: {
            console.log("Movement Started")
            moveStarted()
        }

        onMovementEnded: {
            console.log("Movement Ended")
            moveEnded()
            //确保不会停在块的中间位置
            console.log("contentY: " + contentY)
            if((contentY >= 0) && (contentY < 430))
                ui.settingsFunctionValue = 0
            else if((contentY >= 430) && (contentY < 980))
                ui.settingsFunctionValue = 1
            else if((contentY >= 980) && (contentY < 1480))
                ui.settingsFunctionValue = 2
            else if((contentY >= 1480) && (contentY < 1740))
                ui.settingsFunctionValue = 3
            else if((contentY >= 1740) && (contentY < 1980))
                ui.settingsFunctionValue = 4
            else if((contentY >= 1980) && (contentY < 2220))
                ui.settingsFunctionValue = 5
            else if((contentY >= 2220) && (contentY < 2470))
                ui.settingsFunctionValue = 6
            else
                ui.settingsFunctionValue = 7
        }

        rebound: Transition { //设置回弹效果
            NumberAnimation {
                properties: "x,y"
                duration: 1000
                easing.type: Easing.OutBounce
            }
        }

        Item {
            id: flickableItem
            width: root.contentWidth
            height: root.contentHeight
            x: 38
            y: 20

            // 智能底盘
            Rectangle {
                id: rect1
                width: parent.width
                height: 380
                radius: 20
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 0
                color: "transparent"
                // color: "#800000FF"

                Label {
                    text: qsTr("智能底盘")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                Label {
                    text: qsTr("转向助力模式")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 68
                }

                FunctionBar2 {
                    width: parent.width
                    height: 42
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 113
                    function1Text: qsTr("舒适")
                    function2Text: qsTr("运动")
                    functionValue: ui.settingsSteering

                    onFunctionValueChanged: {
                        ui.settingsSteering = functionValue
                    }
                }

                Label {
                    text: qsTr("交通环境")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 183
                }

                FunctionBar2 {
                    width: parent.width
                    height: 42
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 228
                    function1Text: qsTr("城市")
                    function2Text: qsTr("越野")
                    functionValue: ui.settingsTrafficEnvironment

                    onFunctionValueChanged: {
                        ui.settingsTrafficEnvironment = functionValue
                    }
                }

                Label {
                    text: qsTr("舒适停车")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 298
                }

                Switch {
                    width: 70
                    height: 36
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 343
                    checked: ui.settingsParking

                    indicator: Image {
                        width: parent.width
                        height: parent.height
                        source: parent.checked ?
                                "qrc:/Images/Settings/switch_on.png" :
                                "qrc:/Images/Settings/switch_off.png"
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                    }

                    onCheckedChanged: {
                        console.log("舒适停车: " + (checked ? "开" : "关"))
                        ui.settingsParking = checked
                    }
                }
            }

            // 灯光氛围
            Rectangle {
                id: rect2
                width: parent.width
                height: 500
                radius: 20
                anchors.left: parent.left
                anchors.top: rect1.bottom
                anchors.topMargin: 45
                color: "transparent"
                // color: "#8000FF00"

                Label {
                    text: qsTr("灯光氛围")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                Label {
                    text: qsTr("大灯高度调节")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 68
                }
                Label {
                    text: lampSlider.value + qsTr(" 档")
                    font.pixelSize: 18
                    font.bold: true
                    color: "#FFFFFF"
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 68
                }

                ColorSlider {
                    id: lampSlider
                    width: parent.width
                    height: 19
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 113
                    minValue: 0
                    maxValue: 9
                    value: ui.settingsLampHeight

                    onValueChanged: {
                        ui.settingsLampHeight = value
                    }
                }

                Label {
                    text: qsTr("制动助力模式")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 183
                }

                FunctionBar3 {
                    width: parent.width
                    height: 42
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 228
                    function1Text: qsTr("整车")
                    function2Text: qsTr("前排")
                    function3Text: qsTr("后排")
                }

                Label {
                    text: qsTr("氛围灯")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 298
                }

                Switch {
                    width: 70
                    height: 36
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 343

                    indicator: Image {
                        width: parent.width
                        height: parent.height
                        source: parent.checked ?
                                "qrc:/Images/Settings/switch_on.png" :
                                "qrc:/Images/Settings/switch_off.png"
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                    }

                    onCheckedChanged: {
                        console.log("氛围灯: " + (checked ? "开" : "关"))
                    }
                }

                Label {
                    text: qsTr("氛围灯动态色彩")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 413
                }

                Switch {
                    width: 70
                    height: 36
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 458

                    indicator: Image {
                        width: parent.width
                        height: parent.height
                        source: parent.checked ?
                                "qrc:/Images/Settings/switch_on.png" :
                                "qrc:/Images/Settings/switch_off.png"
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                    }

                    onCheckedChanged: {
                        console.log("氛围灯动态色彩: " + (checked ? "开" : "关"))
                    }
                }
            }

            // 抬头显示
            Rectangle {
                id: rect3
                width: parent.width
                height: 465
                radius: 20
                anchors.left: parent.left
                anchors.top: rect2.bottom
                anchors.topMargin: 45
                color: "transparent"
                // color: "#80FF0000"

                Label {
                    text: qsTr("抬头显示")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                Label {
                    text: qsTr("高度调节")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 68
                }

                Switch {
                    width: 70
                    height: 36
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 113

                    indicator: Image {
                        width: parent.width
                        height: parent.height
                        source: parent.checked ?
                                "qrc:/Images/Settings/switch_on.png" :
                                "qrc:/Images/Settings/switch_off.png"
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                    }

                    onCheckedChanged: {
                        console.log("氛围灯: " + (checked ? "开" : "关"))
                    }
                }

                Label {
                    text: qsTr("高度调节")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 183
                }

                ColorSlider {
                    id: heightSlider
                    width: parent.width
                    height: 19
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 228
                    minValue: 0
                    maxValue: 9
                    value: 5
                }

                Label {
                    text: qsTr("亮度调节")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 288
                }

                ColorSlider {
                    id: brightnessSlider
                    width: parent.width
                    height: 19
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 333
                    minValue: 0
                    maxValue: 9
                    value: 5
                }

                Label {
                    text: qsTr("旋转调节")
                    font.pixelSize: 18
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 393
                }

                ColorSlider {
                    id: rotationSlider
                    width: parent.width
                    height: 19
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 438
                    minValue: 0
                    maxValue: 9
                    value: 5
                }
            }

            // 迎宾
            Rectangle {
                id: rect4
                width: parent.width
                height: 200
                radius: 20
                anchors.left: parent.left
                anchors.top: rect3.bottom
                anchors.topMargin: 45
                // color: "transparent"
                color: "#80555555"

                Label {
                    text: qsTr("迎宾")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }
            }

            // 智能记忆
            Rectangle {
                id: rect5
                width: parent.width
                height: 200
                radius: 20
                anchors.left: parent.left
                anchors.top: rect4.bottom
                anchors.topMargin: 45
                // color: "transparent"
                color: "#80555555"

                Label {
                    text: qsTr("智能记忆")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }
            }

            // 空调
            Rectangle {
                id: rect6
                width: parent.width
                height: 200
                radius: 20
                anchors.left: parent.left
                anchors.top: rect5.bottom
                anchors.topMargin: 45
                // color: "transparent"
                color: "#80555555"

                Label {
                    text: qsTr("空调")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }
            }

            // 门窗和锁
            Rectangle {
                id: rect7
                width: parent.width
                height: 200
                radius: 20
                anchors.left: parent.left
                anchors.top: rect6.bottom
                anchors.topMargin: 45
                // color: "transparent"
                color: "#80555555"

                Label {
                    text: qsTr("门窗和锁")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }
            }

            // 智能提醒
            Rectangle {
                id: rect8
                width: parent.width
                height: 200
                radius: 20
                anchors.left: parent.left
                anchors.top: rect7.bottom
                anchors.topMargin: 45
                // color: "transparent"
                color: "#80555555"

                Label {
                    text: qsTr("智能提醒")
                    font.pixelSize: 28
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }
            }
        }
    }

    // 滚动条
    Rectangle {
        id: scrollBar
        anchors.right: flickable.right
        y: getY()
        width: 12
        height: 130
        radius: 23
        color: "#364A5E"

        function getY()
        {
            var y = flickable.visibleArea.yPosition * flickable.height
            var maxY = flickable.height - height
            if(y < 0)
            {
                return 0
            }
            else if(y > maxY)
            {
                return maxY
            }
            else
            {
                return y
            }
        }
    }
}
