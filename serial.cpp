#include "serial.h"

Serial::Serial(QObject *parent) : QObject(parent) {

}

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

void Serial::serialInit() {
    qDebug() << hashID("95437313335351409201");
}
