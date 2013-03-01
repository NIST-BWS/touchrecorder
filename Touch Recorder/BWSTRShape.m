/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

#import "BWSTRDDLog.h"

#import "BWSTRShape.h"

@implementation BWSTRShape

static int ddLogLevel;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return (nil);
	
	/* Configure gesture recognizer */
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
	[self addGestureRecognizer:tapRecognizer];
	
	return (self);
}

#pragma mark - Tap Handling

- (BOOL)touchedWithinShapeWithTouch:(CGPoint)touchPoint
{
	return (CGColorEqualToColor([self.foregroundColor CGColor], [[self colorAtPoint:touchPoint] CGColor]) == true ? YES : NO);
}

- (UIColor *)colorAtPoint:(CGPoint)point
{
	/* Inspired by http://stackoverflow.com/a/3763313/277718 */
	BWSTRRGBPixel pixel = {0, 0, 0, 0};
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(&pixel, 1, 1, 8, sizeof(BWSTRRGBPixel), colorspace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	UIGraphicsPushContext(context);
	[self.backingImage drawAtPoint:CGPointMake(-point.x, -point.y)];
	UIGraphicsPopContext();
	CGContextRelease(context);
	CGColorSpaceRelease(colorspace);
	
	return ([UIColor colorWithRed:(pixel.red / 255.0) green:(pixel.green / 255.0) blue:(pixel.blue / 255.0) alpha:(pixel.alpha / 255.0)]);
}

- (void)tapped:(UITapGestureRecognizer *)tapRecognizer
{
	BOOL tappedWithin = [self touchedWithinShapeWithTouch:[tapRecognizer locationInView:self]];
	DDLogBWSTRTouchLGHM([tapRecognizer locationInView:self], tappedWithin);
}

@end
