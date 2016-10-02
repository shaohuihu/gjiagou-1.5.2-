//
//  ELGoodsBottomView.h
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ELGoodsBottomViewDelegate <NSObject>

@optional
- (void)bottomViewOnJoinCartTap;//购物车
- (void)bottomViewOnCreateOrderTap;//购买
- (void)bottomViewPersonServiceTap;//客服
- (void)bottomViewOnCheckoutShopTap;//商铺
- (void)bottomViewOnAddFavShopTap;//收藏

@end


@interface ELGoodsBottomView : UIView


@property (nonatomic, weak) id<ELGoodsBottomViewDelegate> delegate;

@property (nonatomic, weak) UIButton *collectButton;

@end
