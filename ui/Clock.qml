import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    property string time
    property bool isAddTask

    id:clock
    title: "Clock"

    Column {
        spacing: 30

        Label{
            text: "Select time"
        }

        Row {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            TextField {
                id:time1
                width: 50
            }

            Label {
                text: ":"
                font.bold: true
                font.pixelSize: 30
                anchors.verticalCenter: parent.verticalCenter
            }

            TextField {
                id:time2
                width: 50
            }
        }
    }

    standardButtons: Dialog.Close | Dialog.Ok

    onAccepted: {
        time = time1.text + ":" + time2.text

        if(isAddTask)
            clockInput.text = time
        else
            timeInput.text = time
    }
}











