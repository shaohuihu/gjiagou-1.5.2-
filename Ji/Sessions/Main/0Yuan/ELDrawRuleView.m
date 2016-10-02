
//
//  ELDrawRuleView.m
//  Ji
//
//  Created by evol on 16/6/16.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELDrawRuleView.h"

@implementation ELDrawRuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}

- (void)p_setUp
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    UIView *contentView             = [UIView new];
    contentView.backgroundColor     = [UIColor whiteColor];
    contentView.layer.cornerRadius  = 5;
    contentView.layer.masksToBounds = YES;
    contentView.clipsToBounds       = YES;
    [self addSubview:contentView];
    
    UILabel *topLabel         = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    topLabel.text             = @"开奖规则";
    [contentView addSubview:topLabel];

    UIView *lineView          = [UIView new];
    lineView.backgroundColor  = EL_TextColor_Light;
    [contentView addSubview:lineView];

    UILabel *infoLabel        = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    infoLabel.numberOfLines   = 0;
    infoLabel.text            = @"1、每天到屏幕右上角“签到”处签到，就会获得三个免费抽奖吗，一个抽奖码对应一次抽奖机会。\n\n2、0元购免费抽奖三次，每天晚上八点准时开奖。\n\n3、所有中奖商品由商家免费提供，自中奖之日起3天内请到对应商家自取，过期无效。";
    [contentView addSubview:infoLabel];

    UIView *lineView1         = [UIView new];
    lineView1.backgroundColor = EL_TextColor_Light;
    [contentView addSubview:lineView1];

    UIButton *button          = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonTap) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = kFont_System(15.f);
    [contentView addSubview:button];
    
    WS(ws);
    [topLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(13);
        make.centerY.equalTo(contentView.top).offset(22);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(44);
        make.height.equalTo(0.5);
    }];
    
    [infoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(13);
        make.top.equalTo(lineView.bottom).offset(3);
        make.right.equalTo(contentView).offset(-13);
    }];
    
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLabel.bottom).offset(3);
        make.left.right.equalTo(contentView);
        make.height.equalTo(0.5);
    }];
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(contentView);
        make.top.equalTo(lineView1.bottom);
        make.height.equalTo(44);
    }];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws);
        make.width.equalTo(kRadioValue(250));
    }];
    
    [self addTarget:self action:@selector(onButtonTap) forControlEvents:UIControlEventTouchUpInside];
}


- (void)onButtonTap
{
    [self removeFromSuperview];
}

@end
