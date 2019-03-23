#include "dialoglist.h"
#include <QToolButton>
#include "widget.h"
#include <QDebug>
#include <QMessageBox>
#include <QCloseEvent>
#include "ui_dialoglist.h"

void DialogList::didSelectList(QToolButton *btn) {

    bool select = this->m_isShowMap->find(btn).value();
    if (select) {
        QString str = QString("%1 的窗口已经被打开了").arg(btn->text());
        QMessageBox::warning(this,"警告",str);
    } else {
        (*m_isShowMap)[btn] = true;
        Widget *widget = new Widget(nullptr,btn->text());
        //设置窗口标题
        widget->setWindowTitle(btn->text());
        widget->setWindowIcon(btn->icon());
        widget->show();
        connect(widget,&Widget::colseWidget,[=]() mutable {
             (*m_isShowMap)[btn] = false;
        });
    }

}

DialogList::DialogList(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::DialogList)
{
    ui->setupUi(this);
    //设置标题
    setWindowTitle("我的QQ 2019");
    //设置icon
    setWindowIcon(QPixmap(":/images/qq.png"));

    //准备图标和图片资源
    QList<QString>nameList;
    nameList << "水票奇缘" << "忆梦如澜" <<"北京出版人"<<"Cherry"<<"淡然"
             <<"娇娇girl"<<"落水无痕"<<"青墨暖暖"<<"无语";

    QStringList iconNameList; //图标资源列表
    iconNameList << "spqy"<< "ymrl" <<"qq" <<"Cherry"<< "dr"
                 <<"jj"<<"lswh"<<"qmnn"<<"wy";

    QVector<QToolButton *> vToolButtons;
    //默认窗口都是未打开状态
    this->m_isShowMap = new QMap<QToolButton *,bool>();
    for (int i = 0;i<nameList.size();i++) {
        //设置头像
        QToolButton *btn = new QToolButton();
        btn->setText(nameList.at(i));
        QString imgNmae = QString(":/images/%1.png").arg(iconNameList.at(i));
        QPixmap pix = QPixmap(imgNmae);
        btn->setIcon(pix);
        //设置图片尺寸
        btn->setIconSize(pix.size());
        btn ->setAutoRaise(true);
        //设置文字和图片显示方式
        btn->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);
        ui->vlayout->addWidget(btn);
        vToolButtons.push_back(btn);
        (*m_isShowMap)[btn] = false;
    }

    //对9个按钮添加信号槽连接
    for (QVector<QToolButton *>::iterator it = vToolButtons.begin();it != vToolButtons.end();it++) {
        QToolButton *btn = *it;
        connect(btn,&QToolButton::clicked,[=]() mutable {
            this->didSelectList(btn);
        });
    }

    setFixedSize(250,700);
}

DialogList::~DialogList()
{
    delete ui;
}
