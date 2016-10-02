//
//  ELShopGoodsListCell.m
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopGoodsListCell.h"
#import "ELMainShopTopModel.h"

@interface ELShopGoodsListCell ()

@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *cateLabel;

@property (nonatomic, weak) UILabel *oriPriceLabel;

@end

@implementation ELShopGoodsListCell


- (void)o_configViews{
    //商品的图片
    UIImageView *icon = [UIImageView new];
    [self.contentView addSubview: self.icon = icon];
    //商品的名字
    UILabel *nameLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel = nameLabel];
    //商品的价格
    UILabel *priceLabel = [ELUtil createLabelFont:14.f color:EL_MainColor];
    [self.contentView addSubview:self.priceLabel = priceLabel];
    
    UILabel *oriPriceLabel = [UILabel new];
    [self.contentView addSubview:self.oriPriceLabel = oriPriceLabel];
    
    UILabel *fixLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    fixLabel.text = @"销量";
    [self.contentView addSubview:fixLabel];
    
    UILabel *countLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    [self.contentView addSubview:self.countLabel = countLabel];
    
    UILabel *cateLabel = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.cateLabel  = cateLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(kRadioXValue(10));
        make.size.equalTo(CGSizeMake(kRadioValue(85), kRadioValue(85)));
        make.bottom.equalTo(ws.contentView).offset(-kRadioXValue(10));
    }];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.right).offset(10);
        make.right.equalTo(ws.contentView).offset(-15);
        make.top.equalTo(icon);
    }];
    //这个是销量的label
    [fixLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.bottom.equalTo(icon);
    }];

    
    //这个是销量的个数label
    [countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fixLabel.right).offset(5);
        make.centerY.equalTo(fixLabel);
    }];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fixLabel.top).offset(-15);
        make.left.equalTo(nameLabel);
    }];
    
    [oriPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.right).offset(10);
        make.centerY.equalTo(priceLabel);
    }];

    [cateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-15);
        make.bottom.equalTo(countLabel);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];
}

- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[ELGoodslistModel class]]) {
        ELGoodslistModel *model = self.data;
        [self.icon sd_setImageWithURL:ELIMAGEURL(model.imgUrl)];
        self.nameLabel.text = model.name;
        NSString *price = [NSString stringWithFormat:@"￥%.2f",model.price];
        self.priceLabel.text = DBPRICE(price);
        self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)model.sumSold];
        self.cateLabel.text = model.shopName;
        NSString * oriPrice = [NSString stringWithFormat:@"￥%.2f",model.originalPrice];
        self.oriPriceLabel.attributedText = [DBPRICE(oriPrice) strikeStringWithFont:13 color:EL_TextColor_Light];

    }
}

@end
