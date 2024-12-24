import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: dialog
    width: 300
    height: 400

    x: Math.round((window.width - width) / 2)
    y: Math.round(window.height / 6)

    title: "Edit task"

    property string titleText
    property string descriptionText
    property string timeText

    Clock {
        id:clock
        isAddTask: false
    }

    Column {
        spacing: 30
        anchors.fill: parent

        TextField {
            id: titleInput
            width: 200
            placeholderText: "New title"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: Font.Medium
        }

        TextField {
            id: timeInput
            width: 200
            placeholderText: "New time"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: Font.Medium

            ToolButton {
                anchors.right: timeInput.right
                anchors.verticalCenter: timeInput.verticalCenter
                icon.source: "qrc:/images/clock-icon"

                onClicked: {
                    clock.open()
                }
            }
        }

        TextField {
            id: descriptionInput
            width: 200
            placeholderText: "New description"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: Font.Medium
        }
    }

    standardButtons: Dialog.Close | Dialog.Ok

    property string titleTemp
    property string descriptionTemp
    property string timeTemp

    onAccepted: {
        titleTemp = titleInput.text.length < 1 ? titleText : titleInput.text
        timeTemp = timeInput.text.length < 1 ? timeText : timeInput.text
        descriptionTemp = descriptionInput.text.length < 1 ? descriptionText : descriptionInput.text

        database.editDatabase(titleTemp, timeTemp, descriptionTemp, descriptionText, titleText)

        titleInput.text = ""
        timeInput.text = ""
        descriptionInput.text = ""
    }
}












