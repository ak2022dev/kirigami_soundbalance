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

Seems to have built, given a version number for Dialogs. Did some more experimenting, including making the dialog visible. Compiles and opens the filedialog. Now need to see how to link it to another button. Possibly give it an id and wire to a button that way?

Considering this example from Stack Overflow:
<https://stackoverflow.com/questions/48318193/how-to-correctly-use-filedialog-in-qml-qt>

Used it and got the file dialog to open when button pressed, as required.
Will merge these changes back into main next...

Did this using:
git checkout main
git pull origin main
git merge first_filedialog_tries
git push origin main

Next will look at getting list of selected files into my app ready for calling them using back-end later...

Have added code, compiles, but doesn't output to console as expected.
Am considering the following:

<https://stackoverflow.com/questions/36338000/qml-console-log-and-console-debug-dont-write-to-console>

In the terminal, executing using line below:
QT_LOGGING_RULES="*.debug=true; qt.*.debug=false" ./soundsbalance

Did give me the output expected, but also a lot of logging info with it. A start.

Attempting to pass values from fileDialog back into the button, but maybe too simplistic and need to review how to use models before continuing. To work on next.

Just picking-up again after weekend. Next steps are to look at examples that use models and pass values between components. Will use:

<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

which appears to have the first use of model and delegate, in the CardsListView example.

There appears to be a ListModel type. It's then going into AbstractCard example, but not what's relevant right now. It's the model I'm interested in, and potential interaction with delegate.
So, it's looking like the application for its page stack, a scrollable page, with a cards list view inside it, with a model and delegate field that provide the id value for the objects of those names that will handle the model and delegate part of the model/view/delegate pattern. Still unsure if this is same as model/view/controller. Will check...

Using this:
<https://en.wikipedia.org/wiki/Delegation_pattern>

seems like delegate is a more specific term that might be more modern than controller, and also refers to use of composition rather than inheritance. Makes sense in light of code example. Tightly coupled anyway, nonetheless, it seems(?)

Observing in the KDE example that the CardsListView contains a delegate which is a component in which there is an AbstractCard...

So far, not seeing how data goes to and from the model. Hoping to find that later in the docs. Maybe it's convention over configuration?

Well, the page on adding actions has the first example of a model being changed. It appears that the model object's id can be used, then a method called on it. Nothing has really been said about scoping rules here, so will need to look to those up at some stage, but will experiment for now.

<https://develop.kde.org/docs/getting-started/kirigami/introduction-actions/>

It looks like the onTriggered property is a callback specifying an action. It also seems that a number of Model types may exist, which basically encapsulate a data structure plus its access methods. I am wondering about creating custom models too, but maybe that will come later.

So, intro on creating a menu later on the page here too:
https://develop.kde.org/docs/getting-started/kirigami/introduction-actions/

On the next page, we have use of TextField, which I experimented with earlier, so this should be interesting:

https://develop.kde.org/docs/getting-started/kirigami/introduction-overlaysheets/

It's putting the controls for the overlay sheet inside a form layout.
Just been carefully reading the code and piecing together how things fit. Also just going to check the includes, to see if anything further has been included compared to the helloworld app, because I was getting a type error when I tried to add a TextField or similar object previously.

No, the app example so far does not include anything further, in fact my app includes more than it does, namely QtDialogs too.

I have followed through the rest of the example. It's quite involved and needs a core careful look to see how the moving parts remain linked together. I think some of the overview chapters from the QML book might not be bad to at least cast an eye over, too, without going too deep into them, necessarily. Will do that next.

Have printed and annotated the example from this page:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-overlaysheets/>

Have some ideas for how to proceed with my app now, which I will try piecemeal.

Rebuilding and running the code as it stands, just to remind myself...
Ah, I think I need to run some command-line parameters as well, to see console output...

QT_LOGGING_RULES="*.debug=true; qt.*.debug=false" ./soundsbalance

Previous git log for code records the following:

WIP trying to add code to pass file names from fileDialog back into code for further use. Currently not working. To investigate models next

Okay. So the last build didn't work, and will need to fix it.

On execution, the following error results:
qrc:/main.qml:38:17: Cannot assign to non-existent property "fileDialogResponse"

Experimentally, I inserted a field into the button to try to capture the result from the fileDialog, but that seems to fail due to the field not being present in the Controls.Button type, hence investigating use of model. Will lookup model types in QML/Kirigami docs to see if there might be a simple type that is appropriate to try using first...

Scanning this document about QML imports, which appear to be using JS modules, probably.
<https://doc.qt.io/qt-6/qtqml-syntax-imports.html>

Scanning this document about QtQuick:
<https://doc.qt.io/qt-6/qtquick-index.html>

It mentions the QtQML module provides the QML engine and language infrastructure, on which there is more here:

<https://doc.qt.io/qt-6/qtqml-index.html>

including a link explaining what QML is:

<https://doc.qt.io/qt-6/qmlapplications.html>

Within the above, the following reference also looks useful:

<https://doc.qt.io/qt-6/qmlreference.html>

and these coding conventions:

<https://doc.qt.io/qt-6/qml-codingconventions.html>

this glossary of terms:

<https://doc.qt.io/qt-6/qml-glossary.html>

and this link to apis by module:

<https://doc.qt.io/qt-6/modules-qml.html>

Scanning through some of the above, ObjectModel seems promising:

<https://doc.qt.io/qt-6/qml-qtqml-models-objectmodel.html>

I was expecting it to be close to a plain JS object, but it's not. It's to contain visual items to be used in a view, and if used, a delegate is not needed.

Looking at below, to see how to integrate JS code into the QML interface, which may be what I need:
<https://doc.qt.io/qt-6/qtquick-usecase-integratingjs.html>

Ah yes, seems like exactly what I need. So the Item type is basically for JS type objects, and their fields can be referred to using their id value it seems. Just going to go back through the Kirigami example to see if that's used in there.

It used in this example:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

Which explains that Item is like the base type for other QML types, and doesn't have an actual visual representation.
<https://doc.qt.io/qt-6/qml-qtquick-item.html#details>

It can be useful for grouping several items under a single root visual item, as exemplified above.
Also, example above abstracting functions into a separate Logic (namespace?) seems useful.

Plan: to try to use an Item to add some JS code to my app. First remove erroneous code to return to a working user-interface/app.

Adding an Item, then a field of my own choosing doesn't work. Will have another look at the example of combining JS into QML:

<https://doc.qt.io/qt-6/qtquick-usecase-integratingjs.html>

The above seems to suggest functions can be defined inside Item, but perhaps not further fields. Looking at below on JS expressions in QML:

<https://doc.qt.io/qt-6/qtqml-javascript-expressions.html>

This leads to a number of complexities, as linked to on above page. I am wondering if Model types are more what I need. Seems will need an overview of QML ways of working to figure-out this part.

Searching for help online revealed the following on Stack Overflow, and mention of a FolderListModel, which may be what I need. I am more inclined now, to look at the Model types further.

<https://stackoverflow.com/questions/48318193/how-to-correctly-use-filedialog-in-qml-qt>

<https://doc.qt.io/qt-6/qml-qt-labs-folderlistmodel-folderlistmodel.html#details>

Also noticing the following, further down in the Kirigami examples:

<https://develop.kde.org/docs/getting-started/kirigami/advanced-connect_backend/>

So, it's discouraged to try to describe logic in QML (using JS, presumably), so the preference is to send data into the back-end.

Scanning the above...

Further to that, I looked more deeply into the interaction between QML and Qt/C++, from the QML/Qt book. It seems deeply linked to the QObject model and the way Qt uses signals and slots. I need to get at least the basics of that understood, without going too deep for too long, hopefully. I will be using the KDE examples to inform me further. I also understand model, view and delegate differently after last night's reading, and need to see how that's all fitting together too, in the Kirigami examples.

Reviewing the examples, reading in more detail, starting with
<https://develop.kde.org/docs/getting-started/kirigami/introduction-getting_started/>

This time, going into more detail on main.cpp:
<https://develop.kde.org/docs/getting-started/kirigami/advanced-maincpp/>

Looking at this, for the resource file, though it links to Qt5, which used QMake, rather than CMake which I believe Qt6 standardises to.

<https://doc.qt.io/qt-5/resources.html>

Really appreciating how "real world" this is, in terms of providing for really large software projects, potentially!

Browsing this site, on CMake, the defacto standard C++ build tool(!) I am glad we have this(!)

<https://cmake.org/>

<https://cmake.org/history/>

There is a very good book on this on Kindle, which I may purchase later, as I get more into C++ project builds.

Scanning through this explanation of the top-level CMake file:
<https://develop.kde.org/docs/getting-started/kirigami/advanced-understanding_cmakelists/>

Scanning through the find_package docs:
<https://cmake.org/cmake/help/latest/command/find_package.html>

Looking at next page of Kirigami example
<https://develop.kde.org/docs/getting-started/kirigami/introduction-pages/>

and the Kirigami Gallery it recommends:
<https://apps.kde.org/en-gb/kirigami2.gallery/>

Installing Kirigami Gallery on Fedora 29 (Gnome Boxes)...
Played with it. Very interesting!

I am looking at this, on layouts, where it introduces models:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

... also the link to the ListView type in QML, which explains which models it can work with. Again, needing to understand QObject and the hierarchy with it seems essential.

<https://doc.qt.io/qt-6/qml-qtquick-listview.html#details>

This also leads back to
<https://doc.qt.io/qt-6/qtqml-javascript-topic.html>
<https://doc.qt.io/qt-6/qtqml-javascript-expressions.html>

and

<https://doc.qt.io/qt-6/qtqml-syntax-signals.html>

This latter I have not seen previously and will look at next.
It's useful, but it's for signal handling in QML/JS. What I'm more interested in is connecting the front-end to back-end, and apparently that's also done by using signals.

Coming back to
<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

it then refers to delegate being what knows how to do the displaying in the view.

Looking closely at the objects and their relationships...

So, the application has a model and a component (which is the delegate). The component/delegate has an abstract card whose content item is a single item, which has a grid layout, and contains a heading, a sub-column layout which has a level-2 heading for the name, a separator and a description; and then a button back in the grid view.

The cards list view as the initial page of the pagestack for the application, is a scrollable page containing the cards list view, whos model and delegate are named using ids.

At the moment the code has not been written for the edit buttons.

The next page of documentation starts referring to actions, which will result in user interaction having an effect:

<https://develop.kde.org/docs/getting-started/kirigami/introduction-actions/>

Made some changes to main.qml to see if a compilable version of the code can be produced to move forward with.
