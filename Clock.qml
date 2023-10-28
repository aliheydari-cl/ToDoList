import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog{
    property alias timeH: time1
    property alias timeM: time2

    id:clock
    title: "Clock"
    x: Math.round((window.width - width) / 2)
    y: Math.round(window.height / 6)

    Column{
        spacing: 30

        Label{
            text: "Select time"
        }

        Row{
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            TextField{
                id:time1
                width: 50
            }

            Label{
                text: ":"
                font.bold: true
                font.pixelSize: 30
                anchors.verticalCenter: parent.verticalCenter
            }

            TextField{
                id:time2
                width: 50
            }
        }
    }

    standardButtons: Dialog.Close | Dialog.Ok

    onAccepted: {
        clockInput.text = time1.text + ":" + time2.text
    }


}











