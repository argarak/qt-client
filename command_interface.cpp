#include "command_interface.h"

CommandInterface::CommandInterface(QObject *parent) : QObject(parent) {}

/*
 * Checks whether the python script exists and returns path to script.
 * This is not added into the main class because it does not have any
 * directory checking, and therefore is not needed outside of the
 * CommandInterface::checkCLIExistance() method.
 */
QString checkScriptExistance(QString directory) {
    if(QFile::exists(directory + "/mirp_cli/__main__.py")) {
        return directory + "/mirp_cli";
    }
    return "";
}

/*
 * Checks whether the command interface exists and returns the poth to
 * the main python script.
 */
QString CommandInterface::checkCLIExistance() {
    // Prioritise environment variable as cli directory
    QByteArray envpath = qgetenv("qtclient_cli_path");
    if(!envpath.isEmpty()) {
        if(QDir(QString::fromLatin1(envpath.data())).exists()) {
            qDebug() << "CLI path variable set and path exists!";
            return checkScriptExistance(QString::fromLatin1(envpath.data()));
        }
    }

    if(QDir(configDir + "/tools/mirp-cli").exists()) {
        return checkScriptExistance(configDir + "/tools/mirp-cli");
    }

    return "";
}

/*
 * Sends command to mirp cli with arguments.
 */
int CommandInterface::sendCommand(QString command, QString parameters[]) {
    QString pythonScript = CommandInterface::checkCLIExistance();

    if(pythonScript.isEmpty()) {
        qDebug() << "python script not detected! See <<documentation>>.";
        return -1;
    }

    QString concatParameters;

    for(int i = 0; i < parameters->count(); i++)
        concatParameters += " " + parameters[i];

    CommandInterface::process.start(pythonScript + " " + command + " " + concatParameters);

    return 0;
}

/*
 * Returns whether the command is complete.
 */
bool CommandInterface::isCommandDone() {
    return !CommandInterface::process.isOpen();
}
