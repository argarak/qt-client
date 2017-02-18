#include <QGuiApplication>
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

// TODO create common vars in cpp instead of js

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

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

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
