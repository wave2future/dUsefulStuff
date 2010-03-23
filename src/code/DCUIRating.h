//
//  DCUIRating.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>


@interface DCUIRating : UIControl {
	@private
	int maxValue;
}

@property (nonatomic) int maxValue;

@end
