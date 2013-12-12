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
#import "BWSTRRectangular.h"
#import "BWSTRDDLog.h"
#import "BWSTRConstants.h"
#import "BWSTRTest.h"
#import "BWSTRTestProperties.h"
#import "BWSTRNewTestViewController.h"

#import "NSMutableArray+BWSTRUtilities.h"
#import "UIView+Quadrants.h"
#import "BWSTRViewController.h"

@interface BWSTRViewController ()

@property (nonatomic, strong) NSArray *quadrants;
@property (nonatomic, strong) UITapGestureRecognizer *backgroundTapRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *nextButtonTapRecognizer;
@property (nonatomic, strong) BWSTRTestProperties *testProperties;
@property (nonatomic, strong) BWSTRTest *test;
//@property (nonatomic, assign, readonly) double sessionStartTime; //in milliseconds

@end

static int ddLogLevel;

@implementation BWSTRViewController

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	/* Setup notifications listeners */
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testPropertiesUpdated:) name:kBWSTRNotificationTestPropertiesSet object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testFinished:) name:kBWSTRNotificationTestFinished object:nil];
	
	/* Setup gesture recognizers */
	if (self.backgroundTapRecognizer == nil) {
		self.backgroundTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapRecognized:)];
		[self.backgroundTapRecognizer setCancelsTouchesInView:NO];
	}
	[self.view addGestureRecognizer:self.backgroundTapRecognizer];
	if (self.nextButtonTapRecognizer == nil) {
		self.nextButtonTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtonTapRecognized:)];
		[self.nextButtonTapRecognizer setCancelsTouchesInView:NO];
	}
	[self.nextButton addGestureRecognizer:self.nextButtonTapRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated
{
	/* Tear down notification listeners */
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kBWSTRNotificationTestPropertiesSet object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kBWSTRNotificationTestFinished object:nil];
	
	/* Tear down gesture recognizers */
	[self.view removeGestureRecognizer:self.backgroundTapRecognizer];
	[self.nextButton removeGestureRecognizer:self.nextButtonTapRecognizer];
	
	[super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self obtainTestProperties];
}

#pragma mark - Tap Detection

- (void)backgroundTapRecognized:(UITapGestureRecognizer *)recognizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kBWSTRNotificationShapeMiss object:nil];
    
	//DDLogBWSTRTouch(@"Local: %@, Global: %@, Hit: No", NSStringFromCGPoint([recognizer locationInView:self.nextButton]), NSStringFromCGPoint([recognizer locationInView:self.view]));
    
}

- (void)nextButtonTapRecognized:(UITapGestureRecognizer *)recognizer
{
	//DDLogBWSTRTouch(@"Local: %@, Global: %@, Hit: NEXT", NSStringFromCGPoint([recognizer locationInView:self.nextButton]), NSStringFromCGPoint([recognizer locationInView:self.view]));
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
		return;
	
	[shape setBackgroundColor:[BWSTRConstants colorForBWSTRColor:self.testProperties.shapeBackgroundColor]];
	[shape setForegroundColor:[BWSTRConstants colorForBWSTRColor:self.testProperties.shapeForegroundColor]];
	
	CGRect quadrant = [[self.quadrants objectAtIndex:quadrantNumber - 1] CGRectValue];
    //Kayee - If it is rectangular need to change dimension
    if (self.testProperties.shapeName == kBWSTRShapeRectangular)
        [shape setFrame:CGRectMake(quadrant.origin.x, quadrant.origin.y, self.testProperties.shapeSize + 40 , self.testProperties.shapeSize)];
    else
        [shape setFrame:CGRectMake(quadrant.origin.x, quadrant.origin.y, self.testProperties.shapeSize, self.testProperties.shapeSize)];
	[shape setCenter:CGPointMake(CGRectGetMidX(quadrant), CGRectGetMidY(quadrant))];
	[shape setNeedsDisplay];
	[self.view addSubview:shape];
}

#pragma mark - Interface Element Actions

- (IBAction)nextButtonPressed:(id)sender
{
    self.sessionStartTime = [[NSDate date] timeIntervalSince1970] * 1000;
    
	[self.test nextShape];
}

#pragma mark - Notification Handlers

- (void)testPropertiesUpdated:(NSNotification *)notification
{
	self.testProperties = [notification.userInfo objectForKey:kBWSTRNotificationTestPropertiesSetTestPropertiesKey];
	if (self.testProperties == nil) {
		DDLogBWSTRVerbose(@"%@", @"testProperties is nil, not starting evaluation");
		return;
	}
	
	/* Set the background color while we're here, so it's not jarring */
	[self.view setBackgroundColor:[BWSTRConstants colorForBWSTRColor: self.testProperties.shapeBackgroundColor]];
	
	/* Update the number of quadrants */
	self.quadrants = [self.view quadrantsWithNumberOfRows:self.testProperties.numberOfRows columns:self.testProperties.numberOfColumns];
	
	/* Start the evaluation */
	self.test = [[BWSTRTest alloc] initWithTestProperties:self.testProperties inTestViewController:self];
    
	[self.test start];
}

- (void)testFinished:(NSNotification *)notification
{
	[self obtainTestProperties];
}

#pragma mark - Test properties

- (void)obtainTestProperties
{
	if (self.test == nil || self.test.inProgress == NO) {
		BWSTRNewTestViewController *ntvc = [[BWSTRNewTestViewController alloc] initWithNibName:kBWSTRNewTestView bundle:nil];
		[ntvc setModalPresentationStyle:UIModalPresentationFormSheet];
		[ntvc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
		[self presentViewController:ntvc animated:YES completion:NULL];
	}
}

-(void) dealloc
{
    /* kayee */
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBWSTRNotificationShapeMiss object:nil];
}

@end
