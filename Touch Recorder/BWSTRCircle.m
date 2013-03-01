/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

#import "UIColor+BWSTRUtilities.h"


#import "BWSTRCircle.h"

@implementation BWSTRCircle

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGFloat red, green, blue, alpha;
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShouldAntialias(context, true);
	
	if ([self.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha])
		CGContextSetRGBFillColor(context, red, green, blue, alpha);
	else
		CGContextSetRGBFillColor(context, 1, 1, 1, 1);
	CGContextFillRect(context, rect);
		
	if ([self.foregroundColor getRed:&red green:&green blue:&blue alpha:&alpha]) {
		CGContextSetRGBFillColor(context, red, green, blue, alpha);
		CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
	} else {
		CGContextSetRGBFillColor(context, 1, 1, 1, 1);
		CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
	}
	CGContextAddEllipseInRect(context, rect);
	
	CGContextDrawPath(context, kCGPathFillStroke);
	
	/* Save this context to an image for location testing */
	self.backingImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
}


@end
