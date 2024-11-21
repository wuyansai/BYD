﻿import QtQuick
import QtQuick.Controls

// 设置模式栏
Item {
    id: root

    property string background: "#2B364B"

    // 0-DiLink
    // 1-DiPilot
    // 2-新能源
    // 3-车辆设置
    // 3-车辆健康
    property int functionValue: 0
    property int buttonWidth: 204
    property int buttonHeight: 70

    // 左侧背景
    Image {
        id: leftBackgroundImage
        anchors.fill: parent
        source: "qrc:/Images/Settings/left_background.png"
        fillMode: Image.Stretch
    }

    // 按钮背景
    Rectangle {
        id: selectedRectangle
        width: buttonWidth
        height: buttonHeight
        anchors.left: parent.left
        anchors.leftMargin: 18
        radius: 51
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#43FFFF" }
            GradientStop { position: 1.0; color: "#0978E9" }
        }

        state: getState()

        function getState()
        {
            switch(functionValue)
            {
                case 0: return "FUNCTION1"
                case 1: return "FUNCTION2"
                case 2: return "FUNCTION3"
                case 3: return "FUNCTION4"
                case 4: return "FUNCTION5"
            }
        }

        states: [
            State {
                name: "FUNCTION1"
                PropertyChanges {
                    target: selectedRectangle
                    y: 83
                }
            },
            State {
                name: "FUNCTION2"
                PropertyChanges {
                    target: selectedRectangle
                    y: 205
                }
            },
            State {
                name: "FUNCTION3"
                PropertyChanges {
                    target: selectedRectangle
                    y: 327
                }
            },
            State {
                name: "FUNCTION4"
                PropertyChanges {
                    target: selectedRectangle
                    y: 449
                }
            },
            State {
                name: "FUNCTION5"
                PropertyChanges {
                    target: selectedRectangle
                    y: 571
                }
            }
        ]

        transitions: [
            Transition {
                to: "FUNCTION1"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "y"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            },
            Transition {
                to: "FUNCTION2"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "y"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            },
            Transition {
                to: "FUNCTION3"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "y"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            },
            Transition {
                to: "FUNCTION4"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "y"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            },
            Transition {
                to: "FUNCTION5"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "y"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            }
        ]
    }


    // DiLink按钮
    RadioButton {
        width: buttonWidth
        height: buttonHeight
        checked: true
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 83
        indicator: Rectangle {color: "transparent"}

        Label {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("DiLink")
            color: "#FFFFFF"
            font.pixelSize: 24
        }

        onCheckedChanged: checked ? functionValue = 0 : ""
    }

    // DiPilot按钮
    RadioButton {
        width: buttonWidth
        height: buttonHeight
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 205
        indicator: Rectangle {color: "transparent"}

        Label {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("DiPilot")
            color: "#FFFFFF"
            font.pixelSize: 24
        }

        onCheckedChanged: checked ? functionValue = 1 : ""
    }

    // 新能源按钮
    RadioButton {
        width: buttonWidth
        height: buttonHeight
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 327
        indicator: Rectangle {color: "transparent"}

        Label {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("新能源")
            color: "#FFFFFF"
            font.pixelSize: 24
        }

        onCheckedChanged: checked ? functionValue = 2 : ""
    }

    // 车辆设置按钮
    RadioButton {
        width: buttonWidth
        height: buttonHeight
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 449
        indicator: Rectangle {color: "transparent"}

        Label {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("车辆设置")
            color: "#FFFFFF"
            font.pixelSize: 24
        }

        onCheckedChanged: checked ? functionValue = 3 : ""
    }


    // 车辆健康按钮
    RadioButton {
        width: buttonWidth
        height: buttonHeight
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 571
        indicator: Rectangle {color: "transparent"}

        Label {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("车辆健康")
            color: "#FFFFFF"
            font.pixelSize: 24
        }

        onCheckedChanged: checked ? functionValue = 4 : ""
    }

}
