//
//  ELShopListHeaderView.m
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopListHeaderView.h"

@interface ELShopListHeaderView ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *checkoutButton;
@end

@implementation ELShopListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *checkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_checked"] forState:UIControlStateNormal];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_unchecked"] forState:UIControlStateSelected];
    [checkoutButton addTarget:self action:@selector(onCheckoutButtonTap:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.checkoutButton = checkoutButton];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_shoping_supermarkert"]];
    [self addSubview:imageView];
    
    UILabel *label = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [self addSubview:self.label = label];
    
    UIImageView *arrowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_small_right"]];//12 22
    [self addSubview:arrowIcon];
    
    UIView *lineView =[[UIView alloc] init];
    lineView.backgroundColor = EL_Color_Line;
    [self addSubview:lineView];
    
    WS(ws);
    [checkoutButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws);
        make.centerX.equalTo(ws.left).offset(kRadioXValue(13));
    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioXValue(26));
        make.centerY.equalTo(ws);
        make.size.equalTo(CGSizeMake(14, 14));
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(8);
        make.centerY.equalTo(ws);
    }];
    
    [arrowIcon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws);
        make.left.equalTo(label.right).offset(30);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.equalTo(0.5);
    }];
    
}

- (void)setModel:(ELCartListModel *)model {
    _model = model;
    self.label.text = model.shopName;
}

//默认是全选 normal是全选状态
- (void)setState:(BOOL)isAll {
    self.checkoutButton.selected = !isAll;
}

//select 为yes时 为没选中
- (void)onCheckoutButtonTap:(UIButton *)button {
    button.selected = !button.selected;
    if ([self.delegate respondsToSelector:@selector(topViewCheckoutButtonDidTapWithSection:selected:)]) {
        [self.delegate topViewCheckoutButtonDidTapWithSection:self.section selected:!button.selected];
    }
}

@end
