#include <QtGlobal>
#include <cstdlib>
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

Q_INVOKABLE void Backend::system(QString &command)
{
    const char * c_string = qPrintable( command );
    std::system( c_string );
}
