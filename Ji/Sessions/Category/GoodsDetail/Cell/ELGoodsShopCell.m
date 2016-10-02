//
//  ELGoodsShopCell.m
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodsShopCell.h"
#import "ELGoodsDetailModel.h"

@interface ELGoodsShopCell ()

@property (nonatomic, weak) UIImageView *shopIcon;
@property (nonatomic, weak) UILabel *shopName;
@property (nonatomic, weak) UILabel *goodsCount;
@property (nonatomic, weak) UILabel *attentionCount;

@end

@implementation ELGoodsShopCell

- (void)o_configViews
{
    UIImageView *shopIcon = [UIImageView new];
    
    UILabel *shopName = [ELUtil createLabelFont:14. color:EL_TextColor_Light];
    
    UILabel *goodsCount = [ELUtil createLabelFont:14 color:EL_TextColor_Light];
    goodsCount.text = @"0";
    
    UILabel *attentionCount = [ELUtil createLabelFont:14 color:EL_TextColor_Light];
    attentionCount.text = @"0";
    
    [self.contentView addSubview:self.shopIcon = shopIcon];
    [self.contentView addSubview:self.shopName = shopName];
    [self.contentView addSubview:self.goodsCount = goodsCount];
    [self.contentView addSubview:self.attentionCount = attentionCount];
    
    UILabel *fixAllGoods = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    fixAllGoods.text = @"全部宝贝";
    [self.contentView addSubview:fixAllGoods];
    
    UILabel *fixAttention = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    fixAttention.text = @"关注人数";
    [self.contentView addSubview:fixAttention];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    __block NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:0];
    [@[@"电话咨询",@"查看分类",@"进店逛逛"] enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"ic_butn_line_2"] forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
        button.titleLabel.font = kFont_System(13.f);
        button.tag = idx;
        [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        [buttons addObject:button];
    }];
    
    WS(ws);
    CGFloat width = kRadioValue(120);
    CGFloat height = width * 6/16;
    [shopIcon makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(width, height));
        make.left.equalTo(13);
        make.top.equalTo(13);
    }];
    
    [shopName makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopIcon);
        make.left.equalTo(shopIcon.right).offset(13);
    }];
    
    [goodsCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView).multipliedBy(0.5);
        make.top.equalTo(shopIcon.bottom).offset(25);
    }];
    
    [attentionCount makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsCount);
        make.centerX.equalTo(ws.contentView).multipliedBy(1.5);
    }];
    
    [fixAllGoods makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsCount.bottom).offset(10);
        make.centerX.equalTo(goodsCount);
    }];
    
    [fixAttention makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(attentionCount);
        make.top.equalTo(fixAllGoods);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.width.equalTo(0.5);
        make.top.equalTo(goodsCount.top).offset(-6);
        make.bottom.equalTo(fixAllGoods.bottom).offset(6);
    }];
    
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:40 tailSpacing:40];
    [buttons makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(10);
        make.height.equalTo(25);
        make.bottom.equalTo(ws.contentView).offset(-15);
    }];
}


- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[ELGoodsDetailModel class]]) {
        ELGoodsDetailModel *model = self.data;
        [self.shopIcon sd_setImageWithURL:ELIMAGEURL(model.shopInfo.shopLogo)];
        self.shopName.text = model.shopInfo.shopName;
        self.goodsCount.text = model.shopInfo.goodsNum;
        self.attentionCount.text = model.shopInfo.collNum;
    }
}

- (void)onButtonTap:(UIButton *)button {
    switch (button.tag) {
        case 0:
        {
            if ([self.delegate respondsToSelector:@selector(shopCellOnContactTap)]) {
                [self.delegate shopCellOnContactTap];
            }
        }
            break;
        case 1:
        {
            if ([self.delegate respondsToSelector:@selector(shopCellOnShopCategoryTap)]) {
                [self.delegate shopCellOnShopCategoryTap];
            }
        }
            break;
        case 2:
        {
            if ([self.delegate respondsToSelector:@selector(shopCellOnShopInfoTap)]) {
                [self.delegate shopCellOnShopInfoTap];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
