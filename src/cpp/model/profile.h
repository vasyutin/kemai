#pragma once

// STL headers
#include <vector>

// Qt headers
#include <QAbstractListModel>

// Project headers
#include <data/profile.h>

namespace kemai {

class ProfileModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum class ProfileRole
    {
        Name = Qt::UserRole + 1,
        Host,
        Token
    };

    explicit ProfileModel(QObject* parent = nullptr);
    ~ProfileModel() override;

    void setProfiles(const std::vector<Profile>& profiles);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    std::vector<Profile> m_profiles;
};

} // namespace kemai
