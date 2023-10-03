import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material
import DataBase 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("ToDoList")

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
    }

    Item{
        id:leftItem
        height: parent.height
        width: parent.width * 0.5
        anchors.left: parent.left
        Rectangle{
            anchors.fill: parent
            color: "white"

            ListView{
                id:lv
                width: parent.width * 0.8
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
                    color: "#EEEEEE"

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
                        to: rect.width / 2 - 50
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
            color: "#EEEEEE"
            Column{
                height: parent.height * 0.7
                width: parent.width
                spacing: 40
                anchors.verticalCenter: parent.verticalCenter

                TextField{
                    id:t1
                    placeholderText: "inter label"
                    width: parent.width * 0.6
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                TextField{
                    id:t2
                    placeholderText: "description"
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











