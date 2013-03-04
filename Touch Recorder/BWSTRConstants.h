/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

/*
 * Constants used throughout the project.
 */

#import <UIKit/UIKit.h>

/*
 * Settings.
 */

/** Defaults key for enabling tap logging */
static NSString * const kBWSTRSettingsTapLoggingEnabledKey = @"kBWSTRSettingsTapLoggingEnabledKey";
/** Default value for tap logging */
static const BOOL kBWSTRSettingsTapLoggingEnabledValueDefault = YES;
/** Defaults key for enabling verbose logging */
static NSString * const kBWSTRSettingsVerboseLoggingEnabledKey = @"kBWSTRSettingsVerboseLoggingEnabledKey";
/** Default value for verbose logging */
static const BOOL kBWSTRSettingsVerboseLoggingEnabledValueDefault = YES;

/*
 * NIBs
 */

/** View that performs the test. */
static NSString * const kBWSTRViewNib = @"BWSTRViewController";
/** View for gathering test properties. */
static NSString * const kBWSTRNewTestView = @"BWSTRNewTestView";

/*
 * Notifications.
 */

/** A shape was touched inside its bounds */
static NSString * const kBWSTRNotificationShapeHit = @"kBWSTRNotificationShapeHit";
/** Test properties have been set and are attached */
static NSString * const kBWSTRNotificationTestPropertiesSet = @"kBWSTRNotificationTestPropertiesSet";

/*
 * Notification userInfo keys.
 */

/** Test properties within the kBWSTRNotificationTestPropertiesSet userInfo dictionary */
static NSString * const kBWSTRNotificationTestPropertiesSetTestPropertiesKey = @"kBWSTRNotificationTestPropertiesSetTestPropertiesKey";

/*
 * Enumerations.
 */

/** Dominant hand position of subject. */
typedef NS_ENUM(NSUInteger, BWSTRDominantHand)
{
	/** Left handed. */
	kBWSTRDominantHandLeft = 0,
	/** Right handed. */
	kBWSTRDominantHandRight = 1,
	/** Ambidextrous */
	kBWSTRDominantHandBoth = 2
};

/** Advertised types of shapes. */
typedef NS_ENUM(NSUInteger, BWSTRShapeName)
{
	kBWSTRShapeCircle,
	kBWSTRShapeSquare,
	
	kBWSTRShapeCount
};

/** Advertised colors */
typedef NS_ENUM(NSUInteger, BWSTRColor)
{
	kBWSTRColorBlack,
	kBWSTRColorWhite,
	kBWSTRColorGreen,
	kBWSTRColorRed,
	kBWSTRColorBlue,
	kBWSTRColorYellow,
	
	kBWSTRColorCount
};

@interface BWSTRConstants : NSObject

/** Obtain string representation for the name of a shape. */
+ (NSString *)stringForShapeName:(BWSTRShapeName)shapeName;
/** Obtain string representation for the name of a dominant hand. */
+ (NSString *)stringForDominantHand:(BWSTRDominantHand)dominantHand;
/** Obtain string representation for the name of a color. */
+ (NSString *)stringForColor:(BWSTRColor)color;
/** Obtain a colored string representation for the name of a color. */
+ (NSAttributedString *)attributedStringForColor:(BWSTRColor)color;
/** Convert BWSTRColor to a usable UIColor. */
+ (UIColor *)colorForBWSTRColor:(BWSTRColor)color;


@end
