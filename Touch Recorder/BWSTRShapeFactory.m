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
#import "BWSTRSquare.h"

#import "BWSTRShapeFactory.h"

@implementation BWSTRShapeFactory

+ (BWSTRShape *)shapeWithShapeName:(BWSTRShapeName)shapeName
{
	return ([self shapeWithShapeName:shapeName frame:CGRectZero]);
}

+ (BWSTRShape *)shapeWithShapeName:(BWSTRShapeName)shapeName frame:(CGRect)frame
{
	switch (shapeName) {
		case kBWSTRShapeCircle:
			return ([[BWSTRCircle alloc] initWithFrame:frame]);
		case kBWSTRShapeSquare:
			return ([[BWSTRSquare alloc] initWithFrame:frame]);
		case kBWSTRShapeCount:
			NSAssert(YES == NO, @"Cannot instantate a shape with kBWSTRShapeCount");
			/* Not reached */
			return (nil);
	}
}

@end
