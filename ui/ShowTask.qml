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
            model: database
            spacing:5

            delegate: Rectangle {
                id:dlg

                height: descriptionText.height + titleText.height + 20
                width: lv.width
                radius: 10
                color: setting.backgroundColor === "light" ? "#EEEEEE" : "#757575"

                ColumnLayout {
                    anchors.right: parent.right
                    width: 30
                    height: parent.height

                    Image {
                        id: editButton
                        source: "qrc:/images/edit.png"
                        sourceSize.width: parent.width - 10

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                editPage.titleText = model.title
                                editPage.descriptionText = model.description
                                editPage.timeText = model.time
                                editPage.open()
                            }
                        }
                    }

                    Image {
                        source: "qrc:/images/delete.png"
                        sourceSize.width: parent.width - 10

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                anim.start()
                                titleText.text = ""
                                descriptionText.text = ""
                                timeLabel.text = ""
                                timeRectangle.color = "transparent"
                            }
                        }
                    }

                    PropertyAnimation {
                        id: anim
                        target: dlg
                        duration: 300
                        property: "width"
                        to: 0
                        onStopped: database.deleteDatabase(model.title, model.description)

                    }
                }

                Column {
                    padding: 7

                    RowLayout{
                        spacing: 10
                        anchors.right: isPersian(dlg.title) ? parent.right : undefined
                        anchors.rightMargin: 7

                        Text {
                            id: titleText
                            text: model.title
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
                                text: model.time
                                font.bold: true
                                font.pixelSize: setting.fontSize - 2

                                anchors.centerIn: parent
                                font.family: Font.Medium
                            }
                        }
                    }

                    Text {
                        id: descriptionText
                        text: model.description
                        font.pixelSize: setting.fontSize - 2
                        wrapMode: Text.Wrap
                        width: dlg.width - (editButton.width + 20)
                        font.family: Font.Medium
                    }
                }
            }
        }
    }

    Rectangle {
        id: deleteAll
        width: 100
        height: 50

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
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

    function isPersian(text) {
        var persianCharacters = /[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF]/;
        return persianCharacters.test(text);
    }

}
