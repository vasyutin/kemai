#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/spdlog.h>

#include "kemaiConfig.h"
#include "misc/customFmt.h"

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

        // Create spdlog sinks : console, rotating file (3 x 5Mb) and Qt Object
        std::vector<spdlog::sink_ptr> sinks;
        sinks.emplace_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());

        auto logger = std::make_shared<spdlog::logger>("kemai", sinks.begin(), sinks.end());
        spdlog::register_logger(logger);
        spdlog::set_level(spdlog::level::debug);
        spdlog::set_default_logger(logger);

        logger->info("===== Starting Kemai {} =====", KEMAI_VERSION);

        QQmlApplicationEngine engine;
        engine.loadFromModule("kemai", "Main");

        return QGuiApplication::exec();
    }
    catch (std::exception& ex)
    {
        spdlog::critical(ex.what());
    }
    return -1;
}
