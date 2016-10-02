//
//  UIButton+Ext.m
//  Wai
//
//  Created by lwq on 16/5/10.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "UIButton+Ext.h"
#import "NSString+Tools.h"

@implementation UIButton (Ext)


- (void)setLeftTitleRightImage
{
    CGSize textSize = [self.titleLabel.text textSizeWithFont:self.titleLabel.font size:CGSizeMake(MAXFLOAT, self.titleLabel.el_height)];
    CGSize imvSize = self.imageView.bounds.size;
    
//    [self sizeToFit];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imvSize.width, 0, imvSize.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, textSize.width, 0, -textSize.width);
}

@end
