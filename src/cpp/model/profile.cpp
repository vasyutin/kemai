#include "profile.h"

// magic_enum headers
#include <magic_enum/magic_enum.hpp>

namespace kemai {

ProfileModel::ProfileModel(QObject* parent) : QAbstractListModel(parent) {}

ProfileModel::~ProfileModel() = default;

void ProfileModel::setProfiles(const std::vector<Profile>& profiles)
{
    beginResetModel();
    m_profiles = profiles;
    endResetModel();
}

int ProfileModel::rowCount(const QModelIndex& parent) const
{
    return static_cast<int>(m_profiles.size());
}

QVariant ProfileModel::data(const QModelIndex& index, int role) const
{
    if (!index.isValid() || index.row() > m_profiles.size())
    {
        return {};
    }

    const auto& profile = m_profiles[index.row()];
    switch (static_cast<ProfileRole>(role))
    {
    case ProfileRole::Name:
        return QString::fromStdString(profile.name);
    case ProfileRole::Host:
        return QString::fromStdString(profile.host);
    case ProfileRole::Token:
        return QString::fromStdString(profile.token);
    default:
        return {};
    }
}

QHash<int, QByteArray> ProfileModel::roleNames() const
{
    return {{magic_enum::enum_integer(ProfileRole::Name), "name"},
            {magic_enum::enum_integer(ProfileRole::Host), "host"},
            {magic_enum::enum_integer(ProfileRole::Token), "token"}};
}

} // namespace kemai
