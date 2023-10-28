#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>
#include <QMap>

class dataBase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList list READ getList WRITE setList NOTIFY listChanged)
public:
    explicit dataBase(QObject *parent = nullptr);
    ~dataBase();

signals:
    void listChanged();


public slots:
    void addList(QString title, QString des, QString time);
    void getDataBase();
    QStringList getList();
    void setList(QStringList l);
    void deleteDataBase(QString t, QString d);

private:
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    dataBase *database;
    QStringList cppList;
};

#endif // DATABASE_H
