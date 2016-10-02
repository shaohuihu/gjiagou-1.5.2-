//
//  ELWinnerCell.m
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELWinnerCell.h"
#import "ELWinnerModel.h"
#import "ELWinnerItemView.h"

@implementation ELWinnerCell
{
    UIView *topView_;
    UIView *contentView_;
    NSInteger selectIndex_;
}

- (void)o_configViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    topView_ = [UIView new];
    [self.contentView addSubview:topView_];
    
    UIView *topItemView = [UIView new];
    topItemView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [topView_ addSubview:topItemView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_zero_line"]];
    [topItemView addSubview:leftView];
    
    UILabel *leftLabel = [ELUtil createLabelFont:14.f color:UIColorFromRGB(0xe7a343)];
    leftLabel.text = @"中奖名名单";
    [topItemView addSubview:leftLabel];
    
    UIView *topTitlesView = [UIView new];
    topTitlesView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [topView_ addSubview:topTitlesView];
    
    UILabel *tip1 = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    tip1.text = @"用户名";
    [topTitlesView addSubview:tip1];
    
    UILabel *tip2 = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    tip2.text = @"地区";
    [topTitlesView addSubview:tip2];
    
    UILabel *tip3  = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    tip3.text = @"奖品";
    [topTitlesView addSubview:tip3];

    //
    WS(ws);
    [topView_ makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.contentView);
    }];
    
    [topItemView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(3.5);
        make.left.right.equalTo(topView_);
    }];
    
    [leftView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(topItemView);
    }];
    
    [leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView.right).offset(8);
        make.centerY.equalTo(topItemView);
    }];
    
    [topTitlesView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topItemView.bottom).offset(kRadioXValue(4));
        make.left.right.bottom.equalTo(topView_);
        make.height.equalTo(40);
    }];
    
    [tip1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioValue(20));
        make.centerY.equalTo(topTitlesView);
    }];
    [tip2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioValue(95));
        make.centerY.equalTo(topTitlesView);
    }];
    [tip3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioValue(210));
        make.centerY.equalTo(topTitlesView);
    }];

    contentView_ = [UIView new];
    [self.contentView addSubview:contentView_];
}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[NSArray class]]) {
        NSArray<ELWinnerModel *> *array = self.data;
        __block UIView *lastView;
        [array enumerateObjectsUsingBlock:^(ELWinnerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ELWinnerItemView *itemView = [[ELWinnerItemView alloc] init];
            [itemView setName:obj.userName area:obj.areaName lottery:obj.goodsName];
            [contentView_ addSubview:itemView];
            
            if (idx == array.count - 1) {
                [itemView makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.top.equalTo(lastView.bottom);
                    }else{
                        make.top.equalTo(contentView_);
                    }
                    make.left.right.equalTo(contentView_);
                    make.height.equalTo(30);
                    make.bottom.equalTo(contentView_);
                }];
            }else{
                [itemView makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.top.equalTo(lastView.bottom);
                    }else{
                        make.top.equalTo(contentView_);
                    }
                    make.left.right.equalTo(contentView_);
                    make.height.equalTo(30);
                }];
            }
            lastView = itemView;
        }];
    }
}


- (void)updateConstraints{
    [super updateConstraints];
    WS(ws);
    [contentView_ makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView_.bottom);
        make.left.right.bottom.equalTo(ws.contentView);
    }];
}
@end
