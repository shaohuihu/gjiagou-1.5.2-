//
//  ELCheckoutBottomView.m
//  Ji
//
//  Created by evol on 16/6/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCheckoutBottomView.h"
#import "ELbadSViewController.h"

@interface ELCheckoutBottomView ()

@property (nonatomic, weak) UILabel *contentlabel;
@property (nonatomic, weak) UIButton *checkButton;//结算动作
@property (nonatomic, weak) UILabel *priceLabel;
@end

@implementation ELCheckoutBottomView
#pragma mark-提交订单
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
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFont_System(16);
    [button addTarget:self action:@selector(onRightButtonTap) forControlEvents:UIControlEventTouchUpInside];
    //将按钮的点击属性打开
    button.userInteractionEnabled=YES;
    self.userInteractionEnabled=YES;
    
  [self addSubview:self.checkButton = button];

#warning view的坐标不详
    UILabel *priceLabel = [ELUtil createLabelFont:14.f color:EL_MainColor];
    [self addSubview:self.priceLabel = priceLabel];
    
    WS(ws);

    [button makeConstraints:^(MASConstraintMaker *make) {
       // make.right.top.bottom.equalTo(ws).offset(-60);
      make.right.top.bottom.equalTo(ws).offset;
        make.width.equalTo(100);
        //屏幕适配的ws
        
    }];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(button.left).offset(-13);
       //  make.right.top.bottom.equalTo(ws).offset(-30);
        //make.right.equalTo(button.left).offset(60);
        make.centerY.equalTo(ws);
    }];
    
    [contentlabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(priceLabel.left).offset(-10);
         //make.right.top.bottom.equalTo(ws).offset(-60);
       // make.right.equalTo(priceLabel.left).offset(-10);
        make.centerY.equalTo(ws);
    }];
    
}

- (NSString *)priceValue:(NSInteger)price {
    return [NSString stringWithFormat:@"合计: ￥%ld",(long)price];
}

//select 为yes时 为没选中
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
        NSNumber *count = data[@"count"];
        NSNumber *price = data[@"price"];
//        NSNumber *post = data[@"post"];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price.doubleValue];
        self.contentlabel.text = [NSString stringWithFormat:@"共%ld件商品 合计: ",(long)count.integerValue];
    }
}

@end
