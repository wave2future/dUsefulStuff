
# Changes Version 0.0.6

* After an informative discussion on StackOverflow, re-wrote the DCUIRating initialisation code to be simpler.
* refactored the DCUIRating code and tests. Created strategies for the various calculations and drawing methods. 
* Fixed EXC_BAD_ACCESS error in DCDialogs:displayMessage: due to un-required release of the message string.
* Added optional --debug parameter to the main build script which enables building a debug library.

# Changes Version 0.0.5

* Fixed a bug where the bubble on a DCUIRating was being drawn behind other controls.
* Refactored the bubble out to a standalone class that can be used with any UIView based class. 
* Renamed to DCUIBubble.
* Added the ability to a DCUIBubble to be able to draw a rounded rectangle as a background.
* Refactored DCUIRating to take an instance of DCUIBubble rather that act as a facade. This has simplified DCUIRating.
* Added DCCoreData to provide some commonly used Core Data code.

