######################################################################
# Automatically generated by qmake (2.01a) Fri Jan 3 01:40:45 2014
######################################################################

TEMPLATE = lib
QT =
TARGET = sample-plugin
DEPENDPATH += . ../src ../binding-mri
INCLUDEPATH += . ../src ../binding-mri
CONFIG += plugin

unix {
	CONFIG += link_pkgconfig
	PKGCONFIG += ruby-2.1
}

# Input
SOURCES += main.cpp
