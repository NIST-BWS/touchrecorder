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
#import "BWSTRShape.h"

#import <Foundation/Foundation.h>

@interface BWSTRShapeFactory : NSObject

/** @return Shape with zero rect frame. */
+ (BWSTRShape *)shapeWithShapeName:(BWSTRShapeName)shapeName;
/** @return Shape with frame. */
+ (BWSTRShape *)shapeWithShapeName:(BWSTRShapeName)shapeName frame:(CGRect)frame;


@end
