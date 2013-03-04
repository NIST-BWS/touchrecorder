/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

@class BWSTRViewController;

#import "BWSTRTestProperties.h"

#import <Foundation/Foundation.h>

@interface BWSTRTest : NSObject

/** 1-based index of the trial being conducted. */
@property (nonatomic, assign, readonly) NSUInteger iteration;
@property (nonatomic, assign, readonly) NSUInteger inProgress;
@property (nonatomic, strong, readonly) BWSTRTestProperties *testProperties;

- (BWSTRTest *)initWithTestProperties:(BWSTRTestProperties *)testProperties inTestViewController:(BWSTRViewController *)testViewController;

- (void)start;
- (void)nextShape;

@end
