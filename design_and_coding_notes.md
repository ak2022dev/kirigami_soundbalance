Design and coding notes
=======================

As this is my first kirigami app, I plan to code in an exploratory fashion.
First, I am to get an application window visible, using the kirigami helloworld
tutorial for inspiration.

In helloworld, the first step was to create the directory structure manually. I will do similar for this app.

I am using the page below for guidance:

<https://develop.kde.org/docs/getting-started/kirigami/introduction-getting_started/>

I have setup the directory structure and empty files as-per the example.

Next I will enter the main.qml file as-per the example.

Having entered and adapted main.qml, next I will do similarly for main.cpp.

Having entered and adapted main.cpp, next I will do similarly for resources.qrc.

Having entered resources.qrc, next I will do similarly for the top level CMakeLists.txt.

Having entered top level CMakeLists.txt, will do the same next for the one in soundsbalance/src.

soundsbalance/src/CMakeLists.txt needs to be amended from version for helloworld. Will do that next.

Having done all of the above, next step is to attempt to build soundsbalance. Will do that next.

As-per the helloworld tutorial, the build commands, according to my current folder structure, should be:

cmake -B build/ -DCMAKE_INSTALL_PREFIX="~/Documents/Coding/kde5/kirigami"
cmake --build build/
cmake --install build/

Executed all of the above from ~/Documents/Coding/kde5/kirigami/soundsbalance

Next will edit .gitignore to exclude build directories

Next will run the built executable to check it behaves as expected. It does.

Next will add a text field to input the sound value to balance files to.

To find out about adding a suitable text field, will consult KDE Kirigami tutorials, e.g.

https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/

Idea to try: what if just add a Controls.Button entry to the app? Will try next.


