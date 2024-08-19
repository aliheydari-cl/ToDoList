import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

Page {

    width: parent.width
    height: parent.height

    Edit {
        id:editPage
    }

    Pane {
        id: pane
        anchors.fill: parent

        ListView {
            id:lv
            width: parent.width
            height: parent.height - 60
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

                ColumnLayout {
                    anchors.right: parent.right
                    width: 30
                    height: parent.height

                    Item {
                        id: editButton
                        width: 25
                        height: 25

                        IconImage {
                            source: "qrc:/images/edit.png"
                            sourceSize.width: parent.width - 5
                            color: "black"

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

                        PropertyAnimation {
                            id: anim
                            target: dlg
                            duration: 300
                            property: "width"
                            to: 0
                            onStopped: listModel.remove(index)
                        }
                    }

                    Item {
                        id: deleteButton
                        width: 25
                        height: 25

                        IconImage {
                            source: "qrc:/images/delete.png"
                            sourceSize.width: parent.width - 5
                            color: "black"

                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                database.deleteDataBase(dlg.title, dlg.description)
                                anim.start()
                                title = ""
                                description = ""
                                time = ""
                                timeRectangle.color = "transparent"

                            }
                        }
                    }
                }


                Column {
                    padding: 7

                    RowLayout{
                        spacing: 10
                        anchors.right: isPersian(dlg.title) ? parent.right : undefined

                        Text {
                            id: titleText
                            text:dlg.title
                            font.bold: true
                            font.pixelSize: setting.fontSize - 2
                            font.family: Font.Medium
                        }

                        Rectangle {
                            id: timeRectangle
                            width: timeLabel.width + 7
                            height: timeLabel.height + 7
                            color: "#8BC34A"
                            radius: 10


                            Label {
                                id:timeLabel
                                text:dlg.time
                                font.bold: true
                                font.pixelSize: setting.fontSize - 2

                                anchors.centerIn: parent
                                font.family: Font.Medium
                            }
                        }
                    }

                    Text {
                        id: descriptionText
                        text: dlg.description
                        font.pixelSize: setting.fontSize - 2
                        wrapMode: Text.Wrap
                        width: dlg.width - (editButton.width + 20)
                        font.family: Font.Medium
                    }
                }
            }
        }

        Rectangle {
            id: deleteAll
            width: 100
            height: 50

            visible: listModel.count > 0 ? true : false
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
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

        MultiEffect {
            id:effect
            anchors.fill: deleteAll
            source: deleteAll
            shadowEnabled: true
            shadowOpacity: .3
            shadowHorizontalOffset: 0
            shadowVerticalOffset: 0
            shadowBlur: 1
            blurMax: 3
            visible: deleteAll.visible
        }
    }

    function isPersian(text) {
        var persianCharacters = /[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF]/;
        return persianCharacters.test(text);
    }

}
