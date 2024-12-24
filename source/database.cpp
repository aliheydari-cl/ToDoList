#include "database.h"
#include <QtCore>
#include <QtSql>

DataBase::DataBase(QObject *parent)
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

    getDatabase();
}

DataBase::~DataBase()
{
    db.close();
}

void DataBase::addList(QString title, QString des, QString time)
{
    QSqlQuery q;
    q.prepare("INSERT INTO list (title, description, time) VALUES (:t, :d, :time)");
    q.bindValue(":t", title);
    q.bindValue(":d", des);
    q.bindValue(":time", time);

    q.exec();

    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({title, des, time});
    endInsertRows();
}

void DataBase::getDatabase()
{
    QStringList temp;
    QSqlQuery q;
    q.exec("SELECT title, description, time FROM list");

    m_items.clear();

    while(q.next())
    {
        QString t = q.value(0).toString();
        QString d = q.value(1).toString();
        QString time = q.value(2).toString();

        m_items.append({t, d, time});
    }
}

void DataBase::deleteDatabase(QString title, QString description)
{
    QSqlQuery q;
    q.prepare("DELETE FROM list WHERE description = :description AND title = :title");
    q.bindValue(":description", description);
    q.bindValue(":title", title);
    q.exec();

    for (int i = 0; i < m_items.size(); ++i) {
        if (m_items[i].title == title && m_items[i].description == description) {
            beginRemoveRows(QModelIndex(), i, i);
            m_items.removeAt(i);
            endRemoveRows();
            break;
        }
    }
}

void DataBase::deleteAll()
{
    QSqlQuery q;
    q.prepare("DELETE FROM list");
    q.exec();

    beginRemoveRows(QModelIndex(), 0, m_items.size() - 1);
    m_items.clear();
    endRemoveRows();
}

void DataBase::editDatabase(const QString &newTitle, const QString &newTime, const QString &newDescription, QString description, QString title)
{
    QSqlQuery q;
    q.prepare("UPDATE list SET title = :newTitle, description = :newDescription, time = :newTime WHERE title = :title AND description = :description");
    q.bindValue(":newTitle", newTitle);
    q.bindValue(":newDescription", newDescription);
    q.bindValue(":newTime", newTime);
    q.bindValue(":description", description);
    q.bindValue(":title", title);

    q.exec();

    beginResetModel();
    m_items.clear();

    QSqlQuery fetchQuery;
    fetchQuery.exec("SELECT title, description, time FROM list");

    while (fetchQuery.next()) {
        m_items.append({
            fetchQuery.value(0).toString(),
            fetchQuery.value(1).toString(),
            fetchQuery.value(2).toString()
        });
    }
    endResetModel();
}

int DataBase::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_items.size();
}

QVariant DataBase::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const auto &item = m_items[index.row()];

    switch (role)
    {
        case title: return item.title;
        case description: return item.description;
        case time: return item.time;
        default: return QVariant();
    }
}

QHash<int, QByteArray> DataBase::roleNames() const
{
    return {
        {title, "title"},
        {description, "description"},
        {time, "time"},
    };
}

