import QtQuick

Item {
    id: root
    implicitWidth: 256
    implicitHeight: 256

    property int hClock
    property int mClock
    property bool hClockFocus: true

    property var hoursArray: [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    property var minutesArray: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    property var angles: [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330]

    Image {
        id: clockFace
        source: hClockFocus ? "qrc:/images/clock.svg" : "qrc:/images/Minutes_Clock.svg"
        z: 2
    }

    Image {
        id: clockHand
        source: "qrc:/images/clock_Hand.svg"
        anchors.horizontalCenter: clockFace.horizontalCenter
        anchors.bottom: clockFace.verticalCenter
        rotation: 0
        transformOrigin: Item.Bottom
        z: 1
    }

    MouseArea {
        id: mouseArea

        property real centerX: clockFace.width / 2
        property real centerY: clockFace.height / 2

        anchors.fill: clockFace

        function calculateAngle(x, y) {
            var deltaX = x - centerX;
            var deltaY = y - centerY;
            var angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI + 90;
            return (angle < 0) ? angle + 360 : angle;
        }

        function findClosestAngle(angle) {
            var closestIndex = 0;
            var minDiff = Math.abs(angle - angles[0]);

            for (var i = 1; i < angles.length; i++) {
                var diff = Math.abs(angle - angles[i]);
                if (diff < minDiff) {
                    minDiff = diff;
                    closestIndex = i;
                }
            }

            if (hClockFocus) {
                hClock = hoursArray[closestIndex];
            } else {
                mClock = minutesArray[closestIndex];
            }

            return angles[closestIndex];
        }

        onClicked: {
            var clickedAngle = calculateAngle(mouseX, mouseY);
            clockHand.rotation = findClosestAngle(clickedAngle);
        }
    }
}
