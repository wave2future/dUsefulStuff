//
//  RatingTestController.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCUIRating.h"
#import "DCUIRatingDelegate.h"


@interface RatingTestController : UIViewController<DCUIRatingDelegate> {
	
	@private
	DCUIRating * ratingWhole;
	DCUIRating * ratingHalf;
	DCUIRating * ratingDouble;
	UILabel * readOut;

}

@property (retain, nonatomic) IBOutlet UILabel * readOut;
@property (retain, nonatomic) IBOutlet DCUIRating * ratingWhole;
@property (retain, nonatomic) IBOutlet DCUIRating * ratingHalf;
@property (retain, nonatomic) IBOutlet DCUIRating * ratingDouble;

-(IBAction) alertButtonClicked: (id) button;
-(IBAction) alert2ButtonClicked: (id) button;
-(IBAction) busyIndicatorButtonClicked: (id) button;

@end
