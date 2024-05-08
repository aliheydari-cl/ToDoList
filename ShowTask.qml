import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
    width: window.width
    height: window.height

    Edit {
        id:editPage
    }

    Pane {
        anchors.fill: parent

        ListView {
            id:lv
            width: parent.width
            height: contentHeight
            model: listModel
            spacing:5

            delegate: Rectangle {
                id:dlg
                property string title
                property string description
                property string time
                title: _title
                description: _des
                time: _time

                height: descriptionText.height + titleText.height + 20
                width: lv.width
                radius: 10
                color: setting.backgroundColor === "light" ? "#EEEEEE" : "#757575"

                Rectangle {
                    id:rect
                    color: "red"
                    width: 60
                    height: parent.height * 0.85
                    radius: 10

                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right

                    Text {
                        text: "DELETE"
                        font.pixelSize: 14
                        font.bold: true
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            database.deleteDataBase(dlg.title, dlg.description)
                            anim.start()
                            title = ""
                            description = ""
                            time = ""
                            timeBackground.color = "transparent"
                        }
                    }

                    PropertyAnimation {
                        id: anim
                        target: dlg
                        duration: 1000
                        property: "width"
                        to: 0
                        onStopped: listModel.remove(index)
                    }
                }

                Rectangle {
                    id: editButton
                    color: "#4CAF50"
                    width: 60
                    height: parent.height * 0.85
                    radius: 10

                    anchors.right: rect.left
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        text: qsTr("Edit")
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            editPage.titleText = dlg.title
                            editPage.descriptionText = dlg.description
                            editPage.timeText = dlg.time

                            editPage.open()
                        }
                    }
                }

                Column {
                    padding: 7

                    RowLayout{
                        spacing: 10

                        Text {
                            id: titleText
                            text:dlg.title
                            font.bold: true
                            font.pixelSize: setting.fontSize
                        }

                        Label {
                            id:timeLabel
                            text:dlg.time
                            font.bold: true
                            font.pixelSize: setting.fontSize - 2

                            background: Rectangle{
                                id:timeBackground
                                color: "#8BC34A"
                                width: parent.width
                            }
                        }
                    }

                    Text {
                        id: descriptionText
                        text: dlg.description
                        font.pixelSize: setting.fontSize
                        wrapMode: Text.Wrap
                        width: dlg.width - (editButton.width + rect.width + 25)
                    }
                }
            }
        }

        Rectangle {
            visible: listModel.count > 0 ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lv.bottom
            anchors.topMargin: 20
            width: 100
            height: 50
            color: setting.backgroundColor === "light" ? "#EEEEEE" : "#757575"

            radius: 20

            Text {
                text: qsTr("Delete all")
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    database.deleteAll()

                    listModel.clear();
                }
            }
        }
    }
}
