//
//  BWSTRRectanular.m
//  Touch Recorder
//
//  Created by MBARK on 11/25/13.
//  Copyright (c) 2013 NIST. All rights reserved.
//

#import "BWSTRRectangular.h"

@implementation BWSTRRectangular

- (void)drawRect:(CGRect)rect
{
    rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + 20, rect.size.height);
        
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, true);
    CGContextSetFillColorWithColor(context, [self.foregroundColor CGColor]);
    
    CGContextSetStrokeColorWithColor(context, [self.foregroundColor CGColor]);
    CGContextFillRect(context, rect);
    
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    /* Save this context to an image for location testing */
    CGImageRef backingCGImage = CGBitmapContextCreateImage(context);
    self.backingImage = [UIImage imageWithCGImage:backingCGImage];
    CGImageRelease(backingCGImage);
}
@end


