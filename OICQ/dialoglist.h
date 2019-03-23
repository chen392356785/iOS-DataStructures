#ifndef DIALOGLIST_H
#define DIALOGLIST_H
#include <QToolButton>

#include <QWidget>

namespace Ui {
class DialogList;
}

class DialogList : public QWidget
{
    Q_OBJECT

public:
    explicit DialogList(QWidget *parent = nullptr);
    ~DialogList();
    QMap<QToolButton *,bool> *m_isShowMap;
    //点击某一个用户的列表
    void didSelectList(QToolButton *btn);
private:
    Ui::DialogList *ui;

};

#endif // DIALOGLIST_H
