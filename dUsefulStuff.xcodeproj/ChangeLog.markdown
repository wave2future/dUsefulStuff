
# Changes Version 0.0.6

* After an informative discussion on StackOverflow, re-wrote the DCUIRating initialisation code to be simpler.
* refactored the DCUIRating code and tests. Created strategies for the various calculations and drawing methods. 
* Fixed EXC_BAD_ACCESS error in DCDialogs:displayMessage: due to un-required release of the message string.
* Added optional --debug parameter to the main build script which enables building a debug library.
* Refactored DCCoreData so that all required objects are now created in the constructor. 
* Added a delete method to DCCoreData.
* Removed the did quit message from DCCoreData;
* Remove DCDialogs:displayMessage: from DCCoreData. Now returns error objects instead.
* Switched to the OCMock framework after building OCMock as a framework.
* Fixed silly missing ';' in dealloc macro.
* Added DCUIRatingDelegate protocol to allow notification of changed value from DCUIRating.
* Fixed bug where external code setting the value dynamically was not refreshing the display.
* Updated deployment targets and SDKs to IOS4.2.
* Updated test to not use a depreciated NSFileManager method.

# Changes Version 0.0.5

* Fixed a bug where the bubble on a DCUIRating was being drawn behind other controls.
* Refactored the bubble out to a standalone class that can be used with any UIView based class. 
* Renamed to DCUIBubble.
* Added the ability to a DCUIBubble to be able to draw a rounded rectangle as a background.
* Refactored DCUIRating to take an instance of DCUIBubble rather that act as a facade. This has simplified DCUIRating.
* Added DCCoreData to provide some commonly used Core Data code.

