# dUsefulStuff static library v0.0.1

This library is intended as a container of useful defines and classes which can make life easier when developing iPhone applications.

# Installing

This is if you want to just use the library.

1. Download the latest dmg file. This contains compiled versions of the library for the devices (IiPhone and iPad) and simulator, in both debug and release versions.
1. Create a group within Frameworks in your XCode project.
1. Drag and drop one of the four libraries into the group:
    
	 /Releases/libdUsefulStuff-device.a   
    /Releases/libdUsefulStuff-simulator.a   
    /Debug/libdUsefulStuff-device.a   
    /Debug/libdUsefulStuff-simulator.a   
 
    Don't forget to link not copy this.
1. Select all the .h header files and drag them into the group as well. 

# The library

## DCCommons.h

This header fine contains the following useful defines :

<table>
<tr>
<th> Define</th>
<th> Description</th>
</tr>
<tr>
<td> DC_LOG(template, ...) </td>
<td> Wraps NSLog and includes only the compiler flag DC_DEBUG is set.</td>
</tr>
<tr>
<td> DC_DEALLOC(name) </td>
<td> Cleanly releases pointers and set 's then to point at nil. Also will log various info to
	NSLog if DC_LOG_DEALLOC is set as a compiler flag.</td>
</tr>
<tr>
	<td>DC_PRETTY_BOOL(boolean)</td>
	<td>Outputs either the string "YES" or "NO". Useful for logging.</td>
</tr>
<tr>
	<td>DC_DATA_TO_STRING(data)</td>
	<td>Returns a NSString * from the passed NSData *.</td>
</tr>
<tr>
	<td>DC_STRING_TO_DATA(string)</td>
	<td>Returns a NSData * from the passed NSString *.</td>
</tr>
<tr>
	<td>DC_MOCK_VALUE(variable)</td>
	<td>An update to the OCMOCK_VALUE define. Works better with iPhone code.</td>
</tr>
</table>

## DCUIRating

This class can be used on iPhone displays to produce a star rating control similar to what you can see in Tunes. It produces a single horizontal bar of 5 images across the display. The user can tap or swipe across the bar to set the rating value they want.

It's core features include :

* 3 scales : 0 - 5, 0 - 5 with half values, and 0 - 10.
* Provided star images but can be configured with any images you like.
* Resizes itself to match the width and height of the supplied images.
* Can optionally add n pixels of padding between images.

## NSDictionary + dUsefulStuff and NSMutableDictionary + dUsefulStuff

These two are categories which allow you to store adn retrieve dictionary entries based on the integer primitive.This saves having to do constant boxing and unboxing of values when you want to index based on a number .

