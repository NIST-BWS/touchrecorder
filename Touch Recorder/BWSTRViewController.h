/*
 * This software was developed at the National Institute of Standards and
 * Technology (NIST) by employees of the Federal Government in the course
 * of their official duties. Pursuant to title 17 Section 105 of the
 * United States Code, this software is not subject to copyright protection
 * and is in the public domain. NIST assumes no responsibility whatsoever for
 * its use by other parties, and makes no guarantees, expressed or implied,
 * about its quality, reliability, or any other characteristic.
 */

@class BWSTRShape;

#import <UIKit/UIKit.h>

@interface BWSTRViewController : UIViewController

@property (nonatomic, assign) NSUInteger rows;
@property (nonatomic, assign) NSUInteger columns;
@property (nonatomic, assign) NSUInteger shapeWidth;
@property (nonatomic, assign) NSUInteger shapeHeight;
@property (nonatomic, strong) UIColor *shapeForegroundColor;
@property (nonatomic, strong) UIColor *shapeBackgroundColor;


#pragma mark - Shape Insertion

/**
 * @brief
 * Draw shape in a quadrant.
 *
 * @param shape
 *	Shape to draw.
 * @param quadrantNumber
 *	1-based quadrant number, row-major order.
 */
- (void)insertShape:(BWSTRShape *)shape inQuadrant:(NSUInteger)quadrantNumber;

/**
 * @brief
 * Draw shape in a quadrant.
 * 
 * @param shape
 *	Shape to draw.
 * @param row
 *	1-based row in which shape is drawn.
 * @param column
 *	1-based column in which shape is drawn.
 */
- (void)insertShape:(BWSTRShape *)shape inRow:(NSUInteger)row column:(NSUInteger)column;


@end
