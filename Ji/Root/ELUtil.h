//
//  ELUtil.h
//  WaiDian
//
//  Created by evol on 16/4/28.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELUtil : NSObject

/***** AlertView 处理 ******/
void DMAlertNoTitle(NSString *message);
void DMAlert(NSString *title ,NSString *message);

/****** 图片处理 *******/
UIImage *imageWithColor(UIColor *color,CGFloat width,CGFloat height);


+ (UILabel *)createLabelFont:(CGFloat)font color:(UIColor *)color;
NSURL *ELIMAGEURL(NSString *imgStr);

@end
