#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <database.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Ali Heidary");

    qmlRegisterType<dataBase>("DataBase", 1, 0, "DataBase");

    QQmlApplicationEngine engine;

    const QUrl url(u"qrc:/ToDoList/Main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
