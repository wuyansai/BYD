import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// 空调控制栏
Item {
    id: root

    property string background: "#2B364B"
    property int buttonWidth: width / 4

    // 0-空调
    // 1-通风加热
    // 2-滤净
    // 3-空调设置
    property int functionValue: 0

    // 背景
    Rectangle {
        anchors.fill: parent
        color: parent.background
        radius: 43
    }

    // 按钮背景
    Rectangle {
        id: selectedRectangle
        width: buttonWidth
        height: parent.height
        y: 0
        radius: 51
        gradient: Gradient { //设置渐变效果，从#43FFFF到#0978E9水平方向过度
            orientation: Gradient.Horizontal //过度方向
            GradientStop { position: 0.0; color: "#43FFFF" }
            GradientStop { position: 1.0; color: "#0978E9" }
        }

        state: getState()//state定义控件在不同状态下的属性和行为的属性

        function getState()
        {
            switch(functionValue)
            {
                case 0: return "FUNCTION1"
                case 1: return "FUNCTION2"
                case 2: return "FUNCTION3"
                case 3: return "FUNCTION4"
            }
        }

        states: [
            State {
                name: "FUNCTION1"
                PropertyChanges {
                    target: selectedRectangle
                    x: 0
                }
            },
            State {
                name: "FUNCTION2"
                PropertyChanges {
                    target: selectedRectangle
                    x: buttonWidth
                }
            },
            State {
                name: "FUNCTION3"
                PropertyChanges {
                    target: selectedRectangle
                    x: buttonWidth * 2
                }
            },
            State {
                name: "FUNCTION4"
                PropertyChanges {
                    target: selectedRectangle
                    x: buttonWidth * 3
                }
            }
        ]

        transitions: [
            Transition {
                to: "FUNCTION2"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "x"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            },
            Transition {
                to: "FUNCTION1"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "x"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            },
            Transition {
                to: "FUNCTION3"
                PropertyAnimation { //平滑过度动画效果
                    target: selectedRectangle
                    properties: "x"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            },
            Transition {
                to: "FUNCTION4"
                PropertyAnimation {
                    target: selectedRectangle
                    properties: "x"
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            }
        ]
    }


    Row {
        anchors.fill: parent

        // 空调按钮
        RadioButton { //单选按钮，多个选项旋转一个
            id: acRadioButton
            width: buttonWidth
            height: parent.height
            checked: true //默认选中

            indicator: Rectangle {color: "transparent"}//indicator控制着单选按钮的外观

            Label {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("空调")
                color: "#FFFFFF"
                font.pixelSize: 24
            }

            onCheckedChanged: checked ? functionValue = 0 : ""//选中设为0，其他为空
        }

        // 通风加热按钮
        RadioButton {
            id: ventilationRadioButton
            width: buttonWidth
            height: parent.height
            indicator: Rectangle {color: "transparent"}

            Label {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("通风加热")
                color: "#FFFFFF"
                font.pixelSize: 24
            }

            onCheckedChanged: checked ? functionValue = 1 : ""
        }

        // 滤净按钮
        RadioButton {
            id: filterRadioButton
            width: parent.width / 4
            height: parent.height
            indicator: Rectangle {color: "transparent"}

            Label {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("滤净")
                color: "#FFFFFF"
                font.pixelSize: 24
            }

            onCheckedChanged: checked ? functionValue = 2 : ""
        }

        // 空调设置按钮
        RadioButton {
            id: acSettingsRadioButton
            width: buttonWidth
            height: parent.height
            indicator: Rectangle {color: "transparent"}

            Label {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("空调设置")
                color: "#FFFFFF"
                font.pixelSize: 24
            }

            onCheckedChanged: checked ? functionValue = 3 : ""
        }
    }

}
