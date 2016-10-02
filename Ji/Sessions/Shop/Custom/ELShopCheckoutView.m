//
//  ELShopCheckoutView.m
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//
#pragma mark-购物车
#import "ELShopCheckoutView.h"

@interface ELShopCheckoutView ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *checkButton;//结算动作
@property (nonatomic, weak) UIButton *checkoutButton;//左侧icon
@end

@implementation ELShopCheckoutView

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
    
    UIButton *checkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_checked"] forState:UIControlStateNormal];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_unchecked"] forState:UIControlStateSelected];
    [checkoutButton addTarget:self action:@selector(onCheckoutButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.checkoutButton = checkoutButton];
    
    UILabel *fixLabel = [ELUtil createLabelFont:13.f color:EL_TextColor_Dark];
    fixLabel.text = @"全选";
    [self addSubview:fixLabel];
    
    UILabel *label = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [self addSubview:self.label = label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:imageWithColor(EL_MainColor, 1, 1) forState:UIControlStateNormal];
    [button setTitle:@"去结算" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFont_System(16);
    [button addTarget:self action:@selector(onRightButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.checkButton = button];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self addSubview:lineView];
    
    WS(ws);
    [checkoutButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws);
        make.centerX.equalTo(ws.left).offset(kRadioXValue(13));
    }];
    
    [fixLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioXValue(26));
        make.centerY.equalTo(ws);
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fixLabel.right).offset(15);
        make.centerY.equalTo(ws);
    }];
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(ws);
        make.width.equalTo(100);
    }];
 
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws);
        make.height.equalTo(0.5);
    }];
}

- (NSString *)priceValue:(double)price {
    NSString *pricestr = [NSString stringWithFormat:@"合计: ￥%.2f",price];
    return DBPRICE(pricestr);
}

//select 为yes时 为没选中
- (void)onCheckoutButtonTap:(UIButton *)button {
    button.selected = !button.selected;
    if ([self.delegate respondsToSelector:@selector(checkoutViewTagButtonDidTapWithSelected:)]) {
        [self.delegate checkoutViewTagButtonDidTapWithSelected:!button.selected];
    }
}

- (void)onRightButtonTap{
    if ([self.delegate respondsToSelector:@selector(checkoutRightTap)]) {
        [self.delegate checkoutRightTap];
    }
}

#pragma mark - Setters

- (void)setType:(CheckoutType)type {
    _type = type;
    if (type == CheckoutType_Delete) {
        [self.checkButton setTitle:@"删除" forState:UIControlStateNormal];
        self.label.hidden = YES;
    }else{
        [self.checkButton setTitle:[NSString stringWithFormat:@"去结算"] forState:UIControlStateNormal];
        self.label.hidden = NO;
    }
}

- (void)setPrice:(double)price count:(NSInteger)count isAll:(BOOL)tag{
    if (self.type == CheckoutType_Order) {
        self.label.text = [self priceValue:price];
        [self.checkButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",(long)count] forState:UIControlStateNormal];
        self.checkoutButton.selected = !tag;
    }else{
        [self.checkButton setTitle:@"删除" forState:UIControlStateNormal];
        self.checkoutButton.selected = !tag;
    }
}

@end
