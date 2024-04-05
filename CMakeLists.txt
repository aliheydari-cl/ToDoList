cmake_minimum_required(VERSION 3.16)

project(ToDoList VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Sql)

qt_add_executable(appToDoList
    main.cpp
)

qt_add_qml_module(appToDoList
    URI ToDoList
    VERSION 1.0

    SOURCES database.h database.cpp

    QML_FILES Main.qml
    QML_FILES AddTask.qml
    QML_FILES ShowTask.qml
    QML_FILES Clock.qml
    QML_FILES Edit.qml

    RESOURCES images/about.png
    RESOURCES images/email.png
    RESOURCES images/help.png
    RESOURCES images/menu.png
    RESOURCES images/settings.png  
    RESOURCES images/add.png
    RESOURCES images/add.png
    RESOURCES images/back.png
    RESOURCES images/clock-icon.png
    RESOURCES images/clock.svg
    RESOURCES images/clock_Hand.svg
    RESOURCES images/Minutes_Clock.svg
    RESOURCES font/B-NAZANIN.TTF
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appToDoList PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appToDoList
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appToDoList
    PRIVATE Qt6::Quick
)
target_link_libraries(appToDoList PRIVATE Qt6::Sql)
include(GNUInstallDirs)
install(TARGETS appToDoList
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
