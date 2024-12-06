project(Kemai)

#
# Source listing
#
set(KEMAI_QML_FILES
        qml/Main.qml
        qml/LoginPage.qml
)

set(KEMAI_RESX_FILES
        images/kimai_logo_transparent.svg
)

set(KEMAI_CPP_FILES
        cpp/main.cpp
)

#
# Target configuration
#
qt_standard_project_setup(
        REQUIRES 6.7
        I18N_TRANSLATED_LANGUAGES fr)

qt_add_executable(${PROJECT_NAME} WIN32 MACOSX_BUNDLE ${KEMAI_CPP_FILES})

qt_add_qml_module(${PROJECT_NAME}
        URI kemai
        QML_FILES ${KEMAI_QML_FILES}
        RESOURCE_PREFIX /
        RESOURCES ${KEMAI_RESX_FILES}
)

qt_add_translations(${PROJECT_NAME}
        TS_FILE_DIR translations
)

qt_add_resources(
        ${PROJECT_NAME} "controls_conf"
        PREFIX "/"
        FILES "qtquickcontrols2.conf")

configure_file(cpp/kemaiConfig.h.in ${PROJECT_BINARY_DIR}/cpp/kemaiConfig.h)
target_include_directories(${PROJECT_NAME}
        PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/cpp ${CMAKE_CURRENT_SOURCE_DIR}/cpp)

target_compile_definitions(${PROJECT_NAME}
        PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME}
        PRIVATE Qt6::Gui Qt6::Quick spdlog::spdlog)

#
# Install
#
install(TARGETS ${PROJECT_NAME}
        BUNDLE DESTINATION .
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
qt_generate_deploy_qml_app_script(
        TARGET ${PROJECT_NAME}
        OUTPUT_SCRIPT deploy_script
)
install(SCRIPT ${deploy_script})