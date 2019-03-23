#include "widget.h"
#include <dialoglist.h>
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    DialogList w;
    w.show();

    return a.exec();
}
