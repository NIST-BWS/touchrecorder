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
#import "BWSTRShapeFactory.h"
#import "BWSTRViewController.h"
#import "NSMutableArray+BWSTRUtilities.h"

#import "BWSTRTest.h"

static int ddLogLevel;

@interface BWSTRTest ()

/** Order in which shapes appear in quadrants */
@property (nonatomic, strong, readonly) NSArray *quadrantOrder;
/** View controller in which to draw shapes */
@property (nonatomic, assign, readonly) BWSTRViewController *testViewController;
/** Shared shape object */
@property (nonatomic, strong, readonly) BWSTRShape *shape;

@end

@implementation BWSTRTest

- (BWSTRTest *)initWithTestProperties:(BWSTRTestProperties *)testProperties inTestViewController:(BWSTRViewController *)testViewController
{
	self = [super init];
	if (self == nil)
		return (nil);
	
	if (testProperties == nil)
		return (nil);
	_testProperties = testProperties;
	
	if (testViewController == nil)
		return (nil);
	_testViewController = testViewController;
	
	_inProgress = NO;
	_iteration = 0;
	
	/* Initialize the shape object */
	_shape = [BWSTRShapeFactory shapeWithShapeName:self.testProperties.shapeName
						 frame:CGRectMake(0, 0, self.testProperties.shapeSize, self.testProperties.shapeSize)];
	[_shape setForegroundColor:self.testProperties.shapeForegroundColor];
	[_shape setBackgroundColor:self.testProperties.shapeBackgroundColor];
	
	/* Make the view controller background color match the shape background color */
	[_testViewController.view setBackgroundColor:self.testProperties.shapeBackgroundColor];
	
	/* Listen for hitting shapes */
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shapeHit:) name:kBWSTRNotificationShapeHit object:nil];
	
	return (self);
}

#pragma mark - Test Lifecycle

- (void)start
{
	/* Don't allow restarts */
	if ([self inProgress])
		return;
	
	_inProgress = YES;
	_iteration = 0;
	
	[self randomizeQuadrants];
	
	DDLogBWSTRVerbose(@"%@", @"--------------------------------------------------------------------------------");
	DDLogBWSTRVerbose(@"%@", [self.testProperties description]);
	
	[[self.testViewController nextButton] setHidden:NO];
	[[self.testViewController nextButton] setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
}

- (void)nextShape
{
	_iteration++;
	
	if (_iteration > self.testProperties.numberOfTrials) {
		[self testComplete];
		return;
	}
	
	/* Hide the next button */
	[[self.testViewController nextButton] setHidden:YES];
	
	/* Show a shape */
	NSNumber *nextQuadrant = self.quadrantOrder[_iteration - 1];
	DDLogBWSTRVerbose(@"Displaying %@ in quadrant %u", [BWSTRConstants stringForShapeName:self.testProperties.shapeName], [nextQuadrant unsignedIntegerValue]);
	if (_iteration != 1)
		[self.shape removeFromSuperview];
	[self.testViewController insertShape:self.shape inQuadrant:[nextQuadrant unsignedIntegerValue]];
}

- (void)testComplete
{
	DDLogBWSTRVerbose(@"%@", @"Test has completed");
	DDLogBWSTRVerbose(@"%@", @"--------------------------------------------------------------------------------");
	DDLogBWSTRVerbose(@"%@", @"--------------------------------------------------------------------------------");
	
	_inProgress = NO;
	[[self.testViewController nextButton] setHidden:NO];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kBWSTRNotificationTestFinished object:nil];	
}

#pragma mark - Notifications

- (void)shapeHit:(NSNotification *)notificaiton
{
	/* Hide the shape */
	[self.shape removeFromSuperview];
	
	/* Show the next button */
	[[self.testViewController nextButton] setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
	[[self.testViewController nextButton] setHidden:NO];
}

#pragma mark - Test Mechanics

- (void)randomizeQuadrants
{
	/* Create an numberOfTrials sized array filling all the quadrants */
	NSArray *quadrants = [NSMutableArray numberArrayWithStartingNumber:1 endingNumber:(self.testProperties.numberOfColumns * self.testProperties.numberOfRows)];
	NSMutableArray *randomization = [[NSMutableArray alloc] initWithCapacity:self.testProperties.numberOfTrials];
	for (NSUInteger i = 0; i < self.testProperties.numberOfTrials / [quadrants count]; i++)
		[randomization addObjectsFromArray:quadrants];

	_quadrantOrder = [[NSArray alloc] initWithArray:[randomization shuffle]];
}

#pragma mark - Destruction

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kBWSTRNotificationShapeHit object:nil];
}

@end
