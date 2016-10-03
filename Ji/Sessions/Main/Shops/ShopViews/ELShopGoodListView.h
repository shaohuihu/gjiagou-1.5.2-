//
//  ELShopGoodListView.h
//  Ji
//
//  Created by hushaohui on 16/10/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELMainShopTopModel.h"
@class ELMainShopTopModel;
/**
 *  超值单品
 */
@interface ELShopGoodListView : UIView



- (instancetype)initWithFrame:(CGRect)frame  model:(ELMainShopTopModel *)model;

@property (nonatomic, weak)UIViewController *controlelr;  ///<控制器
@end
