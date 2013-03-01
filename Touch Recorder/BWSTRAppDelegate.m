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
#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import "BWSTRViewController.h"

#import "BWSTRAppDelegate.h"


@implementation BWSTRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.viewController = [[BWSTRViewController alloc] initWithNibName:kBWSTRViewNib bundle:nil];
	self.window.rootViewController = self.viewController;
	
	[self enableLogging];
	
	[self.window makeKeyAndVisible];
	return (YES);
}

#pragma mark - Logging

- (void)enableLogging
{
	[BWSTRDDLog setDefaultLoggingLevels];
	
	/* Log to console */
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	/* Log to file */
	DDFileLogger *fileLogger = nil;
#if TARGET_OS_IPHONE
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc] initWithLogsDirectory:documentsDirectory]];
#else
	fileLogger = [[DDFileLogger alloc] init];
#endif
	fileLogger.maximumFileSize = 1024 * 1024;
	fileLogger.rollingFrequency = 60 * 60 * 24;
	[DDLog addLogger:fileLogger];
}

@end
