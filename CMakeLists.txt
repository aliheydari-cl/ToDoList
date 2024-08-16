cmake_minimum_required(VERSION 3.16)

project(ToDoList VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)

qt_add_executable(appToDoList
    source/main.cpp
)

file(GLOB header_files source/*.h)
file(GLOB source_files source/*.cpp)

source_group("Header" FILES ${header_files})
source_group("Sources" FILES ${source_files})
source_group("Ui" FILES qrc.qrc)

qt_add_qml_module(appToDoList
    URI ToDoList
    VERSION 1.0

    SOURCES
        ${source_files}
        ${header_files}

    RESOURCES
        qrc.qrc
)

set_target_properties(appToDoList PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appToDoList PRIVATE
    Qt6::Quick
    Qt6::Sql
)

include(GNUInstallDirs)

install(TARGETS appToDoList
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
