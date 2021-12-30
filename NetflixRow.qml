import QtQuick

Column {
    spacing: 10
    width: parent.width - 50
    anchors.horizontalCenter: parent.horizontalCenter
    property alias model: row.model
    property string title: "test"
    Text {
        color: "#fff"
        text: parent.title
        font.family: robotoFont.font.family
        font.pixelSize: 20
    }

    ListView {
        id: row
        width: parent.width
        spacing: 15
        height: 225
        z: 1
        model: ListModel {}
        orientation: ListView.Horizontal
        delegate: Item {
            width: 150
            height: 225
            Image {
                id: image_container
                z: 1
                source: poster_path
                width: 150
                height: 225
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onExited: parent.state = "idle"
                    onEntered: parent.state = "hover"
                    onClicked: {
                        mainWindow.setSelectedMovie(row.model.get(index))
                    }
                }
                state: "idle"
                states: [
                    State {
                        name: "idle"
                        PropertyChanges {
                            target: image_container
                            scale: 1.0
                        }
                        PropertyChanges {
                            target: row
                        }
                    },
                    State {
                        name: "hover"
                        PropertyChanges {
                            target: image_container
                            scale: 1.1
                            z: 100
                        }
                        PropertyChanges {
                            target: row
                            z: 100
                        }
                    }
                ]
                transitions: Transition {
                    NumberAnimation {
                        properties: "scale"
                        easing.type: Easing.InOutQuad
                        duration: 100
                    }
                }
            }
        }
    }
}
