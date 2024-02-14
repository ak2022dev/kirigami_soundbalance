#pragma once

#include <QtGlobal>
#include <QObject>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)

private:
    QString m_fileName = "Hello World!";

public:
    Q_INVOKABLE void system(QString &command);
    QString fileName() const;
    void setFileName(const QString &fileName);
    Q_SIGNAL void fileNameChanged();
    explicit Backend(QObject *parent = nullptr);
};
