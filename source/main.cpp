#include "database.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Ali Heydari");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/ui/Main.qml"));
    DataBase dataBase;
    engine.rootContext()->setContextProperty("database", &dataBase);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
