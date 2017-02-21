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

class nodeControls : public QObject {
    Q_OBJECT
public:
    explicit nodeControls(QObject *parent = 0);

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

    Q_INVOKABLE void remove(QString label) {
        qDebug() << "Removing " << label << "!\n";
    }
signals:

public slots:
};

#endif // NODECONTROLS_H
