Realm of the Mad God: Fame Tracker
==================================

This is an AutoHotkey script designed to help track progress in a fame train
by recording, calculating, and displaying fame at varying time intervals.


Warning
-------

**This script does not automatically read fame information from the game**.
You must be able to type this information in while you are running the train.
This script makes use of the numpad to facilitate this. If your keyboard does not
have a numpad, you must do one of the following:

1. Hook up an external keyboard which does include a numpad.
2. Hook up an external numpad.
3. Get better at mental math because I can't help you.
4. Modify the script to use some other esoteric key combination that only you will remember. I still can't help you.


Motivation
----------

Sometimes you really want to know how effective the fame train is but you
don't want to have to teleport away from the fame train or sit around
vulnerable in the godlands to do the calculations.

Sometimes other people on the train want to know too and you want to help
them out with that curiosity without them risking their characters in the
same way you don't want to risk them.


Preparing to Use the Fame Tracker
---------------------------------

1. Make sure you have AutoHotkey installed. Any version should be fine.
2. Run `fametracker.ahk`; you should briefly see a green "H" icon in the task tray.
3. Start playing Realm of the Mad God and find a fame train.

Actually Using the Fame Tracker
-------------------------------

The display for the script is a tooltip on the top-left corner of the game
window. This displays the current state of the script.

The following keys are intercepted no matter what you're doing on your computer.
If you need the functionality of the following keys, you must exit/quit the script.

* Push F12 to exit/quit the script.
* Push F11 to enable/disable pasting fame-per-minute stats to clipboard. (default off)
* Push F10 to disable/enable the numpad ENTER key. (default: ENTER enabled)

All of the following keys can be used while you're doing stuff
like keeping up with the fame train or dodging incoming enemy fire. They're
also context-sensitive so they will only act like this when you're playing
Realm of the Mad God.

* Numpad 0-9 to input current fame
* Numpad . (dot) deletes the previously-entered digit
* Numpad + (add) adds the currently-input number to the list
* Numpad - (subtract) deletes the most-recently added number from the list

To clear the script's list, hold NumpadSub (-) until all entries are deleted and the
script asks you to input an initial number.


Using the Clipboard Stats
-------------------------

When you push F11 to enable this mode, the following text is placed on the
clipboard:

~~Interval [`itime` / `ifpm`]   Total [`ttime` / `tfpm`]~~

* ~~`itime` is the amount of time, in minutes, between the most recently added
fame, and the fame added before that.~~
* ~~`ifpm` is fame-per-minute as measured from the previously added fame value
to the most recently added fame value.~~
* ~~`ttime` is the amount of time, in minutes, from the very first time you input
a fame value to the time you most recently added a fame value.~~
* ~~`tfpm` is fame-per-minute as measured from the very first fame value you
added to the most recently added fame value.~~

`fpm` fpm

* Where `fpm` is fame-per-minute as measured from the previously added fame value
to the most recently added fame value.

This section was modified to make the return more discreet and avoid being called
out as a "hacker" or a "botter". Some people simply can't appreciate something
that technically isn't against ToS (as it doesn't actually touch the game or any
of its components).

Share this info to anyone who wants to know. It's on your clipboard so you
can paste it to the chat.

Known Problems
--------------

1. Numpad doesn't do anything.

   Context sensitivity is determined by checking if the active window
   contains the text "Adobe Flash Player" or "Realm of the Mad God"
   If the game window doesn't have any of that in the title bar,
   you'll need to somehow contact me with the details.
   Or you can fix this yourself by modifying the getgamewindow() function.
   
2. The app is trying to "work" in places that isn't the game window.

   Same context sensitivity problem as item (1). In this case, you should
   quit/exit the app by pushing F12, then restart the app when you are
   ready to play Realm of the Mad God again.


