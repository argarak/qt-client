#include <QApplication>
#include <QStyleHints>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStringList>
#include <QFile>
#include <QQuickView>
#include <QQmlContext>
#include <QDir>
#include <QProcess>

#include "iconsimageprovider.h"
#include "iconthemeimageprovider.h"

#include "nodecontrols.h"
#include "serial.h"

nodeControls controls;

/*
 * Checks if the config directory (and its files) exist
 */
bool checkConfigExistance() {
    if(QDir(controls.configDir).exists() &&
            QFile::exists(controls.configDir + "/nodes.json") &&
            QFile::exists(controls.configDir + "/config.json"))
        return true;
    return false;
}

/*
 * Creates blank configuration setup via mirp_cli
 */
void createBlankConfig() {
    QProcess process;
    process.start("python ../qt-client/mirp-cli/mirp_cli config create");
    process.waitForFinished(-1);
}

int main(int argc, char *argv[]) {
    if(!checkConfigExistance())
        createBlankConfig();

    Serial serial;
    serial.serialInit();

    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QApplication::styleHints()->setUseHoverEffects(true);

    QQmlApplicationEngine engine;

    if(QQuickStyle::name().isEmpty())
        QQuickStyle::setStyle("Material");

    engine.addImportPath(QStringLiteral("qrc:/"));

    qmlRegisterType<nodeControls>("NodeControls", 1, 0, "NodeControls");
    qmlRegisterType<Serial>("SerialControls", 1, 0, "SerialControls");

    engine.addImageProvider(QLatin1String("fluidicons"), new IconsImageProvider());
    engine.addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());

    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));

    return app.exec();
}
