#ifndef COMMAND_INTERFACE_H
#define COMMAND_INTERFACE_H

#include <QObject>
#include <QDir>
#include <QProcess>
#include <QDebug>

class CommandInterface : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool commandDone READ isCommandDone NOTIFY commandDoneChanged)
public:
    explicit CommandInterface(QObject *parent = 0);

    const QString configDir = QDir::homePath() + "/.mirp";

    QProcess process;

    bool isCommandDone();
    Q_INVOKABLE QString checkCLIExistance();
    Q_INVOKABLE int sendCommand(QString command, QString parameters[]);

signals:
    void commandDoneChanged();
};

#endif // COMMAND_INTERFACE_H
