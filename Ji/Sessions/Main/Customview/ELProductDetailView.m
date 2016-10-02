//
//  ELProductDetailView.m
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELProductDetailView.h"

@implementation ELProductDetailView
{
    UIImageView *imageView_;
    UILabel *nameLabel_;
    UILabel *priceLabel_;
    UILabel *strikeLabel_;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_configView];
    }
    return self;
}

-(void)p_configView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    imageView_ = [UIImageView new];
    [self addSubview:imageView_];
    
    nameLabel_ = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    nameLabel_.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel_];
    
    
    priceLabel_ = [ELUtil createLabelFont:13.f color:EL_MainColor];
    priceLabel_.textAlignment = NSTextAlignmentCenter;
    [self addSubview:priceLabel_];
    
    strikeLabel_ = [UILabel new];
    [self addSubview:strikeLabel_];
    
    WS(ws);
    [imageView_ makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(8);
        make.left.equalTo(12);
        make.right.equalTo(ws).offset(-12);
        make.height.equalTo(imageView_.width);
    }];
    
    [nameLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(ws).offset(-10);
        make.top.equalTo(imageView_.bottom).offset(20);
    }];

    [priceLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws).offset(-10);
        make.left.equalTo(6);
        make.top.equalTo(nameLabel_.bottom).offset(8);
    }];
    
    [strikeLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).offset(-6);
        make.bottom.equalTo(priceLabel_);
    }];
}


- (void)setGood:(ELMainGood *)good{
    _good = good;
    [imageView_ sd_setImageWithURL:ELIMAGEURL(good.imgUrl)];
    nameLabel_.text = good.name;
    NSString *oriPrice;
    if (good.price >= 1000.0) {
        priceLabel_.text = [NSString stringWithFormat:@"￥%.0f",good.price];
    }else{
        NSString *price = [NSString stringWithFormat:@"￥%.2f",good.price];
        priceLabel_.text = DBPRICE(price);
    }
//    if ([good.originalPrice isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *tmp = good.originalPrice
//        good.originalPrice
//    }
//    if (good.originalPrice.doubleValue > 1000.0) {
//        oriPrice = [NSString stringWithFormat:@"￥%.0f",good.originalPrice.doubleValue];
//    }else{
//        oriPrice = [NSString stringWithFormat:@"￥%.1f",good.originalPrice.doubleValue];
//    }
    
    if (good.originalPrice > 1000.0) {
        oriPrice = [NSString stringWithFormat:@"￥%.0f",good.originalPrice];
    }else{
        oriPrice = [NSString stringWithFormat:@"￥%.2f",good.originalPrice];
    }
    strikeLabel_.attributedText = [DBPRICE(oriPrice) strikeStringWithFont:13 color:EL_TextColor_Light];
}

@end
