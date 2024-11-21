import QtQuick
import QtQuick.Controls
import QtQuick.Particles
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes


ParticleSystem {
    id: root

    property int moveX: 0//移动量
    property int moveY: 0
    property color color: "white"
    property int offsetX: 0
    property int offsetY: 0
    property int emitterWidth: 80
    property int emitterHeight: 30
    property int value: 0
    property string source: ""

    ImageParticle {
        groups: ["fog"]
        source: root.source
        opacity: 0.03    // 调整透明度
        entryEffect: ImageParticle.Scale //粒子效果，ImageParticle.Scale刚开始会有缩放效果，从小到大
        rotationVariation: 0 //随机旋转度数

        color: root.color
        colorVariation: 0
    }

    Emitter {
        y: parent.height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        emitRate: 300 * value
        lifeSpan: 1000
        lifeSpanVariation: 1
        group: "fog"

        width: emitterWidth
        height: emitterHeight
        system: root //在定义一个信号时指定其触发对象

        size: 50            // 初始粒子大小
        endSize: -1          // 粒子结束时的大小
        sizeVariation: 0 //大小变化范围

        velocity: TargetDirection {
            targetX: getTargetX()
            targetY: getTargetY()
            targetVariation: 100 // 原点到目标散射
            magnitude: 200 * value * 0.5 //速度的幅度

            function getTargetX()
            {
                return root.moveX * 4 - offsetX
            }

            function getTargetY()
            {
                return root.moveY * 4 - offsetY
            }
        }
    }

    Turbulence { //设置扰动效果
        groups: ["fog"] // 指定效果的分组
        width: parent.width
        height: parent.height * 0.8
        strength: 50 // 设置扰动的强度，值越大，效果越明显
    }
}

