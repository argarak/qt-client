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
#include "iconsimageprovider.h"
#include "iconthemeimageprovider.h"
#include <QDir>
#include <QProcess>

// TODO create common vars in cpp instead of js

// TODO Add this variable to common vars
QString configDir = QDir::homePath() + "/.mirp";

/*
 * Checks if the config directory (and its files) exist
 */
bool checkConfigExistance() {
    // Again, re-write this with global vars!
    if(QDir(configDir).exists() &&
       QFile::exists(configDir + "/nodes.json") &&
       QFile::exists(configDir + "/config.json"))
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

/*
 * Creates Node model to be used in Setup view, loads data
 * from node.json
 */
QVariantList createNodeModel(void) {
    QVariantList dataList;

    QFile loadFile(":/data/nodes.json");

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open node data file.");
        return dataList;
    }

    QByteArray nodeData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(nodeData));

    const QJsonObject &objDoc = loadDoc.object();

    QJsonDocument doc(objDoc);
    QString strJson(doc.toJson(QJsonDocument::Compact));

    QJsonArray nodesArray = objDoc["nodes"].toArray();

    for(int i = 0; i < nodesArray.count(); i++) {
        dataList.append(nodesArray[i].toVariant());
    }

    return dataList;
}

int main(int argc, char *argv[]) {
    if(!checkConfigExistance())
        createBlankConfig();

    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QApplication::styleHints()->setUseHoverEffects(true);

    QQmlApplicationEngine engine;

    if(QQuickStyle::name().isEmpty())
        QQuickStyle::setStyle("Material");

    engine.addImportPath(QStringLiteral("qrc:/"));

    engine.addImageProvider(QLatin1String("fluidicons"), new IconsImageProvider());
    engine.addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());

    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("nodeModel", createNodeModel());

    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));

    return app.exec();
}
