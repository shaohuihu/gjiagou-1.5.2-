//
//  ELShopCheckoutView.h
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CheckoutType) {
    CheckoutType_Order,
    CheckoutType_Delete,
};

@protocol ELShopCheckoutViewDelegate <NSObject>
@optional
- (void)checkoutViewTagButtonDidTapWithSelected:(BOOL)selected;
- (void)checkoutRightTap;
@end

@interface ELShopCheckoutView : UIView

@property (nonatomic, assign) CheckoutType type;

@property (nonatomic, weak) id<ELShopCheckoutViewDelegate> delegate;

- (void)setPrice:(double)price count:(NSInteger)count isAll:(BOOL)tag;

@end
