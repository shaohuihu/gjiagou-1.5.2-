//
//  ELProductOrderView.h
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELProductOrderView : UIButton

@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
@property (nonatomic, assign) NSInteger selectIndex;

- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view belowView:(UIView *)belowView;
- (void)hide;

@end
