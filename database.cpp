#include "database.h"
#include <QtSql>

dataBase::dataBase(QObject *parent)
    : QObject{parent}
{
    QString fileName;

    #if defined(Q_OS_ANDROID)
        fileName = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/ToDoList.db";
    #else
        fileName = QCoreApplication::applicationDirPath() + "/ToDoList.db";
    #endif

    db.setDatabaseName(fileName);
    db.open();
    QSqlQuery q;
    q.exec("CREATE TABLE list (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, time TEXT)");
}

dataBase::~dataBase()
{
    db.close();
}

void dataBase::addList(QString title, QString des, QString time)
{
    QSqlQuery q;
    q.prepare("INSERT INTO list (title, description, time) VALUES (:t, :d, :time)");
    q.bindValue(":t", title);
    q.bindValue(":d", des);
    q.bindValue(":time", time);

    q.exec();
}

void dataBase::getDataBase()
{
    QStringList temp;
    QSqlQuery q;
    q.exec("SELECT title, description, time FROM list");
    while(q.next())
    {
        QString t = q.value(0).toString();
        QString d = q.value(1).toString();
        QString time = q.value(2).toString();

        temp.append(t);
        temp.append(d);
        temp.append(time);

    }
    if(cppList != temp)
        setList(temp);

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

void dataBase::deleteDataBase(QString title, QString description)
{
    QSqlQuery q;
    q.prepare("DELETE FROM list WHERE description = :description AND title = :title");
    q.bindValue(":description", description);
    q.bindValue(":title", title);

    q.exec();
}

void dataBase::deleteAll()
{
    QSqlQuery q;
    q.prepare("DELETE FROM list");

    q.exec();
}

void dataBase::editDataBase(const QString &newTitle, const QString &newTime, const QString &newDescription, QString description, QString title)
{
    QSqlQuery q;
    q.prepare("UPDATE list SET title = :newTitle, description = :newDescription, time = :newTime WHERE title = :title AND description = :description");
    q.bindValue(":newTitle", newTitle);
    q.bindValue(":newDescription", newDescription);
    q.bindValue(":newTime", newTime);
    q.bindValue(":description", description);
    q.bindValue(":title", title);

    q.exec();
}

