import QtQuick

Item {
    id:root
    implicitWidth: 256
    implicitHeight: 256

    Image {
        id: clockHand

        source: "images/clock_Hand.svg"
        anchors.horizontalCenter: clockFace.horizontalCenter
        anchors.bottom: clockFace.verticalCenter

        transformOrigin: Item.Bottom
        //rotation: root.angel
        antialiasing: true
    }

    Image {
        id: clockFace

        source: "images/clock.svg"

        MouseArea {
            id: mouseArea

            property int centerX: clockHand.x + clockHand.width / 2
            property int centerY: root.height / 2
            property vector2d centerPoint: Qt.vector2d(centerX, centerY)

            anchors.fill: clockFace
        }
    }


}
