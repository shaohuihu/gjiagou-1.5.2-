//
//  ELCartListCell.m
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCartListCell.h"
#import "ELCartListModel.h"
#import "ELCartGoodsModel+bind.h"

@interface ELCartListCell ()

@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *countAcLabel;
@property (nonatomic, weak) UIButton *checkoutButton;

@end

@implementation ELCartListCell


- (void)o_configViews{
    
    
    UIButton *checkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_checked"] forState:UIControlStateNormal];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_unchecked"] forState:UIControlStateSelected];
    [checkoutButton addTarget:self action:@selector(onCheckoutButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.checkoutButton = checkoutButton];
    
    UIImageView *icon = [UIImageView new];
    [self.contentView addSubview: self.icon = icon];
    
    UILabel *nameLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel = nameLabel];
    
    UILabel *detailLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel = detailLabel];
    
    UILabel *priceLabel = [ELUtil createLabelFont:14.f color:EL_MainColor];
    [self.contentView addSubview:self.priceLabel = priceLabel];
    
    UILabel *countLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    [self.contentView addSubview:self.countLabel = countLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"ic_minus_shop"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(onAddTap) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addButton];
    
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delButton setImage:[UIImage imageNamed:@"ic_add_shop"] forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(onDelTap) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:delButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_text_shop"]];
    [self.contentView addSubview:imageView];
    
    UILabel *countAcLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    countAcLabel.text = @"0";
    [imageView addSubview:self.countAcLabel = countAcLabel];

    
    WS(ws);
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kRadioXValue(10));
        make.left.equalTo(kRadioXValue(26));
        make.size.equalTo(CGSizeMake(kRadioValue(85), kRadioValue(85)));
    }];
    
    [checkoutButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView.left).offset(kRadioXValue(13.f));
        make.centerY.equalTo(icon);
        make.size.equalTo(CGSizeMake(kRadioXValue(26), kRadioXValue(26)));
    }];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon);
        make.right.equalTo(ws.contentView).offset(-13);
    }];

    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.right).offset(10);
        make.right.equalTo(priceLabel.left).offset(-15);
        make.top.equalTo(icon);
    }];
    
    [detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.bottom).offset(10);
        make.left.right.equalTo(nameLabel);
    }];
    
    [countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(priceLabel);
        make.top.equalTo(detailLabel);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.bottom).offset(10);
        make.centerX.equalTo(icon);
        make.bottom.equalTo(ws.contentView).offset(-15);
    }];

    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.right).offset(1);
        make.centerY.equalTo(imageView);
    }];
    
    [delButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageView.left).offset(-1);
        make.centerY.equalTo(imageView);
    }];
    
    [countAcLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imageView);
    }];

}


- (void)onCheckoutButtonTap:(UIButton *)button {
    button.selected = !button.selected;
    ELCartGoodsModel *model = self.data;
    if (self.type == 0) {
        [model bindBool:button.selected];
    }else{
        [model bindDelKey:!button.selected];
    }
    if ([self.delegate respondsToSelector:@selector(listCell:didCheckoutButtonSelectWithIndexPath:)]) {
        [self.delegate listCell:self didCheckoutButtonSelectWithIndexPath:self.indexPath];
    }
}

- (void)onAddTap {
    NSInteger count = self.countAcLabel.text.integerValue;
    count++;
    self.countAcLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.countLabel.text = [NSString stringWithFormat:@"x%ld",(long)count];

    if ([self.delegate respondsToSelector:@selector(listCell:didChangeCount:)]) {
        [self.delegate listCell:self didChangeCount:count];
    }
    ELCartGoodsModel *model = self.data;
    model.goods_number = count;
}


- (void)onDelTap {
    NSInteger count = self.countAcLabel.text.integerValue;
    if (count == 1) {
        return;
    }
    count--;
    self.countAcLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.countLabel.text = [NSString stringWithFormat:@"x%ld",(long)count];

    if ([self.delegate respondsToSelector:@selector(listCell:didChangeCount:)]) {
        [self.delegate listCell:self didChangeCount:count];
    }
    ELCartGoodsModel *model = self.data;
    model.goods_number = count;

}


- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[ELCartGoodsModel class]]) {
        ELCartGoodsModel *model = self.data;
        [self.icon sd_setImageWithURL:ELIMAGEURL(model.img) placeholderImage:[UIImage imageNamed:@"ic_perc"]];
        self.nameLabel.text = model.goods_name;
        NSString *price = [NSString stringWithFormat:@"￥%.2f",model.goods_price];
        self.priceLabel.text = DBPRICE(price);
        [self.priceLabel sizeToFit];
        self.countLabel.text = [NSString stringWithFormat:@"x%ld",(long)model.goods_number];
        self.countAcLabel.text = [NSString stringWithFormat:@"%ld",(long)model.goods_number];
        self.detailLabel.text = model.goods_attr;
        [self.priceLabel updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.priceLabel.el_width);
        }];
        if (self.type == 0) {
            self.checkoutButton.selected = [model getBool];
        }else{
            self.checkoutButton.selected = ![model getDelKey];
        }
    }
}

@end
