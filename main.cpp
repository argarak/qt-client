#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStringList>
#include <QFile>
#include <QQuickView>
#include <QQmlContext>

// TODO create common vars in cpp instead of js

/*
 * Creates Node model to be used in Setup view, loads data
 * from node.json
 */
QStringList createNodeModel(void) {
    QStringList dataList;

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

    for(int i = 0; i < nodesArray.count(); i++)
        dataList.append(nodesArray[i].toString());

    return dataList;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("nodeModel", createNodeModel());

    QPM_INIT(engine)
            engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));

    return app.exec();
}
