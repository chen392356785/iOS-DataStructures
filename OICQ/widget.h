#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QUdpSocket>

namespace Ui {
class Widget;
}


class Widget : public QWidget
{
    Q_OBJECT


public:
    enum MsgType {
        Msg, //接收用户输入消息
        UsrEnter, //用户进入消息
        UsrLeft //用户离开消息
    };

    explicit Widget(QWidget *parent = nullptr,QString name = "");
    ~Widget();
    //窗口关闭事件
    void closeEvent(QCloseEvent *e);
private:
    Ui::Widget *ui;
signals:
    //关闭窗口发送关闭消息
    void colseWidget();
public:
    void sndMsg(MsgType type); //广播UDP消息
    void usrEnter(QString username);//处理新用户加入
    void usrLeft(QString usrname,QString time); //处理用户离开
    QString getUsr(); //获取用户名
    QString getMsg(); //获取聊天信息
private:
    QUdpSocket * udpSocket; //udp套接字
    quint16 port; //端口
    QString userName; //用户名
    void ReceiveMessage();   //接受UDP消息

};

#endif // WIDGET_H
