#include "serial.h"

Serial::Serial(QObject *parent) : QObject(parent) {}

#define CRC16 0x8005

QString Serial::hashID(const char* data) {
    uint16_t out = 0;
    int bits_read = 0,
            bit_flag,
            size = strlen(data);

    if(data == NULL)
        return 0;

    while(size > 0) {
        bit_flag = out >> 15;

        out <<= 1;
        out |= (*data >> (7 - bits_read)) & 1;

        bits_read++;
        if(bits_read > 7) {
            bits_read = 0;
            data++;
            size--;
        }

        if(bit_flag)
            out ^= CRC16;
    }
    return QString(QByteArray::number(out, 16));
}

QVariantList Serial::getConnectedDevices() {
    const auto allSerial = QSerialPortInfo::availablePorts();
    QVariantList list;

    for(const QSerialPortInfo &serialInfo : allSerial) {
        QJsonObject currentSerial;

        // Ignore if no serial number
        if(!serialInfo.serialNumber().isEmpty()) {
            currentSerial["port"] = serialInfo.portName();

            if(serialInfo.hasProductIdentifier())
                currentSerial["id"] = serialInfo.productIdentifier();
            else
                currentSerial["id"] = -1;

            currentSerial["number"] = serialInfo.serialNumber();
            currentSerial["busy"] = serialInfo.isBusy();
            currentSerial["deviceName"] = serialInfo.description();
            
            //list.append(currentSerial);
            list.append(currentSerial.toVariantMap());
        }
    }

    qDebug() << list;
    return list;
}

void Serial::serialInit() {
    qDebug() << Serial::getConnectedDevices();
    //Serial::serialDevices = Serial::getConnectedDevices();
}
