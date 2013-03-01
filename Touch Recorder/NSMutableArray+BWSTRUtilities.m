/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

#import "NSMutableArray+BWSTRUtilities.h"

@implementation NSMutableArray (BWSTRUtilities)

- (void)shuffle
{
	NSUInteger count = [self count];
	for (NSUInteger i = 0; i < count; i++)
		[self exchangeObjectAtIndex:i withObjectAtIndex:(arc4random() % (count - i)) + i];
}

+ (NSMutableArray *)numberArrayWithStartingNumber:(NSInteger)startingNumber endingNumber:(NSInteger)endingNumber;
{
	NSAssert(startingNumber <= endingNumber, @"Starting number (%d) is greater than ending number (%d)", startingNumber, endingNumber);
	return ([NSMutableArray numberArrayWithStartingNumber:startingNumber increment:1 iterations:(endingNumber - startingNumber + 1)]);
}

+ (NSMutableArray *)numberArrayWithStartingNumber:(NSInteger)startingNumber increment:(NSUInteger)increment iterations:(NSUInteger)iterations
{
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:increment];
	
	NSInteger value = startingNumber;
	for (NSUInteger i = 0; i < iterations; i++, value += increment)
		[array insertObject:@(value) atIndex:i];
	
	return (array);
}

@end
