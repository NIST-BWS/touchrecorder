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

#import "NSMutableArray+BWSTRUtilities.h"
#import "UIView+Quadrants.h"
#import "BWSTRViewController.h"

@interface BWSTRViewController ()

@property (nonatomic, strong) NSArray *quadrants;

@end

static int ddLogLevel;

@implementation BWSTRViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)]];
	
	self.rows = 4;
	self.columns = 3;
	self.shapeBackgroundColor = [UIColor whiteColor];
	self.shapeForegroundColor = [UIColor greenColor];
	self.shapeHeight = 50;
	self.shapeWidth = 50;
	
	for (NSUInteger row = 1; row <= self.rows; row++)
		for (NSUInteger column = 1; column <= self.columns; column++)
			[self insertShape:[[BWSTRSquare alloc] init] inRow:row column:column];
}

#pragma mark - Tap Detection

- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
{
	DDLogBWSTRTouch(@"Local: %@, Global: %@, Hit: No", NSStringFromCGPoint([recognizer locationInView:self.view]), NSStringFromCGPoint([recognizer locationInView:self.view]));
}

#pragma mark - Shape Insertion

- (void)insertShape:(BWSTRShape *)shape inRow:(NSUInteger)row column:(NSUInteger)column
{
	NSAssert(row <= self.rows, @"Invalid row (%u vs %u)", row, self.rows);
	NSAssert(column <= self.columns, @"Invalid column (%u vs %u)", column, self.columns);

	[self insertShape:shape inQuadrant:(((row - 1) * self.columns) + (column - 1) + 1)];
}

- (void)insertShape:(BWSTRShape *)shape inQuadrant:(NSUInteger)quadrantNumber
{
	NSAssert(quadrantNumber <= (self.rows * self.columns), @"Invalid quadrant (%u vs %u)", quadrantNumber, (self.rows * self.columns) - 1);
	if (self.quadrants == nil)
		self.quadrants = [self.view quadrantsWithNumberOfRows:self.rows columns:self.columns];
	
	[shape setBackgroundColor:self.shapeBackgroundColor];
	[shape setForegroundColor:self.shapeForegroundColor];
	
	CGRect quadrant = [[self.quadrants objectAtIndex:quadrantNumber - 1] CGRectValue];
	[shape setFrame:CGRectMake(quadrant.origin.x, quadrant.origin.y, self.shapeWidth, self.shapeHeight)];
	[shape setCenter:CGPointMake(CGRectGetMidX(quadrant), CGRectGetMidY(quadrant))];
	[self.view addSubview:shape];
}

@end
