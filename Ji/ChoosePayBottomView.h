//
//  ChoosePayBottomView.h
//  Ji
//
//  Created by 龙讯科技 on 16/9/11.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePayBottomView : UIView
@property (nonatomic, copy) void(^checkoutBlock)();

- (void)setData:(NSDictionary *)data;

@end
