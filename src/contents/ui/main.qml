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

    // Set the first page that will be loaded when the app opens
    // This can also be set to an id of a Kirigami.Page
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            Controls.Label {
                text: i18n("Sounds Balance!")
            }
            Controls.Label {
                text: i18n("Audio file 1:")
            }
            Controls.TextField {
                id: textField1
            }
            Controls.Button {
                id: openFilesButton1
                text: i18n("Open Files")
                onClicked: {
                    fileDialog1.open();
                }
            }
            Controls.Label {
                text: i18n("Audio file 2:")
            }
            Controls.TextField {
                id: textField2
            }
            Controls.Button {
                id: openFilesButton2
                text: i18n("Open Files")
                onClicked: {
                    fileDialog2.open();
                }
            }
            FileDialog {
                id: fileDialog1
                title: "Please choose a file"
                onAccepted: {
//                    var result = fileDialog.fileUrl
//                    console.log("File chosen: " + result )
//                    Backend.fileName = result.toString()
//                    Backend.system("mp3gain -r Free_Test_Data_100KB_MP3.mp3 output.mp3")
//                    console.log("Backend.fileName is: " + Backend.fileName )
                    Qt.quit()
                }
                onRejected: {
                    console.log("Cancelled")
                    Qt.quit()
                }
            }
            FileDialog {
                id: fileDialog2
                title: "Please choose a file"
                onAccepted: {
//                    var result = fileDialog.fileUrl
//                    console.log("File chosen: " + result )
//                    Backend.fileName = result.toString()
//                    Backend.system("mp3gain -r Free_Test_Data_100KB_MP3.mp3 output.mp3")
//                    console.log("Backend.fileName is: " + Backend.fileName )
                    Qt.quit()
                }
                onRejected: {
                    console.log("Cancelled")
                    Qt.quit()
                }
            }
            Controls.Button {
                text: i18n("Balance Files")
            }
            Controls.Button {
                text: i18n("Cancel opened Files")
            }
        }
    }
}
