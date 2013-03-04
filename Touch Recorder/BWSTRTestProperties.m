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

#import "BWSTRTestProperties.h"

@implementation BWSTRTestProperties


- (NSString *)description
{
	NSMutableString *ret = [[NSMutableString alloc] initWithString:@"\n"];
	
	[ret appendFormat:@"%@:\t\t%u\n", NSLocalizedString(@"Participant ID", nil), self.participantID];
	[ret appendFormat:@"%@:\t\t%@\n", NSLocalizedString(@"Dominant Hand", nil), [BWSTRConstants stringForDominantHand:self.dominantHand]];
	[ret appendFormat:@"%@:\t%u\n", NSLocalizedString(@"Number of Trials", nil), self.numberOfTrials];
	[ret appendFormat:@"%@:\t\t%u\n", NSLocalizedString(@"Number of Rows", nil), self.numberOfRows];
	[ret appendFormat:@"%@:\t%u\n", NSLocalizedString(@"Number of Columns", nil), self.numberOfColumns];
	[ret appendFormat:@"%@:\t%@\n", NSLocalizedString(@"Device Orientation", nil),
	 UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? NSLocalizedString(@"Landscape", nil) : NSLocalizedString(@"Portrait", nil)];
	[ret appendFormat:@"%@:\t\t\t\t%@\n", NSLocalizedString(@"Shape", nil), [BWSTRConstants stringForShapeName:self.shapeName]];
	[ret appendFormat:@"%@:\t%u\n", NSLocalizedString(@"Number of Columns", nil), self.shapeSize];
	[ret appendFormat:@"%@:\t\t%@\n", NSLocalizedString(@"Shape Color", nil), [BWSTRConstants stringForColor:self.shapeForegroundColor]];
	[ret appendFormat:@"%@:\t%@\n", NSLocalizedString(@"Background Color", nil), [BWSTRConstants stringForColor:self.shapeBackgroundColor]];
	
	return (ret);
}

- (NSString *)csvDescription
{
	NSMutableString *ret = [[NSMutableString alloc] init];
	
	[ret appendFormat:@"%u,", self.participantID];
	[ret appendFormat:@"%u,", self.dominantHand];
	[ret appendFormat:@"%u,", self.numberOfTrials];
	[ret appendFormat:@"%u,", self.numberOfRows];
	[ret appendFormat:@"%u,", self.numberOfColumns];
	[ret appendFormat:@"%c,", UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? 'L' : 'P'];
	[ret appendFormat:@"%u", self.shapeName];
	[ret appendFormat:@"%u,", self.shapeSize];
	[ret appendFormat:@"%u,", self.shapeForegroundColor];
	[ret appendFormat:@"%u", self.shapeBackgroundColor];
	
	return (ret);
}

@end
