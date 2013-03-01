//
//  UIColor+BWSTRUtilities.m
//  Touch Recorder
//
//  Created by Greg Fiumara on 2/28/13.
//  Copyright (c) 2013 NIST. All rights reserved.
//

#import "UIColor+BWSTRUtilities.h"

@implementation UIColor (BWSTRUtilities)

- (NSArray *)RGBComponents
{
	CGColorRef color = [self CGColor];
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB)
		return (nil);
	
	const CGFloat *components = CGColorGetComponents(color);
	NSArray *componentsConversion = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), @(components[3]), nil];
	return (componentsConversion);
}

@end
