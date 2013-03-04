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

#import <Foundation/Foundation.h>

@interface BWSTRTestProperties : NSObject

@property (nonatomic, assign) NSUInteger shapeSize;
@property (nonatomic, assign) NSUInteger numberOfRows;
@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) NSUInteger numberOfTrials;
@property (nonatomic, assign) NSUInteger participantID;
@property (nonatomic, assign) BWSTRShapeName shapeName;
@property (nonatomic, assign) BWSTRDominantHand dominantHand;
@property (nonatomic, assign) BWSTRColor shapeForegroundColor;
@property (nonatomic, assign) BWSTRColor shapeBackgroundColor;

/** @return Verbose description */
- (NSString *)description;

/**
 * @return
 * CSV description in the format:
 * participaneID,domaintHand,numTrials,numRows,numCols,orientation,shape,size,foregroundColor,backgroundColor
 *  - where shapes and colors are defined by their enumerations in BWSTRConstants (0-based)
 *  - where orientation is 'L'andscape or 'P'ortrait.
 */
- (NSString *)csvDescription;

@end
