add_executable(soundsbalance)

target_sources(soundsbalance PRIVATE
    main.cpp
    resources.qrc
)

target_link_libraries(soundsbalance
    Qt${QT_MAJOR_VERSION}::Quick
    Qt${QT_MAJOR_VERSION}::Qml
    Qt${QT_MAJOR_VERSION}::Gui
    Qt${QT_MAJOR_VERSION}::QuickControls2
    Qt${QT_MAJOR_VERSION}::Widgets
    KF${QT_MAJOR_VERSION}::I18n
)

install(TARGETS soundsbalance ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
