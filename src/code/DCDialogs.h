//
//  DCDialogs.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 25/08/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

/**
 Class which contains static dialog methods.
 */
@interface DCDialogs : NSObject {

}

/** @name Alerts */

/**
 Displays a standard error notification. The dialog will have a single "ok" button.

 @param msg the error text to display.
 */
+ (void) displayMessage:(NSString *)msg;

/**
 Displays a standard error notification. The dialog will have a single "ok" button.
 
 @param msg the error text to display.
 @param title The title of the dialog.
 */
+ (void) displayMessage:(NSString *)msg title:(NSString *)title;
@end
