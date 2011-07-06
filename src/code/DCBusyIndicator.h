//
//  BusyIndicator.h
//  dBank
//
//  Created by Derek Clarkson on 22/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 DCBusyIndicator is a view which overlays itself on the specified view. Often the main window or view. It is tinted black at 50% and has abusy indicator in the middle.
 It can be used by the DCBackgrondTask.
 */
@interface DCBusyIndicator : UIView {
@private 
	UIView *superView;
	UIActivityIndicatorView *busy;
	UILabel *label;
	CGFloat transparency;
}

/**
 A message to display below the activity indicator. keep it short is best.
 */
@property (retain, nonatomic) NSString *message;

/**
 How transparent to make the background color. 1 = opaque, 0 = 100% transparent.
 */
@property (nonatomic) CGFloat transparency;
/**
 * Default constructor. Better to use the static method if possible.
 */
- (id) initWithSuperview:(UIView *)aSuperView;

/**
 Called on the main thread by BackgroundTask to add the busy indicator view to the display.
 */
- (void) activate;

/**
 Called on the main thread by BackgroundTask to remove the busy indicator view from the display.
 */
- (void) deactivate;

@end
