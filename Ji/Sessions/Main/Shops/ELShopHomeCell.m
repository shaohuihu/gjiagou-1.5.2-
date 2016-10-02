
//
//  ELShopHomeCell.m
//  Ji
//
//  Created by evol on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopHomeCell.h"
#import "ELMainShopTopModel.h"
@implementation ELShopHomeCell

{
    UIImageView *imageView_;
    UILabel *nameLabel_;
    UILabel *priceLabel_;
    UILabel *oriPriceLabel_;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self p_configView];
    }
    return self;
}


- (void)p_configView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    imageView_ = [UIImageView new];
    [self.contentView addSubview:imageView_];
    
    nameLabel_ = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    nameLabel_.textAlignment = NSTextAlignmentCenter;
    nameLabel_.numberOfLines = 0;
    [self.contentView addSubview:nameLabel_];
    
    
    priceLabel_ = [ELUtil createLabelFont:14.f color:EL_MainColor];
    [self.contentView addSubview:priceLabel_];
    
    oriPriceLabel_ = [UILabel new];
    [self.contentView addSubview:oriPriceLabel_];
    
    WS(ws);
    [imageView_ makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(8);
        make.left.equalTo(8);
        make.right.equalTo(ws.contentView).offset(-8);
        make.height.equalTo(imageView_.width);
    }];
    
    [nameLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.lessThanOrEqualTo(35);
        make.top.equalTo(imageView_.bottom).offset(8);
    }];
    
    [priceLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(nameLabel_.bottom).offset(8);
    }];
    
    [oriPriceLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel_.right).offset(10);
        make.centerY.equalTo(priceLabel_);
    }];
}

- (void)setData:(id)data{
    _data = data;
    if([self.data isKindOfClass:[ELGoodslistModel class]]){
        ELGoodslistModel *model = self.data;
        [imageView_ sd_setImageWithURL:ELIMAGEURL(model.imgUrl)];
        nameLabel_.text = model.name;
        NSString * oriPrice = [NSString stringWithFormat:@"￥%.2f",model.originalPrice];
        NSString *price = [NSString stringWithFormat:@"￥%.2f",model.price];
        priceLabel_.text = DBPRICE(price);
        oriPriceLabel_.attributedText = [DBPRICE(oriPrice) strikeStringWithFont:13 color:EL_TextColor_Light];
        
    }
}
@end
