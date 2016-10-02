//
//  ELMesssageDeleteView.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMesssageDeleteView.h"
//这个是购物车的方法
@interface ELMesssageDeleteView ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *checkButton;//结算动作
@property (nonatomic, weak) UIButton *checkoutButton;//左侧icon

@end

@implementation ELMesssageDeleteView

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
    [checkoutButton setImage:[UIImage imageNamed:@"ic_unchecked"] forState:UIControlStateNormal];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_checked"] forState:UIControlStateSelected];
    [checkoutButton addTarget:self action:@selector(onCheckoutButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.checkoutButton = checkoutButton];
    
    UILabel *fixLabel = [ELUtil createLabelFont:13.f color:EL_TextColor_Dark];
    fixLabel.text = @"全选";
    [self addSubview:fixLabel];
    
    UILabel *label = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [self addSubview:self.label = label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:imageWithColor(EL_MainColor, 1, 1) forState:UIControlStateSelected];
    [button setBackgroundImage:imageWithColor([UIColor lightGrayColor], 1, 1) forState:UIControlStateNormal];
    [button setTitle:@"删除" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFont_System(16);
    [button addTarget:self action:@selector(onRightButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.checkButton = button];
    
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
    
}

- (NSString *)priceValue:(double)price {
    NSString *priceStr = [NSString stringWithFormat:@"合计: ￥%.2f",price];
    return DBPRICE(priceStr);
}

//select 为yes时 为没选中
- (void)onCheckoutButtonTap:(UIButton *)button {
    button.selected = !button.selected;
    self.checkButton.selected = button.selected;
    if ([self.delegate respondsToSelector:@selector(deleteViewTagButtonDidTapWithSelected:)]) {
        [self.delegate deleteViewTagButtonDidTapWithSelected:button.selected];
    }
}

- (void)onRightButtonTap{
    if ([self.delegate respondsToSelector:@selector(deleteViewRightTap)]) {
        [self.delegate deleteViewRightTap];
    }
}

- (void)setLeftTag:(BOOL)leftTag rightTag:(BOOL)rightTag {
    self.checkoutButton.selected = leftTag;
    self.checkButton.selected = rightTag;
}


@end
