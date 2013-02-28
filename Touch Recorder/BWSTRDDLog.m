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

#import "BWSTRDDLog.h"

@implementation BWSTRDDLog

+ (int)readBWSTRDDLoggingLevel
{
	int logLevel = 0;
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kBWSTRSettingsTapLoggingEnabledKey])
		logLevel |= LOG_FLAG_BWSTR_TOUCH;
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kBWSTRSettingsVerboseLoggingEnabledKey])
		logLevel |= LOG_FLAG_BWSTR_VERBOSE;
	
	return (logLevel);
}

+ (void)setDefaultLoggingLevels
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if ([defaults objectForKey:kBWSTRSettingsTapLoggingEnabledKey] == nil)
		[defaults setBool:kBWSTRSettingsTapLoggingEnabledValueDefault forKey:kBWSTRSettingsTapLoggingEnabledKey];
	if ([defaults objectForKey:kBWSTRSettingsVerboseLoggingEnabledKey] == nil)
		[defaults setBool:kBWSTRSettingsVerboseLoggingEnabledValueDefault forKey:kBWSTRSettingsVerboseLoggingEnabledKey];
}

@end
