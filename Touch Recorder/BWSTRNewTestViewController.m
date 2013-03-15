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
#import "BWSTRShapeFactory.h"
#import "BWSTRTestProperties.h"
#import "BWSTRViewController.h"

#import "BWSTRNewTestViewController.h"

@interface BWSTRNewTestViewController ()

/** 
 * @brief
 * Validate form fields.
 * 
 * @return
 *	Error messages dealing with invalid fields or nil if there are no
 *	errors.
 */
- (NSString *)validate;

/** List of allowed shapes. */
@property (nonatomic, strong) NSArray *possibleShapes;
/** List of allowed colors. */
@property (nonatomic, strong) NSArray *possibleColors;

typedef NS_ENUM(NSUInteger, kBWSTRShapePickerViewSections)
{
	kBWSTRShapePickerViewSectionShape,
	kBWSTRShapePickerViewSectionForegroundColor,
	kBWSTRShapePickerViewSectionBackgroundColor,
	
	kBWSTRShapePickerViewSectionCount
};

@end

@implementation BWSTRNewTestViewController

#pragma mark - PickerView Data Source

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	switch (component) {
		case kBWSTRShapePickerViewSectionShape:
			return ([self.possibleShapes count]);
		case kBWSTRShapePickerViewSectionForegroundColor:
			/* FALLTHROUGH */
		case kBWSTRShapePickerViewSectionBackgroundColor:
			return ([self.possibleColors count]);
		default:
			return (0);
	}
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return (kBWSTRShapePickerViewSectionCount);
}

#pragma mark - PickerView Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
	switch (component) {
		case kBWSTRShapePickerViewSectionShape: {
			BWSTRShape *shape = [BWSTRShapeFactory shapeWithShapeName:row frame:CGRectMake(0, 0, 30, 30)];
			shape.foregroundColor = [BWSTRConstants colorForBWSTRColor:[pickerView selectedRowInComponent:kBWSTRShapePickerViewSectionForegroundColor]];
			shape.backgroundColor = [BWSTRConstants colorForBWSTRColor:[pickerView selectedRowInComponent:kBWSTRShapePickerViewSectionBackgroundColor]];
			UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
			[shape setCenter:CGPointMake(CGRectGetMidX(containerView.frame), CGRectGetMidY(containerView.frame))];
			containerView.backgroundColor = shape.backgroundColor;
			[containerView addSubview:shape];
			return (containerView);
		}
		case kBWSTRShapePickerViewSectionForegroundColor:
			/* FALLTHROUGH */
		case kBWSTRShapePickerViewSectionBackgroundColor:
			if (view == nil)
				view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
			[view setBackgroundColor:[BWSTRConstants colorForBWSTRColor:row]];
			return (view);
		default:
			return (nil);
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	switch (component) {
		case kBWSTRShapePickerViewSectionForegroundColor:
			/* FALLTHROUGH */
		case kBWSTRShapePickerViewSectionBackgroundColor:
			[pickerView reloadComponent:kBWSTRShapePickerViewSectionShape];
			break;
	}
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	/* Initialize picker view backing storage */
	NSMutableArray *shapes = [[NSMutableArray alloc] initWithCapacity:kBWSTRShapeCount];
	for (NSUInteger i = 0; i < kBWSTRShapeCount; i++)
		[shapes addObject:[BWSTRConstants stringForShapeName:i]];
	self.possibleShapes = [[NSArray alloc] initWithArray:shapes];
		
	NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:kBWSTRColorCount];
	for (NSUInteger i = 0; i < kBWSTRColorCount; i++)
		[colors addObject:[BWSTRConstants attributedStringForColor:i]];
	self.possibleColors = [[NSArray alloc] initWithArray:colors];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	/* Redraw the shapes with color */
	[self.shapePicker selectRow:2 inComponent:kBWSTRShapePickerViewSectionForegroundColor animated:NO];
	[self.shapePicker reloadComponent:kBWSTRShapePickerViewSectionShape];
}

#pragma mark - Actions

- (IBAction)startButtonPressed:(id)sender
{	
	NSString *resultString = [self validate];
	if (resultString != nil) {
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
					    message:resultString
					   delegate:nil
				  cancelButtonTitle:NSLocalizedString(@"Okay", nil)
				  otherButtonTitles:nil]
		 show];
		return;
	}
	
	BWSTRTestProperties *testProperties = [[BWSTRTestProperties alloc] init];
	testProperties.numberOfRows = [self.rowsField.text integerValue];
	testProperties.numberOfColumns = [self.columnsField.text integerValue];
	testProperties.numberOfTrials = [self.numberOfTrialsField.text integerValue];
	testProperties.participantID = [self.participantIDField.text integerValue];
	testProperties.dominantHand = self.dominantHand.selectedSegmentIndex;
	testProperties.shapeSize = [self.shapeSizeField.text integerValue];
	testProperties.shapeName = [self.shapePicker selectedRowInComponent:kBWSTRShapePickerViewSectionShape];
	testProperties.shapeBackgroundColor = [self.shapePicker selectedRowInComponent:kBWSTRShapePickerViewSectionBackgroundColor];
	testProperties.shapeForegroundColor = [self.shapePicker selectedRowInComponent:kBWSTRShapePickerViewSectionForegroundColor];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kBWSTRNotificationTestPropertiesSet
							    object:self
							  userInfo:@{kBWSTRNotificationTestPropertiesSetTestPropertiesKey : testProperties}];
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)validate
{
	if ([self.participantIDField.text isEqualToString:@""] || [self.participantIDField.text integerValue] <= 0)
		return (NSLocalizedString(@"Participant ID is <= 0.", nil));
	if ([self.numberOfTrialsField.text isEqualToString:@""] || [self.numberOfTrialsField.text integerValue] <= 0)
		return (NSLocalizedString(@"Number of trials is <= 0.", nil));
	if ([self.rowsField.text isEqualToString:@""] || [self.rowsField.text integerValue] <= 0)
		return (NSLocalizedString(@"Number of rows is <= 0.", nil));
	if ([self.columnsField.text isEqualToString:@""] || [self.columnsField.text integerValue] <= 0)
		return (NSLocalizedString(@"Number of columns is <= 0.", nil));
	if ([self.shapeSizeField.text isEqualToString:@""] || [self.shapeSizeField.text integerValue] <= 0)
		return (NSLocalizedString(@"Shape size is 0.", nil));
	
	if ((([self.rowsField.text integerValue] * [self.columnsField.text integerValue]) % [self.numberOfTrialsField.text integerValue]) != 0)
	      return (NSLocalizedString(@"Number of trials must be a multiple of the number of quadrants.", nil));
	
	if ([self.shapePicker selectedRowInComponent:kBWSTRShapePickerViewSectionBackgroundColor] == [self.shapePicker selectedRowInComponent:kBWSTRShapePickerViewSectionForegroundColor])
		return (NSLocalizedString(@"Foreground and background colors are the same", nil));
	
	return (nil);
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[textField setText:[[NSNumber numberWithInteger:[textField.text integerValue]] stringValue]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[textField setText:[[NSNumber numberWithInteger:[textField.text integerValue]] stringValue]];
}

@end
