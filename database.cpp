#include "database.h"
#include <QtSql>

dataBase::dataBase(QObject *parent)
    : QObject{parent}
{
    QString fileName;
    fileName = QCoreApplication::applicationDirPath() + "/list.db";
    db.setDatabaseName(fileName);
    db.open();
    QSqlQuery q;
    q.exec("CREATE TABLE list (id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
}

dataBase::~dataBase()
{
    db.close();
}

void dataBase::addList(QString title,QString des)
{
    QSqlQuery q;
    q.prepare("INSERT INTO list (title, description) VALUES (:t, :d)");
    q.bindValue(":t", title);
    q.bindValue(":d", des);

    q.exec();
}

void dataBase::getDataBase()
{
    QStringList temp;
    QSqlQuery q;
    q.exec("SELECT title, description FROM list");
    while(q.next())
    {
        QString t = q.value(0).toString();
        QString d = q.value(1).toString();
        temp.append(t);
        temp.append(d);
    }
    if(cppList != temp)
    {
        cppList = temp;
        setList(temp);
    }
}

QStringList dataBase::getList()
{
    return cppList;
}

void dataBase::setList(QStringList l)
{
    if(cppList != l)
    {
        cppList = l;
        emit listChanged();
    }
}

void dataBase::deleteDataBase(QString t, QString d)
{
    QSqlQuery q;
    q.prepare("DELETE FROM list WHERE title = :t AND description = :d ");
    q.bindValue(":t", t);
    q.bindValue(":d", d);

    if(!q.exec())
        qDebug() << "Error";

}

