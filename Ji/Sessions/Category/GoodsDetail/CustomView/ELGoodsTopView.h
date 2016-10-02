//
//  ELGoodsTopView.h
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELGoodsTopView : UIView

@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
@property (nonatomic, assign) NSInteger selectIndex;

@end
