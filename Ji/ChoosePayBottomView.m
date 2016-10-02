//
//  ChoosePayBottomView.m
//  Ji
//
//  Created by 龙讯科技 on 16/9/11.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ChoosePayBottomView.h"
#import "ELShopService.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiManager.h"
#import "WXApiManager.h"
#import "AFNetworking.h"
#import "JieViewController.h"
#import "ELGoodDetailController.h"
#import "ELCheckoutBottomView.h"
@interface ChoosePayBottomView(){
    NSString * tag;
    NSString * number;
    NSString *price;
}
@property (nonatomic, weak) UILabel *contentlabel;
@property (nonatomic, weak) UIButton *checkButton;//结算动作
@property (nonatomic, weak) UILabel *priceLabel;
@end




@implementation ChoosePayBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    //设置view的坐标
    
    UILabel *contentlabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [self addSubview:self.contentlabel = contentlabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:imageWithColor(EL_MainColor, 1, 1) forState:UIControlStateNormal];
    [button setTitle:@"支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFont_System(16);
    [button addTarget:self action:@selector(onRightButtonTap) forControlEvents:UIControlEventTouchUpInside];
    //将按钮的点击属性打开
    button.userInteractionEnabled=YES;
    self.userInteractionEnabled=YES;
    
    [self addSubview:self.checkButton = button];
    

    UILabel *priceLabel = [ELUtil createLabelFont:14.f color:EL_MainColor];
    [self addSubview:self.priceLabel = priceLabel];
    
    WS(ws);
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        // make.right.top.bottom.equalTo(ws).offset(-60);
        make.right.top.bottom.equalTo(ws);
        make.width.equalTo(100);
        //屏幕适配的ws
        
    }];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(button.left).offset(-13);
       
       // make.right.top.bottom.equalTo(ws).offset(-30);
        make.left.equalTo(contentlabel.right).offset(10);
        make.centerY.equalTo(ws);
    }];
    
    [contentlabel makeConstraints:^(MASConstraintMaker *make) {
       // make.right.equalTo(priceLabel.left).offset(-10);
        make.left.equalTo(ws).offset(10);
        //make.right.top.bottom.equalTo(ws).offset(-60);
        // make.right.equalTo(priceLabel.left).offset(-10);
        make.centerY.equalTo(ws);
    }];
    
}
- (NSString *)priceValue:(NSInteger)price {
  
    return [NSString stringWithFormat:@"合计: ￥%ld",(long)price];
}

- (void)onRightButtonTap{
    //    if ([self.delegate respondsToSelector:@selector(checkoutRightTap)]) {
    //        [self.delegate checkoutRightTap];
    //    }
    if (self.checkoutBlock) {
        self.checkoutBlock();
    }
}


#pragma mark - Setters

- (void)setData:(NSDictionary *)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
//        NSNumber *count = data[@"count"];
       price = data[@"price"];
         tag=data[@"tag"];
        number=data[@"number"];
        DDLog(@"每次都打印一次%@",data);
        //        NSNumber *post = data[@"post"];
       
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
        self.contentlabel.text = @" 合计: ";
    }
}




@end
