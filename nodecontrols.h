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
    
    const QString configDir = QDir::homePath() + "/.mirp";

    Q_INVOKABLE QVariantList createNodeModel(void);
    Q_INVOKABLE bool remove(QString label);
    QString getFirmwareVersion(QString type);
    QJsonObject createBlankNodeObject(QString label, QString type);
    Q_INVOKABLE bool addEmpty(QString label, QString type);
};

#endif // NODECONTROLS_H
