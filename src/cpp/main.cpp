#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/spdlog.h>

#include "kemaiConfig.h"
#include "misc/customFmt.h"
#include "model/profile.h"

void kemaiQtMessageOutputHandler(QtMsgType type, const QMessageLogContext& /*context*/, const QString& msg)
{
    switch (type)
    {
    case QtDebugMsg:
        spdlog::debug(msg);
        break;
    case QtInfoMsg:
        spdlog::info(msg);
        break;
    case QtWarningMsg:
        spdlog::warn(msg);
        break;
    case QtCriticalMsg:
    case QtFatalMsg:
        spdlog::critical(msg);
        break;
    }
}

int main(int argc, char* argv[])
{
    try
    {
        qInstallMessageHandler(kemaiQtMessageOutputHandler);

        QGuiApplication app(argc, argv);
        QGuiApplication::setApplicationName("Kemai");
        QGuiApplication::setOrganizationName("Kemai");
        QGuiApplication::setApplicationVersion(KEMAI_VERSION);

        std::vector<spdlog::sink_ptr> sinks;
        sinks.emplace_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());

        auto logger = std::make_shared<spdlog::logger>("kemai", sinks.begin(), sinks.end());
        spdlog::register_logger(logger);
        spdlog::set_level(spdlog::level::debug);
        spdlog::set_default_logger(logger);

        logger->info("===== Starting Kemai {} =====", KEMAI_VERSION);

        kemai::ProfileModel profileModel;
        profileModel.setProfiles({
            {"Demo", "https://demo.kimai.org", "f7a0f2ce7901a9018f86b3119"}
        });

        QQmlApplicationEngine engine;
        engine.setInitialProperties({{"profileModel", QVariant::fromValue(&profileModel)}});
        engine.loadFromModule("kemai", "Main");

        return QGuiApplication::exec();
    }
    catch (std::exception& ex)
    {
        spdlog::critical(ex.what());
    }
    return -1;
}
