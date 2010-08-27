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
 * Class which contains static dialog methods.
 */
@interface DCDialogs : NSObject {

}

/**
 * Displays a standard error notification on top of the specified component. The dialog will have a single "ok" button.
 * \param view The view to use as the parent object for the dialog.
 * \param message the error text to display.
 */
+ (void) displayErrorOnView:(UIView *)view message:(NSString *)msg;

/**
 * Displays a standard error notification on top of the specified component. The dialog will have a single "ok" button.
 * \param view The view to use as the parent object for the dialog.
 * \param message the error text to display.
 * \param title The title of the dialog.
 */
+ (void) displayErrorOnView:(UIView *)view message:(NSString *)msg title:(NSString *)title;
@end
