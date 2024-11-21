cmake_minimum_required(VERSION 3.16)

project(BYD VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

set(CMAKE_AUTORCC ON)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appBYD
    main.cpp

)

qt_add_qml_module(appBYD
    URI BYD
    VERSION 1.0
    QML_FILES
        Main.qml
        HMI/AC.qml
        HMI/App.qml
        HMI/ControlCenter.qml
        HMI/Home.qml
        HMI/Settings.qml
        Components/ACBar.qml
        Components/ACFan.qml
        Components/ACFunctionBar.qml
        Components/ColorSlider.qml
        Components/FunctionBar2.qml
        Components/FunctionBar3.qml
        Components/IconButton.qml
        Components/IconSwitch.qml
        Components/Navigation.qml
        Components/QuickSlider.qml
        Components/SwipeArea.qml
        Components/StatusBar.qml
        Components/SettingsModeBar.qml
        Components/SettingsList.qml
        Components/SettingsFunctionBar.qml
        Components/QuickWind.qml
        Components/QuickTemperatureList.qml

    SOURCES
        Interface/interface.h
        Interface/interface.cpp
        RESOURCES
            resources.qrc


)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appBYD PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appBYD
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appBYD
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appBYD
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
