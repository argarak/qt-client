<img alt="qt-client logo" src="https://mirpm.github.io/icons/qt-client.svg" width="200px"/>

# qt-client

mirpm's flagship qt client for controlling, creating and monitoring nodes.

## Building

```bash
mkdir build
cd build
qmake-qt5 -o Makefile ../qt-client.pro -spec linux-g++
make
```

To execute, run `./qt-client`.

## Dependencies

Qt >= 5.8

## License

This project is licensed by the Apache 2.0 License. See the file COPYING for more details.
