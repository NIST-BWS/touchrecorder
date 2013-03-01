/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

#import "BWSTRCircle.h"

@implementation BWSTRCircle

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShouldAntialias(context, true);
	
	/* Background */
	CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
	CGContextFillRect(context, rect);
	
	/* Foreground */
	CGContextSetFillColorWithColor(context, [self.foregroundColor CGColor]);
	CGContextSetStrokeColorWithColor(context, [self.foregroundColor CGColor]);
	CGContextAddEllipseInRect(context, rect);
	
	CGContextDrawPath(context, kCGPathFillStroke);
	
	/* Save this context to an image for location testing */
	self.backingImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
}

@end
