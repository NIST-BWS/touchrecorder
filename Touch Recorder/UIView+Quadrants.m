/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

#import "UIView+Quadrants.h"

@implementation UIView (Quadrants)

- (NSArray *)quadrantsWithNumberOfRows:(NSUInteger)rows columns:(NSUInteger)columns
{
	CGRect wholeFrame = self.frame;
	NSUInteger widthOfQuadrant = CGRectGetWidth(wholeFrame) / columns;
	NSUInteger heightOfQuadrant = CGRectGetHeight(wholeFrame) / rows;
	NSUInteger minX = CGRectGetMinX(wholeFrame);
	NSUInteger minY = CGRectGetMinY(wholeFrame);
	
	NSMutableArray *quadrants = [[NSMutableArray alloc] initWithCapacity:(rows * columns)];
	for (NSUInteger row = 0; row < rows; row++)
		for (NSUInteger column = 0; column < columns; column++)
			[quadrants addObject:[NSValue valueWithCGRect:CGRectMake(minX + (column * widthOfQuadrant), minY + (row * heightOfQuadrant), widthOfQuadrant, heightOfQuadrant)]];
	
	return (quadrants);
}

@end
