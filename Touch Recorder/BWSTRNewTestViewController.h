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

#import <UIKit/UIKit.h>

@interface BWSTRNewTestViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *shapeSizeField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *dominantHand;
@property (nonatomic, weak) IBOutlet UITextField *numberOfTrialsField;
@property (nonatomic, weak) IBOutlet UITextField *rowsField;
@property (nonatomic, weak) IBOutlet UITextField *columnsField;
@property (nonatomic, weak) IBOutlet UITextField *participantIDField;
@property (nonatomic, weak) IBOutlet UIPickerView *shapePicker;

- (IBAction)startButtonPressed:(id)sender;

@end
