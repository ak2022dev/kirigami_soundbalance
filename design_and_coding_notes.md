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

Done and committed.

So continuing with the examples, we now have two actions, namely one related to a button added in the main... something? Not sure where that main identifier comes from at the moment, but it appears to be related to the initialPage somehow. It adds a fixed item to the model, which then displays.

The other action is a menu item which calls a standard quit method.

Next looking at page for adding information of our own choosing:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-overlaysheets/>

Also useful on this example is moving focus from item to item, text fields with labels etc. So far, though, it's the model and delegate that are quite tightly linked. What if the model needs only be a string, or an array of strings? Not sure how to manage that. Would it be to use a fileDialog model of some sort, I may have come across? Will see later.

Okay, so now on the next page we're about to come to signals:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-separatefiles/>

It's useful in showing how signals are placed next to functions, and shows signal handling, but the example seems unclear because it seems to have definition for AddEditSheet, but doesn't show where that lies in the code. Is it in addEditSheet.qml, above the rest of the definition? Why doesn't it show all of the code clearly in all of the files? Confusing. I wonder if the code is available to download on a repo somewhere. Will have a quick look. Not seeing any links at the start of the tutorial. Will have a look again towards the end.

Have found the repo for the developer website. It's built using Hugo, which has won awards for being the best static site builder.

<https://invent.kde.org/documentation/develop-kde-org>

and

<https://gohugo.io/>

I have shared with KDE community via Matrix that I may be able to submit some merge requests if able to improve developer documentation at some stage, e.g. removed not documented as part of defining AddEditSheet.

The tutorial isn't clear on a few points: why is an instance of overlaysheet being used, not AddEditSheet? Also, very confusing that we seem to have to ids both addEditSheet. How does scoping apply to these?

Good to hear back from KDE community that merge request would be good. Will certainly get to that later when able!

Looking at below for guidance on this:
<https://www.unrepo.com/gitlab/working-with-gitlab-merge-requests-tutorial>


Some further clarity on when to clone and when to fork would be useful. I think fork when don't have permission to work on the original project, perhaps. New to github/gitlab collaboration, so will look into.

Further guidance here:

<https://community.kde.org/Infrastructure/GitLab#Submitting_a_merge_request>
There is a lot there. I am unsure if I have commit access, in which case I should be able to work in a branch without having to fork.

For now, back to QML/Qt!

Looking at this, as an example project from "Next steps" suggestion after first tutorial.
<https://invent.kde.org/plasma-mobile/calindori/-/tree/master/src/contents/ui?ref_type=heads>

I think either going further with the basic KDE tutorials would be more helpful, then skipping to the QML/Qt book for more advanced work.

Meantime forked the KDE developer documentation project on github, looked into the code for broken links, submitted a fix via merge-request. Response from a dev who's an expert on that repo says at the moment it's being transitioned from Qt5 to Qt6 so some links are broken, but will be fixed.

From the next steps page, I am most interested in linking QML to the C++ backend, so will look at the four pages about that linked from here:

<https://develop.kde.org/docs/getting-started/kirigami/introduction-next_steps/>

Firstly, to scan through understanding CMakeLists:
<https://develop.kde.org/docs/getting-started/kirigami/advanced-understanding_cmakelists/>

The above is important when it comes to ensuring build instructions are complete, but for the moment less-so, because first I need to learn how to exchange information back and forth between QML and Qt.

Onto overview of main.cpp next:
<https://develop.kde.org/docs/getting-started/kirigami/advanced-maincpp/>

Above looks fairly boiler-plate, just setting up includes for the build and passing command line parameters into the Qt application, plus setting-up a QML engine to start executing, and confirm execution of, with error and exit otherwise.

The next page on connecting the logic together is the really crucial one, I expect:

<https://develop.kde.org/docs/getting-started/kirigami/advanced-connect_backend/>

Writing logic in QML is discouraged, so need to avoid trying to do it in JS within the QML.

Example shows how to create a Backend class, which contains a Q_OBJECT macro, so will need to check against basic Qt docs about this.

It's suggesting additions to main.cpp and adding the new include. It talks of registering a module, again, I expect more on this in the Qt documentation.

It mentions importing the new module into QML.

It then talks about adding a property that can be connected to the frontend and automatically notify frontend and backend of changes.

It makes the property private but adds getter and setter methods, also a signal that doesn't really need implementation.

It shows how to emit the signal in the C++ code... and how to access the appropriate backend field in QML from the frontend.

It then refers further to Qt docs on this subject:
<https://doc.qt.io/qt-5/qtqml-cppintegration-definetypes.html>

Resuming with advanced parts of kirigami tutorial...

Looking also at the links for learning C++. This one below seems best:
<https://www.learncpp.com/>

Next: will try adding Backend class and compiling.

Meantime switched to working in kdevelop rather than Kate. Yes, feels much more comfortable already, especially with easier access to the filesystem.

Have entered the code for connecting backend to frontend based on the example. I am thinking it may not compile because they forgot to say to include backend.h in main.cpp, but will try as-is.

Yes, getting compilation error. Need to add backend.h into main.cpp I think... will try... Yes, that worked. Double-checking, was my mistake I missed reading that from the documentation(!)

Added the code to actually do something with the backend link. I adapted the tutorial into my example and ran it. Works!

Next step: to go deeper into this as recommended:
<https://doc.qt.io/qt-5/qtqml-cppintegration-definetypes.html>

The above is quite extensive. May be possible to use the code as-is to achieve some of what is required.

I have tried calling setter method in QML code but not working. Will record this version as WIP. Error output is:
qrc:/main.qml:51: TypeError: Property 'setIntroductionText' of object Backend(0x7ffe85fd3730) is not a function

Will look more carefully at existing changes that do work, so far... The kirigami example shows how to use the getter but not the setter; I need the latter. Will check for examples of that next.

Looking at the below, but it's very old. Will search for a newer example:

<https://forum.qt.io/topic/33170/call-c-function-from-qml/2>

Looking at below:
<https://devcodef1.com/news/1133862/qt6-linking-c-model-to-qml-listview>

It's newer, and seems to be calling method with ease. I wonder if it's to do with how the connection has been made...

Looking again at:
<https://doc.qt.io/qt-5/qtqml-cppintegration-definetypes.html>

but first at:
<https://doc.qt.io/qt-5/qtqml-cppintegration-exposecppattributes.html>

and may also need to come back to:
<https://doc.qt.io/qt-5/metaobjects.html>

also, apparently, the following tutorial is good for exemplifying; may need to come back to:
<https://doc.qt.io/qt-5/qtqml-tutorials-extending-qml-example.html>

Type conversion may also be an issue. May need to come back to this:
<https://doc.qt.io/qt-5/qtqml-cppintegration-data.html>

Apparently data ownership may also be an issue to come back to:
<https://doc.qt.io/qt-5/qtqml-cppintegration-data.html#data-ownership>

The expose attributes page is very useful!
<https://doc.qt.io/qt-5/qtqml-cppintegration-exposecppattributes.html>

The tricky thing is indeed the registering correctly with the engine, it seems...
When using QPROPERTY, READ etc name the method within the class.

Yes, the expose attributes page does seem the most useful. I will look again at my app accordingly.

Am finding that fileDialog.fileUrls seems to undefined. Will try to get console output working again to do some debugging...

Will try running using these command line parameters:
QT_LOGGING_RULES="*.debug=true; qt.*.debug=false" ./soundsbalance

The console output appears to be showing the correct file, when only one file selected... Trying to select more than one with ctrl-click doesn't seem to work. Will need to consider return type from the fileDialog perhaps, then work with that...

<https://doc.qt.io/qt-5/qml-qtquick-dialogs-filedialog.html#fileUrls-prop>

According to above, it's a list<url>. Would toString() work for that...?
Perhaps it should be .fileUrl not fileUrls...? Will try...

Console still gives correct output, but it won't allow me to call toString on it...?

Have considered examples from exposing attributes carefully, and noticed use of local variable. Tried the same and code now seems to work. Will commit before tidying up.

Next: tidy up current app so that variable names for exchange between front and backend actually match the task they have. Will go back to example to ensure no steps missed:

<https://develop.kde.org/docs/getting-started/kirigami/advanced-connect_backend/>

Altering the Q_PROPERTY line in backend.h first...
Altering private property in backend.h...
Altering public fields in backend.h...
Altering relevant code in backend.cpp...

Took out some code that was essentially to test parts of how QML was working. Ready to commit a working version.

Idea: if only getting a single filename from the fileDialog, maybe test by acting only on a single file, perhaps reduce its volume to almost silence?

Will try that on command line using FFMpeg first, then take it from there.

Official docs for FFmpeg are quite hard to follow:

Using below website:
<https://trac.ffmpeg.org/wiki/AudioVolume>

So initial idea will be to take an audio file and halve its volume.

Fedora has a package version called ffmpeg-free, restricted in some of the codecs it handles. Installed that. Will run some generic tests on it, outside of this git directory.

Using this website:
<https://freetestdata.com/audio-files/mp3/>

Have downloaded 2MB, then 100KB. The second is long enough for basics tests.

A test like below:
ffmpeg -i input.wav -filter:a "volume=0.5" output.wav

Did indeed halve the volume. Next will try to add C++ code to execute that command using C's system call or C++/Qt equivalent.

Looking at this page:
<https://stackoverflow.com/questions/10798916/using-system-command-in-qt>

and the QProcess documentation:
<https://doc.qt.io/qt-6/qprocess.html>

in particular the execute method:

The Qt version wasn't sending output to the shell. The basic C-style system call is. Committing a current version including test that works.

Next: make a system call linked to opening a file...

Initially will try adding a method into backend that will be called...
Will refer to this:

<https://doc.qt.io/qt-5/qtqml-cppintegration-exposecppattributes.html>

Looks like I need the Q_INVOKABLE macro...
Have added it and compiled. Will try calling it... Done. Still works, but method is blank, and calling from cpp. Will try to make it do a system call... Getting a segmentation fault with core dumped. Not sure why... Identified type, missing colon in std::system. Now seems to be working... Will do a commit...

In my commit I noted next step was to try making a system call from QML. Adding that next.

Getting this error:
qrc:/main.qml:46: Error: Unknown method parameter type: const char*

Looks like to call the method in QML, need a type that QML can easily deal with. Will look into next.

Starting from this page again:
<https://doc.qt.io/qt-5/qtqml-cppintegration-exposecppattributes.html>

It's mentioning this, which might be relevant:
<https://doc.qt.io/qt-5/qtqml-cppintegration-data.html>

It appears that C-style low-level char* type strings aren't available to QML. Seems like the easiest thing would be to pass down a QString, then convert that in C++ backend before making the system call.

Looking at below:
<https://stackoverflow.com/questions/2523765/qstring-to-char-conversion>

and this:
<https://doc.qt.io/qt-5/qtglobal.html#qPrintable>

Having changed the type of the C++ backend function, need to check where I might need to declare these changes, then make them:

backend.cpp...   backend.h...

I am unsure if there are further declarations that may be necessary in other files, e.g. for QML resources. Will check back in my git history using gittyup to find the last time I modified a set of files for a C++ backend function update...

Looking back at my history, am going to change just main.qml next if needed... Possibly don't need to anyway. Will try compiling...

Quite a few type errors. Going to review my C++ object creation and references briefly...  Approx first 135 pages of C++(11) book most relevant. 2022 edition of Tour of C++ may also be useful, if a new edition of C++ book not due out soon, as 2023 version is about to be released.

Read about 200 pages from C++ book past couple of days, and skimmed next 400. Getting there with the QML coding too. Some bits aren’t visible on Kindle. Looking at the QML5 version on-screen now IA. Hmm. Not sure where my Qt is installed, because the env variable it mentions isn’t set in my environment. Reading on. Reached section on transformations. Not sure this is so relevant. Skipping forward IA… Layouts and anchoring are more relevant… Reached 4.7 on Input elements. May have to come back to FocusScope… So… TextInput is one line, TextEdit is more than one line. Keys element also useful. Interesting that QML and JS are interpreted, but can be compiled too. I think Kirigami compiles. Chapter 5 animations, not that relevant for the minute, at least IA… 5.2 states, may be relevant… Yes, explicit coding of states could be useful. They seem to be frowning upon it though, due to excess JS? I wonder if Qt has a similar thing? What about React? A lot of the Qt5 docs look unreadable. I think I’ll need to find the online version.

Yes, found it here:
<https://qmlbook.github.io/index.html>

There is an example of using the fileDialog, but it just sets an image to the url from the dialog: very high level. Scanned through chapter 6, onto chapter 7 now, on model-view-delegate. It’s talking about a repeater. May return to this. All of it may become relevant, but not just yet. I need to move onto the JS types that QML understands, then getting those into the backend. It’s talking about Felgo. First I’ve heard of that. It does still exist, and has migrated to Qt6, which is good news. Multimedia chapter looks interesting, but still prefer to use backend Ffmpeg. Chapter 13 networking example also looks useful! REST example included, Oauth and Web sockets too. 14 on SQL, but again, for later. 15 on dynamic QML may become relevant later, not sure. Perhaps some of the controls already manage this kind of thing? Will have to check. The JS chapter (16) is definitely useful, especially, looking at the function calling part. Not sure about things like using eval. Chapter 17, Qt and C++ is probably quite relevant.

Just been scanning through. It’s saying model view programming is one of the hardest tasks in Qt. Will be great to get it done.

Have read a number of chapters from the book now. Focused somewhat on the Qt chapter, to get an overview, also on slots. Looked at how to create a model, which is indeed tricky. Still a bit stuck on the types and possible type conversions, but will focus on that next. Also will open the project and commit some changes into the design/coding notes from this document.

Reminding myself of where I am in the code, committed as WIP:

Second stage build:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp: In function ‘int main(int, char**)’:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:36:20: error: cannot bind non-const lvalue reference of type ‘QString&’ to an rvalue of type ‘QString’
  36 |     backend.system("ls");
     |                    ^~~~
In file included from /usr/include/qt5/QtCore/qcoreapplication.h:44,
                from /usr/include/qt5/QtWidgets/qapplication.h:44,
                from /usr/include/qt5/QtWidgets/QApplication:1,
                from /home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:7:
/usr/include/qt5/QtCore/qstring.h:835:31: note:   after user-defined conversion: ‘QString::QString(const char*)’
 835 |     inline QT_ASCII_CAST_WARN QString(const char *ch)
     |                               ^~~~~~~
In file included from /home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:14:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/backend.h:15:38: note:   initializing argument 1 of ‘void Backend::system(QString&)’
  15 |     Q_INVOKABLE void system(QString &command);
     |                             ~~~~~~~~~^~~~~~~

Will go through and review some of this in light of reading past couple of days.

Looking at main.cpp first, and noticing backend.system is expecting QString&, will try fixing...

Changing to this:
backend.system(QString::QString("ls"));

Gave me:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp: In function ‘int main(int, char**)’:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:36:36: error: cannot call constructor ‘QString::QString’ directly [-fpermissive]
   36 |     backend.system(QString::QString("ls"));
      |                    ~~~~~~~~~~~~~~~~^~~~~~
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:36:36: note: for a function-style cast, remove the redundant ‘::QString’
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:36:36: error: cannot bind non-const lvalue reference of type ‘QString&’ to an rvalue of type ‘QString’
In file included from /home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:14:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/backend.h:15:38: note:   initializing argument 1 of ‘void Backend::system(QString&)’
   15 |     Q_INVOKABLE void system(QString &command);
      |                             ~~~~~~~~~^~~~~~~
gmake[2]: *** [src/CMakeFiles/soundsbalance.dir/build.make:97: src/CMakeFiles/soundsbalance.dir/main.cpp.o] Error 1
gmake[1]: *** [CMakeFiles/Makefile2:153: src/CMakeFiles/soundsbalance.dir/all] Error 2
gmake: *** [Makefile:146: all] Error 2

So seems to be a problem with it being a reference as well. Will try adjusting that...

So have removed the reference and will try again...

Fewer errors. Now have:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp: In function ‘int main(int, char**)’:
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:36:36: error: cannot call constructor ‘QString::QString’ directly [-fpermissive]
   36 |     backend.system(QString::QString("ls"));
      |                    ~~~~~~~~~~~~~~~~^~~~~~
/home/ark/Documents/Coding/kde5/kirigami/soundsbalance/src/main.cpp:36:36: note: for a function-style cast, remove the redundant ‘::QString’
gmake[2]: *** [src/CMakeFiles/soundsbalance.dir/build.make:97: src/CMakeFiles/soundsbalance.dir/main.cpp.o] Error 1
gmake[1]: *** [CMakeFiles/Makefile2:153: src/CMakeFiles/soundsbalance.dir/all] Error 2
gmake: *** [Makefile:146: all] Error 2

Changed to
    backend.system(QString("ls"));

Now compiles...

After further minor fix to main.qml, on running:
qrc:/main.qml:46: ReferenceError: QString is not defined

Will commit as-is, and look at QML type conversions, potentially.

According to this:
<https://doc.qt.io/qt-6/qtqml-cppintegration-data.html>

Automatic type conversion from QString to QML string and vice versa. Yes! It appears to have worked when I took out the attempt to create a new QString in QML. Double-checking... Done and committed.

Next: plan is to check if FFMpeg can give me some kind of average volume analysis for a given file...
Ah... it looks like mp3gain can do what I need directly. Might use that instead of FFMpeg. Just checking...
Installed on Fedora. Looking up how to use...

<https://www.mankier.com/1/mp3gain>

Looks like we need:https://develop.kde.org/docs/getting-started/kirigami/introduction-getting_started/
mp3gain -r [list of filenames separated by spaces]

Need to go through and test the above as next step.

So, above should set all files to same volume. Going to try testing that...
Yes, I have run the tests and they worked.
Next: will copy the two files into the folder where the app is run from, and hard-code running it from the app.

Worked. Will commit.

Next steps. Maybe use the fileDialog to populate a text field, then a second text field, and then run the command?
Will revisit existing code and start refactoring.
Have commented-out what the app did after file selected, for now, apart from quit. Will continue to add to app piecemeal, with commits in-between.

Looking-up properties of TextField... Seems it will need a separate label. Adding... Now added two text fields. Will commit, then try adding an additional button and figure out the logic for that. Added a second button. Also added a second dialog, because the effect of each needs to be different. Not sure if this is the optimal way, but will try it for now. Also tied choosing a file to populating one of the text fields. Will commit, add for second, then test and commit.

Done the above. Next will look at changing the url into a filename. It would appear that removing the first few characters and adding a ~ should do the trick on Linux.
E.g. "file:///home/ark/Documents/Coding/kde5/kirigami/soundsbalance/build/src/Makefile"
->               "~ark/Documents/Coding/kde5/kirigami/soundsbalance/build/src/Makefile"

Going to see if can do the above just in JS...
<https://bobbyhadz.com/blog/javascript-remove-first-n-characters-from-string#remove-the-first-n-characters-from-a-string-using-stringslice>

Managed the above, cleaned-up code including removing old comments, relabeling buttons etc. Ready to commit and move forward.
Next step: to call the external program on the two chosen files.
Done and tested. Will commit. Next, clean up interface, as to when application quits.
Done. Will commit.

Will rerun app, and sketch how it should look, compared to how it currently looks, then change it piecemeal.
KDevelop keeps writing error output to the console, will try technique from this page:

<https://stackoverflow.com/questions/44758736/redirect-stderr-to-dev-null>

Not sure if that's worked, but was worth a try...

I've done the sketch. Just need to lookup the type of layouts, mentioned in Kirigami documentation...

Looking at this example:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-getting_started/>

I think I'll try for a KirigamiApplication at the top level, then work from there...

Seems I already have that, so will look deeper at the structure...

I think I need a column of rows of things. Looking up how to get a row...
From this page:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

Looks like need RowLayouts...
Did that and committed. Also logically reorganised code to put non-visual elements last. Next looking at centering title label and making longer the filename text fields... Looks like Kirigami discourages absolute sizes, which makes sense to keep it responsive. May look at lower-level QML components for now, though. Idea: lookup what's included in QtControls and move forward from there...

Looking at this:
<https://doc.qt.io/qt-5/qml-qtquick-controls2-label.html>

Doesn't appear to be any reference about explicit sizing, so will leave that for now.
Next, considering writing a shell script to enable easier testing...

Idea: get two files, check they're not copyrighted and at different volumes, place them in a test source files folder, write a shell script that will copy them to a known location every time it's run.

Added directory structure and created a shell file, to be run in the testsources directory, by typing
sh ./test_setup.sh

The above will create a copy of the two test files into the ../test directory.

Next steps: scan in annotated code from previously and update README. Tag at this stage, before moving to a model-view-delegate version.

Tagged as v1.0. Next will start looking at model-view-delegate version. Will experiment in a branch.

***

Created branch mvd-experiment1, working in that.
Will use this as a basis:
<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

The above is a start, but doesn't allow adding more instances of model, which we will need. Moving further in the tutorial...

At the moment documentation is in flux and seems incomplete, unfortunately. Will try to manage with what is there at the moment.

Will start by refactoring to basic app using the correct pattern, then incrementally add functionality from old version...

Reached a stage where the delegate needs to start adding text field, button etc...

Having done the basics of above, now need to figure out how elements within list model/view interact with other components / objects that are part of the same list "element" or whatever the correct terminology is for that. Will look at other examples too, having so-far used this:

<https://develop.kde.org/docs/getting-started/kirigami/introduction-listviews/>

The Qt/QML book is proving useful for the model-view-delegate design pattern.
<https://www.qt.io/hubfs/_website/QML%20Book/qt6book-with-frontpage.pdf?utm_referrer=https%3A%2F%2Fwww.qt.io%2F>

The above is for Qt6 but that's fine because Kirigami is soon to be ported to Qt6 anyway; also advised by some members of KDE to consult the Qt6 version of this book.

<https://www.qt.io/product/qt6/qml-book/ch07-modelview-model-view>

The above is the web-page version where model-view-delegate explanations start in-earnest. It is essential reading in my opinion.
