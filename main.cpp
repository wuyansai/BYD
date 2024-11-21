#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Interface/interface.h"
#include <QIcon>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    app.setWindowIcon(QIcon(":/Images/Home/vehicle.png")); //设置应用图标
    engine.rootContext()->setContextProperty("ui", INTERFACE);
    engine.loadFromModule("BYD", "Main");

    return app.exec();
}
