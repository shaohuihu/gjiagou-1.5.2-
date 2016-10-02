//
//  ELProductListTopView.h
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELProductListTopView : UIView

@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
// 0 normal 1 翻转
- (void)setLeftButtonType:(NSInteger)tag;

@end
