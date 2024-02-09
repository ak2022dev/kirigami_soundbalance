// File: soundsbalance/src/main.cpp
// Based on helloworld example from KDE documentation
// https://develop.kde.org/docs/getting-started/kirigami/introduction-getting_started/
// Accessed on 01 Feb 2024
// By Amir R Khan, started 01 Feb 2024

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <QQuickStyle>
#include <KLocalizedContext>
#include <KLocalizedString>
#include "backend.h"
#include <QProcess>
#include <cstdlib>

int main(int argc, char *argv[])
{
//    int value = std::system("ls");

    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("soundsbalance");
    QCoreApplication::setOrganizationName(QStringLiteral("KDE"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("kde.org"));
    QCoreApplication::setApplicationName(QStringLiteral("Sounds Balance"));

    if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE")) {
        QQuickStyle::setStyle(QStringLiteral("org.kde.desktop"));
    }

    QQmlApplicationEngine engine;
    Backend backend;
    qmlRegisterSingletonInstance<Backend>("org.kde.example", 1, 0, "Backend", &backend);
//    int value = std::system("ls");
    backend.system("ls");
    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();

}
