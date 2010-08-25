//
//  BubbleView.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 19/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCUIRatingPopupBubble.h"
#import "DCCommon.h"


@implementation DCUIRatingPopupBubble

@dynamic value;

- (float) value {
	return value;
}

- (void) setValue:(float)aValue {
	value = aValue;
	if (decimalFormatter != nil) {
		rating.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
	} else {
		rating.text = [[NSNumber numberWithFloat:value] stringValue];
	}
}

- (DCUIRatingPopupBubble *) initWithImage:(UIImage *)backgroundImage font:(UIFont *)font textColour:(UIColor *)textColour xOffset:(int)xOffset yOffset:(int)yOffset displayAsDecimal:(BOOL)displayAsDecimal {
	self = [super initWithFrame:CGRectMake(0, -backgroundImage.size.height, backgroundImage.size.width, backgroundImage.size.height)];
	if (self) {
		DC_LOG(@"Creating bubble");
		width = backgroundImage.size.width;
		height = backgroundImage.size.height;
		background = [backgroundImage retain];
		self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
		self.hidden = YES;

		// Setup the label.
		rating = [[UILabel alloc] init];
		[self addSubview:rating];

		if (font != nil) {
			rating.font = font;
		}
		CGSize size = [@"8.8" sizeWithFont:rating.font];
		DC_LOG(@"font size %f", size.height);
		DC_LOG(@"label offsets x => %i y => %i", xOffset, yOffset);
		rating.frame = CGRectMake(0 + xOffset, 0 + yOffset, width, size.height);

		rating.backgroundColor = [UIColor clearColor];
		if (textColour != nil) {
			rating.textColor = textColour;
		}
		rating.textAlignment = UITextAlignmentCenter;

		// Setup the formatter for the rating.
		if (displayAsDecimal) {
			DC_LOG(@"Creating a decimal formatter for the bubble");
			decimalFormatter = [[NSNumberFormatter alloc] init];
			decimalFormatter.numberStyle = NSNumberFormatterDecimalStyle;
			decimalFormatter.minimumFractionDigits = 1;
		}
	}
	return self;
}

- (void) drawRect:(CGRect)rect {
	DC_LOG(@"Drawing bubble");
	[background drawInRect:CGRectMake(0, 0, width, height)];

}

- (void) moveToX:(int)x {
	DC_LOG(@"Moving bubble to %i", x);
	self.frame = CGRectMake(x, -height, width, height);
}


- (void) dealloc {
	DC_DEALLOC(background);
	[rating removeFromSuperview];
	DC_DEALLOC(rating);
	DC_DEALLOC(decimalFormatter);
	[super dealloc];
}


@end
