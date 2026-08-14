TEMPLATE=app
QT-=gui

message(Touch mimeTeX qmake)

QMAKE_CFLAGS += -DAA
QMAKE_CXXFLAGS += -DAA

# Старый C-код mimeTeX использует объявления функций в стиле K&R/C89,
# где пустые скобки "int func();" означают "неопределённое число аргументов".
# В современном C23 (по умолчанию в GCC 14+) это означает "без аргументов",
# что вызывает тысячи ошибок "conflicting types" и "too many arguments".
# Флаг -std=gnu89 возвращает старое поведение.
QMAKE_CFLAGS += -std=gnu89

# Подавляем предупреждения, которые неизбежны в старом коде
QMAKE_CFLAGS += -Wno-implicit-function-declaration \
                -Wno-implicit-int \
                -Wno-return-type \
                -Wno-incompatible-pointer-types \
                -Wno-int-conversion \
                -Wno-old-style-definition

SOURCES=mimetex.c \
        gifsave.c

HEADERS=mimetex.h \
        texfonts.h

OBJECTS_DIR = $${_PRO_FILE_PWD_}/build/obj
DESTDIR = $${_PRO_FILE_PWD_}/build/bin

win32-msvc {
    DEFINES += _CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_WARNINGS
}
