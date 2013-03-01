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
 * Custom Lumberjack DDLog log levels.
 */

#ifndef __BWSTRDDLOG_H__
#define __BWSTRDDLOG_H__

#import "DDLog.h"

/* 
 * The first 4 bits are being used by the standard levels (0 - 3).
 * All other bits are fair game for us to use.
 */

#define LOG_FLAG_BWSTR_TOUCH		(1 << 4)
#define LOG_FLAG_BWSTR_VERBOSE		(1 << 5)

#define LOG_BWSTR_TOUCH			(ddLogLevel & LOG_FLAG_BWSTR_TOUCH)
#define LOG_BWSTR_VERBOSE		(ddLogLevel & LOG_FLAG_BWSTR_VERBOSE)

#define REFRESH_DD_BWSTR_LOG_PREFS	(ddLogLevel = [BWSTRDDLog readBWSTRDDLoggingLevel])

/** Logs information about taps */
#define DDLogBWSTRTouch(frmt, ...)	REFRESH_DD_BWSTR_LOG_PREFS; ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_BWSTR_TOUCH, 0, ([NSString stringWithFormat:@"<TL> %@", frmt]), ##__VA_ARGS__)
/** Logs the kitchen sink */
#define DDLogBWSVerbose(frmt, ...)	REFRESH_DD_BWS_LOG_PREFS; ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_BWSTR_VERBOSE, 0, ([NSString stringWithFormat:@"<VL> %@", frmt]), ##__VA_ARGS__)
/** Logs the kitchen sink with no arguments */
#define DDLogBWSVerboseS(message)	REFRESH_DD_BWS_LOG_PREFS; ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_BWSTR_VERBOSE, 0, ([NSString stringWithFormat:@"<VL> %@", message]), ##__VA_ARGS__)

/*
 * Specializations
 */
/** Logs a tap (local, global, hit/miss) */
#define DDLogBWSTRTouchLGHM(localPoint, hitMissBool)	DDLogBWSTRTouch(@"Local: %@, Global: %@, Hit: %@", NSStringFromCGPoint(localPoint), NSStringFromCGPoint([self convertPoint:localPoint toView:self.superview]), hitMissBool ? @"Yes" : @"No")

@interface BWSTRDDLog : NSObject

/** @return Logging level as set in the settings */
+ (int)readBWSTRDDLoggingLevel;
/** Sets and saves default logging value settings */
+ (void)setDefaultLoggingLevels;

@end

#endif /* __BWSTRDDLOG_H__ */
