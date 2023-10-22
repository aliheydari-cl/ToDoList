import QtCore
import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material
import QtQuick.Layouts

import DataBase 1.0

ApplicationWindow {
    id:window
    width: 550
    height: 480
    visible: true
    title: qsTr("ToDoList")
    font.pixelSize: setting.fontSize

    Settings{
        id:setting
        property string backgroundColor
        property int fontSize
    }

    Component.onCompleted: {
        database.getDataBase()
        for (var i = 0; i < database.list.length; i += 2) {
                listModel.append({_title: database.list[i], _des: database.list[i + 1]});
            }
    }

    ListModel{       
        id:listModel
    }
    
    DataBase{
        id:database
    }

    header:Rectangle{
        width: parent.width
        height: 40
        color: "#4CAF50"

        Text{
            text: "ToDoList"
            font.pixelSize: 18
            font.bold: true
            anchors.centerIn: parent
        }

        ToolButton{
            icon.source: "images/menu"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            Menu{
                id: optionsMenu
                x: parent.width - width
                transformOrigin: Menu.TopRight

                Action {
                    text: qsTr("Settings")
                    onTriggered: settingDialog.open()
                    icon.source: "images/settings"
                }
                Action {
                    text: qsTr("Help")
                    onTriggered: helpDialog.open()
                    icon.source: "images/help"
                }
                Action {
                    text: qsTr("About")
                    onTriggered: aboutDialog.open()
                    icon.source: "images/about"

                }
            }

            onClicked: optionsMenu.open()
        }
        Dialog{
            id:aboutDialog
            title: "About"
            x: Math.round((window.width - width) / 2)
            y: Math.round(window.height / 6)
            focus: true
            standardButtons: Dialog.Close
            onAccepted: aboutDialog.close()

            ColumnLayout{
                spacing: 20
                Text {
                    text: qsTr("Created by Ali Heidary")
                }

                Row{
                    Image {
                        source: "images/email"
                        width: 20
                        height: 20
                    }

                    Text {
                        text: qsTr(" Aliheidary885@gmail.com")
                    }
                }
            }
        }

        Dialog{
            id:helpDialog
            title: "Help"
            x: Math.round((window.width - width) / 2)
            y: Math.round(window.height / 6)
            focus: true
            standardButtons: Dialog.Close
            onAccepted: aboutDialog.close()

            Column{
                Text {
                    width: helpDialog.availableHeight
                    text: qsTr("This application allows you to create a list of your daily tasks and activities."
                    + "By entering the title and description for each task, you can add them to your list."
                    + "Additionally, you have the option to remove tasks from your list using the 'Delete' feature.")
                    wrapMode: Text.Wrap
                }
            }
        }

        Dialog{
            id:settingDialog
            title: "Setting"
            x: Math.round((window.width - width) / 2)
            y: Math.round(window.height / 6)
            focus: true
            standardButtons: Dialog.Close | Dialog.Ok
            onAccepted: checkBox.checked ?  setting.backgroundColor = "black" : setting.backgroundColor = "Light"

            onRejected: settingDialog.close()

            ColumnLayout{
                CheckBox{
                    id:checkBox
                    text: "Dark mode"
                    checked: setting.backgroundColor === "Light" ? false : true
                }

                RowLayout {
                    spacing: 12

                    Label {
                        text: qsTr("A")
                        font.pixelSize: 14
                        font.weight: 400
                    }

                    Slider {
                        id: slider
                        Layout.fillWidth: true
                        snapMode: Slider.SnapAlways
                        stepSize: 1
                        from: 14
                        value: setting.fontSize
                        to: 21
                        onMoved: setting.fontSize = value
                    }

                    Label {
                        text: qsTr("A")
                        font.pixelSize: 21
                        font.weight: 400
                    }
                }
            }
        }
    }

    Item{
        id:leftItem
        height: parent.height
        width: parent.width * 0.5
        anchors.left: parent.left
        Rectangle{
            anchors.fill: parent
            color: setting.backgroundColor === "Light" ? "white" : "black"

            ListView{
                id:lv
                width: parent.width * 0.9
                height: parent.height * 0.7
                model: listModel
                spacing:5
                anchors.centerIn: parent

                delegate: Rectangle{
                    id:dlg

                    property string title
                    property string description
                    title: _title
                    description: _des

                    height: 60
                    width: lv.width
                    radius: 10
                    color: setting.backgroundColor === "Light" ? "#EEEEEE" : "#757575"

                    Rectangle{
                        id:rect
                        color: "red"
                        height: parent.height
                        width: 60
                        anchors.right: parent.right
                        radius: 10

                        Text {
                            text: "DELETE"
                            font.pixelSize: 14
                            font.bold: true
                            anchors.centerIn: parent
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                database.deleteDataBase(dlg.title, dlg.description)
                                listModel.remove(index)

                            }
                        }
                    }

                    Column{
                        padding: 7

                        Text {
                            text:dlg.title
                            font.bold: true
                            font.pixelSize: 17
                        }
                        Text {
                            text: dlg.description
                            font.pixelSize: 15

                        }
                    }

                    Behavior on x {
                        NumberAnimation {
                        from: rect.width / 2
                        to: rect.width / 2 - 30
                        duration: 1000
                        easing.type: Easing.OutBounce
                        }
                    }

                    Component.onCompleted: {
                        x = 1;
                    }
                }
            }
        }
    }

    Item{
        id:rightItem
        height: parent.height
        width: parent.width * 0.5

        anchors.right: parent.right
        Rectangle{
            anchors.fill: parent
            color: setting.backgroundColor === "Light" ? "#EEEEEE" : "#757575"
            Column{
                height: parent.height * 0.7
                width: parent.width
                spacing: 40
                anchors.verticalCenter: parent.verticalCenter

                TextField{
                    id:t1
                    placeholderText: "Label"
                    width: parent.width * 0.6
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                TextField{
                    id:t2
                    placeholderText: "Description"
                    width: parent.width * 0.6
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                Button{
                    text: "Add"                   
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 100
                    enabled: t1.text.length > 0 && t2.text.length > 0
                    onClicked: {
                        listModel.append({_title: t1.text, _des: t2.text})
                        database.addList(t1.text, t2.text)
                        t1.text = ""
                        t2.text = ""
                    }
                }
            }
        }
    }
}











