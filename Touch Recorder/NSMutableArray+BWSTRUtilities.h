/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

#import <Foundation/Foundation.h>

@interface NSMutableArray (BWSTRUtilities)

+ (NSMutableArray *)numberArrayWithStartingNumber:(NSInteger)startingNumber endingNumber:(NSInteger)endingNumber;
+ (NSMutableArray *)numberArrayWithStartingNumber:(NSInteger)startingNumber increment:(NSUInteger)increment iterations:(NSUInteger)iterations;

/**
 * @brief
 * Shuffle the indicies of an array in place.
 *
 * @return Pointer to shuffled array.
 */
- (NSMutableArray *)shuffle;

@end
