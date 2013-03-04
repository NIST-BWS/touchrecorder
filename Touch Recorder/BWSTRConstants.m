/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

#import "BWSTRConstants.h"

@implementation BWSTRConstants

+ (NSString *)stringForShapeName:(BWSTRShapeName)shapeName
{
	switch (shapeName) {
		case kBWSTRShapeCircle:
			return (NSLocalizedString(@"Circle", nil));
		case kBWSTRShapeSquare:
			return (NSLocalizedString(@"Square", nil));
			
		case kBWSTRShapeCount:
			NSAssert(YES == NO, @"Cannot use kBWSTRShapeCount as a shape");
			/* Not reached */
			return (@"");
	}
}

+ (NSString *)stringForDominantHand:(BWSTRDominantHand)dominantHand
{
	switch (dominantHand) {
		case kBWSTRDominantHandLeft:
			return (NSLocalizedString(@"Left", nil));
		case kBWSTRDominantHandRight:
			return (NSLocalizedString(@"Right", nil));
		case kBWSTRDominantHandBoth:
			return (NSLocalizedString(@"Ambidextrous", nil));
	}
}

+ (NSString *)stringForColor:(BWSTRColor)color
{
	switch (color) {
		case kBWSTRColorBlack:
			return (NSLocalizedString(@"Black", nil));
		case kBWSTRColorBlue:
			return (NSLocalizedString(@"Blue", nil));
		case kBWSTRColorGreen:
			return (NSLocalizedString(@"Green", nil));
		case kBWSTRColorRed:
			return (NSLocalizedString(@"Red", nil));
		case kBWSTRColorWhite:
			return (NSLocalizedString(@"White", nil));
		case kBWSTRColorYellow:
			return (NSLocalizedString(@"Yellow", nil));
		case kBWSTRColorCount:
			NSAssert(YES == NO, @"Cannot use kBWSTRColorCount as a color");
			/* Not reached */
			return (@"");
	}
}

+ (UIColor *)colorForBWSTRColor:(BWSTRColor)color
{
	switch (color) {
		case kBWSTRColorBlack:
			return ([UIColor blackColor]);
		case kBWSTRColorBlue:
			return ([UIColor blueColor]);
		case kBWSTRColorGreen:
			return ([UIColor greenColor]);
		case kBWSTRColorRed:
			return ([UIColor redColor]);
		case kBWSTRColorWhite:
			return ([UIColor whiteColor]);
		case kBWSTRColorYellow:
			return ([UIColor yellowColor]);
		case kBWSTRColorCount:
			NSAssert(YES == NO, @"Cannot use kBWSTRColorCount as a color");
			/* Not reached */
			return (nil);
	}
}

+ (NSAttributedString *)attributedStringForColor:(BWSTRColor)color
{
	/* TODO: This might be cheating. */
	NSMutableAttributedString *colorString = [[NSMutableAttributedString alloc] initWithString:@"XXXXXXXXXXXXXXXX"];
	[colorString addAttribute:NSForegroundColorAttributeName value:[BWSTRConstants colorForBWSTRColor:color] range:NSMakeRange(0, [[colorString string] length])];
	[colorString addAttribute:NSBackgroundColorAttributeName value:[BWSTRConstants colorForBWSTRColor:color] range:NSMakeRange(0, [[colorString string] length])];
	return (colorString);
}

@end
