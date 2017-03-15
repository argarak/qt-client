#include "nodecontrols.h"

nodeControls::nodeControls(QObject *parent) : QObject(parent) {}

/*
 * Creates Node model to be used in Setup view, loads data
 * from node.json
 */
QVariantList nodeControls::createNodeModel(void) {
    QVariantList dataList;

    QFile loadFile(configDir + "/nodes.json");

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

bool nodeControls::remove(QString label) {
    qDebug() << "Removing " << label << "!";
    QFile saveFile(configDir + "/nodes.json");

    if (!saveFile.open(QIODevice::ReadWrite)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveFile.readAll()));
    const QJsonObject &objDoc = loadDoc.object();

    saveFile.close();

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonArray nodeArray = objDoc["nodes"].toArray();

    for(int i = 0; i < nodeArray.count(); i++) {
        if(nodeArray[i].toObject()["label"] == label) {
            nodeArray.removeAt(i);
            break;
        }
    }

    QJsonObject nodeObject;
    nodeObject["nodes"] = nodeArray;

    QJsonDocument saveDoc(nodeObject);
    saveFile.write(saveDoc.toJson());

    return true;
}

// TODO write firmware version grabber from Github API
QString nodeControls::getFirmwareVersion(QString type) {
    if(type.compare("AVR"))
        return "0.1";
    else
        return "Unknown";
}

/*
 * Returns a blank node object
 */
QJsonObject nodeControls::createBlankNodeObject(QString label, QString type) {
    QJsonObject nodeObject;
    nodeObject["label"] = label;
    nodeObject["lastOnline"] = "N/A";
    nodeObject["romLeft"] = "Unknown";

    QJsonObject firmware;
    firmware["type"] = type;
    firmware["version"] = getFirmwareVersion(type);

    nodeObject["firmware"] = firmware;

    QJsonArray modules;
    nodeObject["modules"] = modules;

    QDir().mkdir(configDir + "/" + label);

    return nodeObject;
}

/*
 * Adds a blank node objects and writes it to nodes.json
 */
bool nodeControls::addEmpty(QString label, QString type) {
    QFile saveFile(configDir + "/nodes.json");

    if (!saveFile.open(QIODevice::ReadWrite)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveFile.readAll()));
    const QJsonObject &objDoc = loadDoc.object();

    saveFile.close();

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonArray nodeArray = objDoc["nodes"].toArray();

    nodeArray.append(createBlankNodeObject(label, type));

    QJsonObject nodeObject;
    nodeObject["nodes"] = nodeArray;

    QJsonDocument saveDoc(nodeObject);
    saveFile.write(saveDoc.toJson());

    return true;
}
