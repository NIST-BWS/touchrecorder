//
//  BWSTRConstants.h
//  Touch Recorder
//
//  Created by Greg Fiumara on 2/28/13.
//  Copyright (c) 2013 NIST. All rights reserved.
//

/*
 * Constants used throughout the project.
 */

#ifndef __BWSTRCONSTANTS_H__
#define __BWSTRCONSTANTS_H__

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
static NSString * const kBWSTRViewNib = @"BWSTRViewController";

/*
 * Notifications.
 */
static NSString * const kBWSTRNotificationShapeHit = @"kBWSTRNotificationShapeHit";

#endif /* __BWSTRCONSTANTS_H__ */
