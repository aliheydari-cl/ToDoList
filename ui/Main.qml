import QtCore
import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    id:window
    width: 375
    height: 800
    visible: true
    title: qsTr("ToDoList")
    font.pixelSize: setting.fontSize
    Material.theme: setting.backgroundColor === "light" ? Material.Light : Material.Dark

    Settings {
        id:setting
        property string backgroundColor
        property int fontSize
    }

    FontLoader {
        id: fontLoader
        source: "qrc:/font/B-NAZANIN.TTF"
    }

    font.family: fontLoader.name

    header:Rectangle {
        width: parent.width
        height: 40
        color: "#4CAF50"

        Text {
            text: "ToDoList"
            font.pixelSize: 18
            font.bold: true
            anchors.centerIn: parent
        }

        ToolButton {
            icon.source: "qrc:/images/menu"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            Menu {
                id: optionsMenu
                x: parent.width - width
                transformOrigin: Menu.TopRight

                Action {
                    text: qsTr("Settings")
                    onTriggered: settingDialog.open()
                    icon.source: "qrc:/images/settings"
                }
                Action {
                    text: qsTr("Help")
                    onTriggered: helpDialog.open()
                    icon.source: "qrc:/images/help"
                }
                Action {
                    text: qsTr("About")
                    onTriggered: aboutDialog.open()
                    icon.source: "qrc:/images/about"
                }
            }

            onClicked: optionsMenu.open()
        }

        Dialog {
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
                    text: qsTr("Created by Ali Heydari")
                }

                Row {
                    Image {
                        source: "qrc:/images/email"
                        width: 20
                        height: 20
                    }

                    Text {
                        text: qsTr(" aliheydari.cl@gmail.com")
                    }
                }
            }
        }

        Dialog {
            id:helpDialog
            title: "Help"
            x: Math.round((window.width - width) / 2)
            y: Math.round(window.height / 6)
            focus: true
            standardButtons: Dialog.Close
            onAccepted: aboutDialog.close()

            Column{
                Text {
                    width: 300
                    text: qsTr("This application allows you to create a list of your daily tasks and activities."
                    + "By entering the title, description, and time for each task, you can add them to your list. "
                    + "Additionally, you have the option to edit or delete individual tasks, "
                    + "as well as the option to delete all tasks at once using the 'Delete All' feature.")
                    wrapMode:Text.Wrap
                }
            }
        }

        Dialog {
            id:settingDialog
            title: "Setting"
            x: Math.round((window.width - width) / 2)
            y: Math.round(window.height / 6)
            focus: true
            standardButtons: Dialog.Close | Dialog.Ok
            onAccepted: checkBox.checked ?  setting.backgroundColor = "black" : setting.backgroundColor = "light"
            onRejected: settingDialog.close()

            ColumnLayout {
                CheckBox {
                    id:checkBox
                    text: "Dark mode"
                    checked: setting.backgroundColor === "light" ? false : true
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

    AddTask {
        id:addTask
    }

    ShowTask {
        id:showTask
    }

    StackView {
        id:stackView
        initialItem: showTask
        anchors.fill: parent
    }

    Rectangle {
        id: addButton
        width: 40
        height: 40
        radius: width / 2
        color: "#4CAF50"

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 15
        anchors.rightMargin: 15

        RoundButton {
            icon.source: stackView.depth > 1 ? "qrc:/images/back" : "qrc:/images/add.png"
            icon.width: parent.width
            icon.color: "white"

            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            id:footerButton

            onClicked: {
                stackView.depth > 1 ? stackView.pop() : stackView.push(addTask)
                anime.start()
            }
        }
    }

    SequentialAnimation {
        id: anime

        PropertyAnimation {
            target: addButton
            property: "scale"
            duration: 100
            from: 1.0
            to: 1.1
        }

        PropertyAnimation {
            target: addButton
            property: "scale"
            duration: 100
            from: 1.1
            to: 1.0
        }
    }
}

