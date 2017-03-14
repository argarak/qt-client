#ifndef SERIAL_H
#define SERIAL_H

#include <QObject>
#include <QDebug>
#include <QTextStream>
#include <QCoreApplication>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QJsonObject>

class Serial : public QObject
{
    Q_OBJECT

private:
    QString hashID(const char* data);

public:
    explicit Serial(QObject *parent = 0);
    Q_INVOKABLE QVariantList getConnectedDevices();
    Q_INVOKABLE void serialInit();

signals:

public slots:
};

#endif // SERIAL_H
