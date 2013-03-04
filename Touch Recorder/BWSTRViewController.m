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
#import "BWSTRDDLog.h"
#import "BWSTRConstants.h"
#import "BWSTRTestProperties.h"
#import "BWSTRNewTestViewController.h"

#import "NSMutableArray+BWSTRUtilities.h"
#import "UIView+Quadrants.h"
#import "BWSTRViewController.h"

@interface BWSTRViewController ()

@property (nonatomic, strong) NSArray *quadrants;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) BWSTRTestProperties *testProperties;

@end

static int ddLogLevel;

@implementation BWSTRViewController

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	/* Setup notifications listeners */
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shapeHit:) name:kBWSTRNotificationShapeHit object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testPropertiesUpdated:) name:kBWSTRNotificationTestPropertiesSet object:nil];
	
	/* Setup gesture recognizers */
	if (self.tapGestureRecognizer == nil)
		self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
	[self.view addGestureRecognizer:self.tapGestureRecognizer];
	
	_testInProgress = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
	/* Tear down notification listeners */
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kBWSTRNotificationShapeHit object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kBWSTRNotificationTestPropertiesSet object:nil];
	
	/* Tear down gesture recognizers */
	[self.view removeGestureRecognizer:self.tapGestureRecognizer];
	
	[super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self obtainTestProperties];
}

#pragma mark - Tap Detection

- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
{
	DDLogBWSTRTouch(@"Local: %@, Global: %@, Hit: No", NSStringFromCGPoint([recognizer locationInView:self.view]), NSStringFromCGPoint([recognizer locationInView:self.view]));
}

#pragma mark - Shape Insertion

- (void)insertShape:(BWSTRShape *)shape inRow:(NSUInteger)row column:(NSUInteger)column
{
	NSAssert(row <= self.testProperties.numberOfRows, @"Invalid row (%u vs %u)", row, self.testProperties.numberOfRows);
	NSAssert(column <= self.testProperties.numberOfColumns, @"Invalid column (%u vs %u)", column, self.testProperties.numberOfColumns);

	[self insertShape:shape inQuadrant:(((row - 1) * self.testProperties.numberOfColumns) + (column - 1) + 1)];
}

- (void)insertShape:(BWSTRShape *)shape inQuadrant:(NSUInteger)quadrantNumber
{
	NSAssert(quadrantNumber <= (self.testProperties.numberOfRows * self.testProperties.numberOfColumns), @"Invalid quadrant (%u vs %u)", quadrantNumber, (self.testProperties.numberOfRows * self.testProperties.numberOfColumns) - 1);
	if (self.quadrants == nil)
		self.quadrants = [self.view quadrantsWithNumberOfRows:self.testProperties.numberOfRows columns:self.testProperties.numberOfColumns];
	
	[shape setBackgroundColor:self.testProperties.shapeBackgroundColor];
	[shape setForegroundColor:self.testProperties.shapeForegroundColor];
	
	CGRect quadrant = [[self.quadrants objectAtIndex:quadrantNumber - 1] CGRectValue];
	[shape setFrame:CGRectMake(quadrant.origin.x, quadrant.origin.y, self.testProperties.shapeSize, self.testProperties.shapeSize)];
	[shape setCenter:CGPointMake(CGRectGetMidX(quadrant), CGRectGetMidY(quadrant))];
	[shape setNeedsDisplay];
	[self.view addSubview:shape];
}

#pragma mark - Interface Element Actions

- (IBAction)nextButtonPressed:(id)sender
{
	
}

#pragma mark - Notification Handlers

- (void)shapeHit:(NSNotification *)notification
{

}

- (void)testPropertiesUpdated:(NSNotification *)notification
{
	self.testProperties = [notification.userInfo objectForKey:kBWSTRNotificationTestPropertiesSetTestPropertiesKey];
	if (self.testProperties == nil) {
		DDLogBWSTRVerbose(@"%@", @"testProperties is nil, not starting evaluation");
		return;
	}
	
	/* Start the evaluation */
}

#pragma mark - Test properties

- (void)obtainTestProperties
{
	if (!self.testInProgress) {
		BWSTRNewTestViewController *ntvc = [[BWSTRNewTestViewController alloc] initWithNibName:kBWSTRNewTestView bundle:nil];
		[ntvc setModalPresentationStyle:UIModalPresentationFormSheet];
		[ntvc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
		[self presentViewController:ntvc animated:YES completion:NULL];
	}
}

@end
