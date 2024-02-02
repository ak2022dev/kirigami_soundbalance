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

The button appears in the top corner. Plan had been to add a text field. May need a label and text field. Will try next.

Using the Qt6 QML book from
<https://www.qt.io/hubfs/_website/QML%20Book/qt6book-with-frontpage.pdf>

Experimenting with a text input component. Will try compiling.

Fails with:
MESA: error: ZINK: failed to choose pdev
glx: failed to create drisw screen
failed to load driver: zink
QQmlApplicationEngine failed to load component
qrc:/main.qml:34:9: Controls.TextInput is not a type

Trying the Qt5 book from
<https://e8johan.github.io/qmlbook/assets/qt5_cadaques.pdf>

The example in the Qt5 book uses QtQuick 2.5 when using TextInput. My code uses 2.15. Is my 2.15 a typo...

Wonder how to find the differences between them, or which new components were introduced when...

Using this:
<https://doc.qt.io/qt-5/qml-qtquick-controls2-textfield-members.html>
It appears TextField inherits from TextInput. Could TextInput be abstract?

Will try commenting out TextInput and then add only a little more code at a time to try to compile.

Compiles when Controls.TextInput code commented out. Will reinstate with empty TextInput body and see what happens then.

Hmm. Seems to have built. Will check... So it compiles but fails to execute:

MESA: error: ZINK: failed to choose pdev
glx: failed to create drisw screen
failed to load driver: zink
QQmlApplicationEngine failed to load component
qrc:/main.qml:35:9: Controls.TextInput is not a type

Strange. Will see if I can find online anyone with similar problem.

Looking at this on Stack Overflow:
<https://stackoverflow.com/questions/26969518/qqmlapplicationengine-failed-to-load-component-type-is-not-a-type>

A number of possibilities here. Would the same happen if some other control were used? Button seemed to work okay.

If I add a second button, it seems to be in the same place as the first. Maybe time to add a layout and put them in that, then come back to the issue of the TextInput. Also wondering if maybe a Kirigami component is expected rather than a QML component. Not sure. Will look at some examples of layouts first, then go from there.

Moving forward with tutorial examples from KDE:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-getting_started/>

Noticed and corrected minor typo. Committed and recompiled.
I am wondering if the resources.qrc needs declaration of any further qml files to be added. Will check in later examples.

May need to pay particular attention to the any changes in build-tool configuration files in later examples, in case more libaries are included than in the helloword example.

<https://develop.kde.org/docs/getting-started/kirigami/introduction-pages/>

Above has a note about adding any new pages to the resources.qrc file. Not adding new pages yet, but still mindful of how something similar may be relevant for multiple components.

<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

Above starts documenting layouts, which I plan to try next.

It looks like ColumnLayout is worth trying. Not sure if need to change page to AbstractCard first though. Will see...

Will try using branch structures for these experiments so can rollback changes that didn't work, but also leave the experiments in place even if not merging back into main.

Working in newly created first_layout_tries branch.
To push, had to use this:

git push --set-upstream origin first_layout_tries

As kindly suggested by git.

Trying a ColumnLayout for the buttons, directly inside the application, without any other component to contain the layout. Will see if it compiles... Awesome. Did exactly what I expected. Now, what if I add the label into the layout too... Trying it...  No, that messed up the layout. Will try removing centralling from label...Yes, now that works. Will commit then merge into main...

Looking at this on Stack Overflow:
<https://stackoverflow.com/questions/5601931/how-do-i-safely-merge-a-git-branch-into-master>

Did the merge using these commands, so now back on main:
git checkout main
git pull origin main
git merge first_layout_tries
git push origin main

Re-ordered components in user-interface to reflect actual needs of app.
Next need to lookup how to link a button to accessing the files dialog.

Looking into actions, from KDE Kirigami documentation:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-actions/>

Looks even simpler than adding a button, because the action automatically creates one. It's what gets triggered when it's pressed I also need to look at. Also interesting are the icons that have existing names, that KDE will access. May return to those when needed. The example adds to the model. I need my action to open a dialog. I am sure further examples will show how...

<https://develop.kde.org/docs/getting-started/kirigami/introduction-separatefiles/>

Going further in the basic tutorial series as above does tackle more complicated topics, such as multiple qml files and adding them to resources.qrc, but I think I'll need bigger examples to find how file opening is done.

From examples they cite on
<https://develop.kde.org/docs/getting-started/kirigami/introduction-next_steps/>

I am looking at the gitlab page for koko, which is an image viewer, hoping it calls a file-opening dialog.

<https://invent.kde.org/graphics/koko>

Looking at this, for the main application:
<https://invent.kde.org/graphics/koko/-/blob/master/src/qml/Main.qml?ref_type=heads>

Using gitlab search for "filedialog" then searching for qmlfiledialog gave the following very useful info:

<https://doc.qt.io/qt-6/qml-qtquick-dialogs-filedialog.html>

It appears there may be an example showing me how to call the dialog.

Creating a branch for experimenting with file dialogs, called first_filedialog_tries.

Entered first_filedialog_tries. Will commit to record.
Compilation error when tried to include QtQuick.Dialogs. Qt5 demands version number. Looked up here:

<https://doc.qt.io/qt-5/qml-qtquick-dialogs-filedialog.html>

The example above is very different from the Qt6 examle. As I'm building with Qt5, will use the Qt5 example.

