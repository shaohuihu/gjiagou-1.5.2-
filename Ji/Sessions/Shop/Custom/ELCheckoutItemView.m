//
//  ELCheckoutItemView.m
//  Ji
//
//  Created by evol on 16/6/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCheckoutItemView.h"

@interface ELCheckoutItemView ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *countLabel;

@end

@implementation ELCheckoutItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self o_configViews];
    }
    return self;
}

- (void)o_configViews
{
    UILabel *nameLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    nameLabel.numberOfLines = 2;
    [self addSubview:self.nameLabel = nameLabel];
    
    UILabel *priceLabel = [ELUtil createLabelFont:14.f color:EL_MainColor];
    [self addSubview:self.priceLabel = priceLabel];
    
    UILabel *countLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    [self addSubview:self.countLabel = countLabel];
    
    WS(ws);
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws).offset(13);
    }];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).offset(-13);
        make.top.equalTo(nameLabel);
    }];
    
    [countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(priceLabel);
        make.top.equalTo(priceLabel.bottom).offset(15);
        make.bottom.equalTo(ws).offset(-15);
    }];
    
}


- (void)setModel:(ELCartGoodsModel *)model {
    _model = model;
    self.nameLabel.text = model.goods_name;
    NSString *price = [NSString stringWithFormat:@"%.2f",model.goods_price];
    self.priceLabel.text = DBPRICE(price);
    self.countLabel.text = [NSString stringWithFormat:@"x%ld",(long)model.goods_number];
    DDLog(@"购物车里面的价格%@",self.priceLabel.text);
    DDLog(@"购物车里面的数量%@",self.countLabel.text);
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.nameLabel updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.priceLabel.left).offset(-30);
    }];
}

@end
