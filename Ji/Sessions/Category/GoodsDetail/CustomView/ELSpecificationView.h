//
//  ELSpecificationView.h
//  Ji
//
//  Created by evol on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELGoodsDetailModel;
@class ELGoodsPrice;

@interface ELSpecificationView : UIButton

@property (nonatomic, strong) ELGoodsDetailModel *goodModel;
@property (nonatomic, strong) NSMutableArray *parameters;
@property (nonatomic, assign) NSInteger goodsCount;
@property (nonatomic, copy) void(^completion)();
@property (nonatomic, copy) void(^buyBlock)(NSString *value);
@property (nonatomic, assign) BOOL fromCart;
@property (nonatomic, assign) BOOL fromBuy;


@property (nonatomic, strong) ELGoodsPrice *priceModel;

- (void)showInView:(UIView *)view;
- (void)hide;
- (void)reloadData;

- (BOOL)didSelectAll;
- (void)onSelfTap;
- (void)clear;

@end
