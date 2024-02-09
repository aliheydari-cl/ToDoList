import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page{
    width: window.width
    height: window.height

    Pane{
        anchors.fill: parent

        ListView{
            id:lv
            width: parent.width
            height: contentHeight
            model: listModel
            spacing:5

            delegate: Rectangle{
                id:dlg

                property string title
                property string description
                property string time
                title: _title
                description: _des
                time: _time

                height: descriptionText.implicitHeight + 30
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
                            anim.start()
                            title = ""
                            description = ""
                            time = ""
                            timeBackground.color = "transparent"
                        }
                    }

                    PropertyAnimation{
                        id: anim
                        target: dlg
                        duration: 1000
                        property: "width"
                        to: 0
                        onStopped: listModel.remove(index)
                    }
                }

                Column{
                    padding: 7

                    RowLayout{
                        spacing: 10

                        Text {
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
                    }
                }
            }
        }
    }
}
