#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QMap>

class DataBase : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit DataBase(QObject *parent = nullptr);
    ~DataBase();

    enum modeldRoles {
        title = Qt::UserRole + 1,
        description,
        time
    };

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

signals:
    void listChanged();

public slots:
    Q_INVOKABLE void addList(QString title, QString des, QString time);
    Q_INVOKABLE void getDatabase();
    Q_INVOKABLE void deleteDatabase(QString title, QString description);
    Q_INVOKABLE void deleteAll();
    Q_INVOKABLE void editDatabase(const QString &newTitle, const QString &newDescription, const QString &newTime, QString description, QString title);

private:
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

    struct modelItem {
        QString title;
        QString description;
        QString time;
    };

    QList<modelItem> m_items;
};

#endif
