#include "widget.h"
#include <QDebug>
#include <QDateTime>
#include <QMessageBox>
#include <QDataStream>
#include "ui_widget.h"

Widget::Widget(QWidget *parent,QString name) :
    QWidget(parent),
    ui(new Ui::Widget)
{
    ui->setupUi(this);
    //初始化UDPSocket
    udpSocket = new QUdpSocket(this);
    //用户名获取
    this->userName = name;
    this->port = 9999;
    //绑定端口号 绑定模式
    this->udpSocket->bind(this->port,QUdpSocket::ShareAddress |QUdpSocket::ReuseAddressHint);

    //发送新用户进入
    sndMsg(UsrEnter);
    //点击发送按钮
    connect(ui->sendBtn,&QPushButton::clicked,[=](){
        this->sndMsg(Msg);
    });
    //接收到socket消息信号
    connect(udpSocket,&QUdpSocket::readyRead,this,&Widget::ReceiveMessage);

}

//发送消息
void Widget::sndMsg(MsgType type) {
    //发送的消息分为3种类型
    //发送的数据做分段处理 第一段类型 第二段 Neri
    QByteArray array;
    QDataStream stream(&array,QIODevice::WriteOnly);
    //第一段内容添加到流中
    stream << type;
    //第二段添加用户名信息
    stream << getUsr();
    switch (type) {
    case Msg: //普通消息发送
        //如果用户没有输入内容 不发任何消息
        if (ui->msgTextEdit->toPlainText() == "") {
            QMessageBox::warning(this,"警告","发送内容不能为空");
            return;
        }
        stream <<getMsg();
        //清空输入框 光标重新聚焦
        ui->msgTextEdit->clear();
        ui->msgTextEdit->setFocus();

        break;
    case UsrEnter: //用户进入
          stream << QString("在线!");
        break;
    case UsrLeft: //用户离开
        stream << QString("离开了!");
        break;
    }

    //书写报文 广播发送
    udpSocket->writeDatagram(array,array.length(),QHostAddress::Broadcast,port);

}

//ReceiveMessage 接收消息
void Widget::ReceiveMessage() {
    qDebug() << "***********";
    qint64 size = udpSocket->pendingDatagramSize();
    QByteArray array = QByteArray(size,0);
    udpSocket->readDatagram(array.data(),size);
    //对array解析数据
    //第一段类型 第二段用户名 第三段内容
    QDataStream stream(&array,QIODevice::ReadOnly);
    //读取到消息类型
    int type;
    stream >> type;
    //读取到用户名
    QString name,msg;
    stream >> name;
    //读取到消息内容
    stream >> msg;
    //获取当前时间
    QString time = QDateTime::currentDateTime().toString("yyyy-mm-dd hh-mm:ss");
    switch (type) {
    case Msg:
        //追加聊天记录
        ui->msgBrowser->setTextColor(Qt::blue);
        ui->msgBrowser->append("[" + name + "]" + time);
        ui->msgBrowser->append(msg);
        break;
    case UsrEnter: //用户进入
        ui->msgBrowser->setTextColor(Qt::lightGray);
        ui->msgBrowser->append(name + msg);
        break;
    case UsrLeft: //用户离开
        ui->msgBrowser->setTextColor(Qt::red);
        ui->msgBrowser->append(name + msg);
        break;
    }
}

//获取聊天信息
QString Widget::getMsg() {
    QString str = ui->msgTextEdit->toHtml();
    return str;
}
//获取用户名
QString Widget::getUsr() {
    return this->userName;
}

//窗口关闭事件
void Widget::closeEvent(QCloseEvent *ev) {
    sndMsg(UsrLeft);
    emit this->colseWidget();
}

Widget::~Widget()
{
    delete ui;
}
