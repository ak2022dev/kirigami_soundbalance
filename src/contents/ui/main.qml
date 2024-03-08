// File: soundsbalance/src/contents/ui/main.qml
// Based on helloworld example from KDE documentation
// https://develop.kde.org/docs/getting-started/kirigami/introduction-getting_started/
// Accessed on 01 Feb 2024
// By Amir R Khan, started 01 Feb 2024

// Include relevant modules used by the QML
import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import org.kde.kirigami 2.20 as Kirigami
import org.kde.example 1.0

// Provide basic features needed for all kirigami apps
Kirigami.ApplicationWindow {
    // Unique identifier to reference this object
    id: root

    // Window title
    // i18nc() makes a string translatable
    // and provides additional context for the translators
    title: i18nc("@title:window", "Sounds Balance")

    globalDrawer: Kirigami.GlobalDrawer {
        // Makes drawer a small menu rather than sliding pane
        isMenu: true
        actions: [
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "gtk-quit"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        ]
    }

    ListModel {
        id: soundFileModel
        ListElement {
            filename: "Test file"
        }
    }

    Component {
        id: soundFileDelegate
        Kirigami.AbstractCard {
            contentItem: Item {
                ColumnLayout {
                    Controls.Label {
                        id: label
                        text: filename
                    }
                    Controls.Button {
                        id: openFilesButton
                        text: i18n("Open File")
                        onClicked: {
                            fileDialog.open();
                        }
                    }
                }
            }
            FileDialog {
                id: fileDialog
                title: "Please choose a file"
                onAccepted: {
                    label.text = "~" + fileDialog.fileUrl.toString().slice(13)
                }
                onRejected: {
                    console.log("Cancelled")
                    fileDialog.close()
                }
            }
        }
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18nc("@title", "Sounds Balance")

        actions.main: Kirigami.Action {
            id: addAction
            // Name of icon associated with the action
            icon.name: "list-add"
            // Action text, i18n function returns translated string
            text: i18nc("@action:button", "Add sound file")
            // What to do when triggering the action
            onTriggered: soundFileModel.append({
                filename: "Kirigami Action added card!"
            })
        }

        Kirigami.CardsListView {
            id: cardsView
            model: soundFileModel
            delegate: soundFileDelegate
        }
    }

/*
    // Set the first page that will be loaded when the app opens
    // This can also be set to an id of a Kirigami.Page
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            Controls.Label {
                text: i18n("Sounds Balance!")
            }
            RowLayout {
                Controls.Label {
                    text: i18n("Audio file 1:")
                }
                Controls.TextField {
                    id: textField1
                    text: ""
                }
                Controls.Button {
                    id: openFilesButton1
                    text: i18n("Open File 1")
                    onClicked: {
                        fileDialog1.open();
                    }
                }
            }
            RowLayout {
                Controls.Label {
                    text: i18n("Audio file 2:")
                }
                Controls.TextField {
                    id: textField2
                }
                Controls.Button {
                    id: openFilesButton2
                    text: i18n("Open File 2")
                    onClicked: {
                        fileDialog2.open();
                    }
                }
            }
            RowLayout {
                Controls.Button {
                    text: i18n("Balance Files")
                    onClicked: {
                        Backend.system("mp3gain -r " + textField1.text + " " + textField2.text)
                        Qt.quit()
                    }
                }
                Controls.Button {
                    text: i18n("Cancel opened Files")
                }
            }
            FileDialog {
                id: fileDialog1
                title: "Please choose a file"
                onAccepted: {
                    textField1.text = "~" + fileDialog1.fileUrl.toString().slice(13)
                }
                onRejected: {
                    console.log("Cancelled")
                    fileDialog1.close()
                }
            }
            FileDialog {
                id: fileDialog2
                title: "Please choose a file"
                onAccepted: {
                    textField2.text = "~" + fileDialog2.fileUrl.toString().slice(13)
                }
                onRejected: {
                    console.log("Cancelled")
                    fileDialog2.close()
                }
            }
        }
    }
*/
}
