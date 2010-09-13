//
//  RatingTestController.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCUIRating.h"


@interface RatingTestController : UIViewController {
	
	@private
	DCUIRating * rating5;
	DCUIRating * rating5half;
	DCUIRating * rating10;

}

@property (retain, nonatomic) IBOutlet DCUIRating * rating5;
@property (retain, nonatomic) IBOutlet DCUIRating * rating5half;
@property (retain, nonatomic) IBOutlet DCUIRating * rating10;

-(IBAction) alertButtonClicked: (id) button;
-(IBAction) alert2ButtonClicked: (id) button;

@end
