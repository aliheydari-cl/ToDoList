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
            placeholderText: "New title"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
        }

        TextField {
            id: timeInput
            placeholderText: "New time"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200

            ToolButton {
                anchors.right: timeInput.right
                anchors.verticalCenter: timeInput.verticalCenter
                icon.source: "images/clock-icon"

                onClicked: {
                    clock.open()
                }
            }
        }

        TextField {
            id: descriptionInput
            placeholderText: "New description"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200

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

        database.editDataBase(titleTemp, timeTemp, descriptionTemp, descriptionText, titleText)

        listModel.clear()
        database.getDataBase()
        for (var i = 0; i < database.list.length; i +=3) {
                listModel.append({_title: database.list[i], _des: database.list[i+1], _time: database.list[i+2]});
            }

        titleInput.text = ""
        timeInput.text = ""
        descriptionInput.text = ""
    }
}












