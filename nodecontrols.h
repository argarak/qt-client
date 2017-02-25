#ifndef NODECONTROLS_H
#define NODECONTROLS_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStringList>
#include <QFile>
#include <QVariant>
#include <QDebug>
#include <QDir>

class nodeControls : public QObject {
    Q_OBJECT
public:
    explicit nodeControls(QObject *parent = 0);
    
    QString configDir = QDir::homePath() + "/.mirp";
    
    /*
     * Creates Node model to be used in Setup view, loads data
     * from node.json
     */
    Q_INVOKABLE QVariantList createNodeModel(void) {
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

    Q_INVOKABLE void remove(QString label) {
        qDebug() << "Removing " << label << "!";
    }
    
    // TODO write firmware version grabber from Github API
    QString getFirmwareVersion(QString type) {
        if(type.compare("AVR"))
            return "0.1";
        else
            return "Unknown";
    }

    /*
     * Returns a blank node object
     */
    QJsonObject createBlankNodeObject(QString label, QString type) {
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

        return nodeObject;
    }

    /*
     * Adds a blank node objects and writes it to nodes.json
     */
    Q_INVOKABLE bool addEmpty(QString label, QString type) {
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
    
signals:
    
public slots:
};

#endif // NODECONTROLS_H
