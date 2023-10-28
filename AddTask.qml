import QtQuick
import QtQuick.Controls.Material

Page{
    id:addTask
    width: window.width
    height: window.height

    Clock{
        id:clock
    }

    Pane{
        anchors.fill: parent
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
                id:clockInput
                placeholderText: "Time"
                width: parent.width * 0.6
                anchors.horizontalCenter: parent.horizontalCenter

                ToolButton{
                    anchors.right: clockInput.right
                    icon.source: "images/clock-icon"
                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: {
                        clock.open()
                    }
                }
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
                    listModel.append({_title: t1.text, _des: t2.text, _time: clockInput.text})
                    database.addList(t1.text, t2.text, clockInput.text)
                    t1.text = ""
                    t2.text = ""
                    clockInput.text = ""
                    stackView.pop()
                }
            }
        }
    }
}
