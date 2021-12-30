import QtQuick
import QtQuick.Controls

// https://netflix-uiclone.vercel.app/
Window {
    width: 1425
    height: 1000
    visible: true
    title: qsTr("NetFlix")
    id: mainWindow
    FontLoader {
        id: robotoFont
        source: "https://github.com/FontFaceKit/roboto/raw/gh-pages/fonts/Regular/Roboto-Regular.ttf"
    }

    function getUrl(url, model) {
        var req = new XMLHttpRequest()
        req.open("GET", url)
        req.onreadystatechange = function () {

            if (req.readyState === XMLHttpRequest.DONE) {

                const movies = JSON.parse(req.responseText)
                movies.results.forEach(function (element) {
                    if (element.hasOwnProperty("title")) {
                        const date = ["2018", "2019", "2020", "2021"]
                        model.append({
                                         "title": element.title,
                                         "vote_average": element.vote_average,
                                         "overview": element.overview,
                                         "backdrop_path": "https://image.tmdb.org/t/p/original"
                                                          + element.backdrop_path,
                                         "poster_path": "https://image.tmdb.org/t/p/w300"
                                                        + element.poster_path,
                                         "origin_country": element.original_language,
                                         "first_air_date": date[Math.floor(
                                                 Math.random() * 4)]
                                     })
                    }
                    if (titleNetflix.text === "") {
                        setSelectedMovie(model.get(0))
                    }
                })
            }
        }
        req.onerror = function () {
            // what you want to be done when request failed
            console.log("error")
        }

        req.send()
    }

    function setSelectedMovie(model) {
        titleNetflix.text = model.title
        overviewNetflix.text = model.overview
        pointNetflix.vote = model.vote_average
        posterNetflix.source = model.backdrop_path
        originCountryNetflix.text = model.origin_country.toUpperCase()
        dateNetflix.text = model.first_air_date
    }

    SwipeView {
        id: swipe
        anchors.fill: parent
        Rectangle {
            color: "#000"
            AnimatedImage {
                anchors.centerIn: parent
                source: "qrc:/netflix/netflix_loading.gif"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: swipe.incrementCurrentIndex()
            }
        }
        Item {
            Rectangle {
                anchors.fill: parent
                color: "#141414"
                Component.onCompleted: {
                    getUrl("https://api.themoviedb.org/3/discover/movie?with_genres=27&api_key=a820cce61d47c9e1b9fd4180fc87626f",
                           discoverRepeater.model)

                    getUrl("https://api.themoviedb.org/3/trending/all/week?api_key=a820cce61d47c9e1b9fd4180fc87626f",
                           suggestRepeater.model)

                    getUrl("https://api.themoviedb.org/3/movie/top_rated?api_key=a820cce61d47c9e1b9fd4180fc87626f",
                           topRatedRepeater.model)

                    getUrl("https://api.themoviedb.org/3/discover/movie?with_genres=28&api_key=a820cce61d47c9e1b9fd4180fc87626f",
                           actionRepeater.model)

                    getUrl("https://api.themoviedb.org/3/discover/movie?with_genres=35&api_key=a820cce61d47c9e1b9fd4180fc87626f",
                           comedyRepeater.model)

                    getUrl("https://api.themoviedb.org/3/discover/movie?with_genres=27&api_key=a820cce61d47c9e1b9fd4180fc87626f",
                           horrorRepeater.model)

                    getUrl("https://api.themoviedb.org/3/discover/movie?with_genres=28&api_key=a820cce61d47c9e1b9fd4180fc87626f",
                           romanceRepeater.model)
                }

                ScrollView {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                    ScrollBar.horizontal.interactive: false
                    contentWidth: colContainer.width
                    contentHeight: colContainer.height
                    clip: true

                    Flickable {
                        id: flickable
                        flickableDirection: Flickable.VerticalFlick
                        boundsBehavior: Flickable.StopAtBounds
                        flickDeceleration: 10000
                        Column {
                            id: colContainer
                            width: mainWindow.width

                            spacing: 20
                            Item {
                                width: mainWindow.width
                                height: mainWindow.height * 0.65

                                Image {
                                    id: posterNetflix
                                    height: mainWindow.height

                                    anchors.right: parent.right
                                    fillMode: Image.PreserveAspectFit
                                }
                                Rectangle {
                                    height: mainWindow.height
                                    width: mainWindow.width
                                    gradient: Gradient {
                                        orientation: Gradient.Horizontal
                                        GradientStop {
                                            position: 0.0
                                            color: "#111"
                                        }
                                        GradientStop {
                                            position: 0.2
                                            color: "#111"
                                        }
                                        GradientStop {
                                            position: 1.0
                                            color: "transparent"
                                        }
                                    }
                                }

                                Rectangle {
                                    height: mainWindow.height
                                    width: mainWindow.width
                                    gradient: Gradient {
                                        orientation: Gradient.Vertical
                                        GradientStop {
                                            position: 0.0
                                            color: "transparent"
                                        }
                                        GradientStop {
                                            position: 0.8
                                            color: "#111"
                                        }
                                        GradientStop {
                                            position: 1.0
                                            color: "#111"
                                        }
                                    }
                                }

                                Column {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.topMargin: 300
                                    anchors.leftMargin: 25
                                    spacing: 15
                                    Text {
                                        id: titleNetflix
                                        color: "#fff"
                                        font.family: robotoFont.font.family
                                        font.pixelSize: 60
                                        font.bold: true
                                    }
                                    Row {
                                        spacing: 10
                                        Text {
                                            id: pointNetflix
                                            property real vote: 0.0
                                            color: "#46d369"
                                            text: pointNetflix.vote.toFixed(
                                                      2) + " points"
                                            font.family: robotoFont.font.family
                                            font.pixelSize: 18
                                        }
                                        Text {
                                            id: originCountryNetflix
                                            color: "#fff"
                                            text: "2021"
                                            font.family: robotoFont.font.family
                                            font.pixelSize: 18
                                            font.bold: true
                                        }
                                    }
                                    Text {
                                        id: overviewNetflix
                                        color: "#999"
                                        text: "After realizing their babies were exchanged at birth, two women develop a plan to adjust to their new lives: creating a single —and peculiar— family."
                                        font.family: robotoFont.font.family
                                        font.pixelSize: 20
                                        width: 600
                                        font.bold: true
                                        height: 145
                                        wrapMode: Label.WordWrap
                                        clip: true
                                    }
                                    Rectangle {
                                        width: 130
                                        height: 44
                                        color: "#fff"
                                        radius: 5
                                        Text {
                                            color: "#000"
                                            text: "► Watch"
                                            font.family: robotoFont.font.family
                                            anchors.centerIn: parent
                                            font.pixelSize: 20
                                            font.bold: true
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onExited: parent.color = "#fff"
                                            onEntered: parent.color = "#b7b7b7"
                                        }
                                    }
                                    Text {
                                        id: dateNetflix
                                        color: "#999"
                                        font.family: robotoFont.font.family
                                        font.pixelSize: 20
                                        width: 600
                                        font.bold: true
                                        wrapMode: Label.WordWrap
                                    }
                                }
                            }

                            NetflixRow {

                                id: discoverRepeater
                                title: "Netflix Originals"
                            }
                            NetflixRow {
                                id: suggestRepeater
                                title: "Suggestions for You"
                            }
                            NetflixRow {
                                id: topRatedRepeater
                                title: "Top Rated"
                            }
                            NetflixRow {
                                id: actionRepeater
                                title: "Action"
                            }
                            NetflixRow {
                                id: comedyRepeater
                                title: "Comedy"
                            }
                            NetflixRow {
                                id: horrorRepeater
                                title: "Horror"
                            }
                            NetflixRow {
                                id: romanceRepeater
                                title: "Romance"
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: header
                width: parent.width
                height: 70

                Image {
                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    anchors.verticalCenter: parent.verticalCenter
                    width: 92
                    height: 25
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/netflix/netflix_logo.png"
                }

                Image {
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    width: 35
                    height: 35
                    fillMode: Image.PreserveAspectFit
                    source: "data:image/jpeg;base64,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"
                }
                state: flickable.atYBeginning ? "transparent" : "opaque"
                states: [
                    State {
                        name: "transparent"
                        PropertyChanges {
                            target: header
                            color: "transparent"
                        }
                    },
                    State {
                        name: "opaque"
                        PropertyChanges {
                            target: header
                            color: "#141414"
                        }
                    }
                ]
                transitions: Transition {
                    ColorAnimation {
                        properties: "color"
                        easing.type: Easing.InOutQuad
                        duration: 400
                    }
                }
            }
        }
    }
}
