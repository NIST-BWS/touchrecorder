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

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
	NSString *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc] initWithLogsDirectory:documentsDirectory]];
#else
	fileLogger = [[DDFileLogger alloc] init];
#endif
	fileLogger.maximumFileSize = 1024 * 1024;
	fileLogger.rollingFrequency = 60 * 60 * 24;
	[DDLog addLogger:fileLogger];
}

@end
