#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject(parent)
{

}

QString Backend::fileName() const
{
    return m_fileName;
}

void Backend::setFileName(const QString &fileName)
{
    m_fileName = fileName;
    Q_EMIT fileNameChanged();
}

