/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint el_origin;
@property CGSize el_size;

@property (readonly) CGPoint el_bottomLeft;
@property (readonly) CGPoint el_bottomRight;
@property (readonly) CGPoint el_topRight;

@property CGFloat el_height;
@property CGFloat el_width;

@property CGFloat el_top;
@property CGFloat el_left;

@property CGFloat el_bottom;
@property CGFloat el_right;

@property (nonatomic) CGFloat el_centerX;
@property (nonatomic) CGFloat el_centerY;

@end