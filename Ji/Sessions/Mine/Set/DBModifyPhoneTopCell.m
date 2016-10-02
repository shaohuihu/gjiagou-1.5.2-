//
//  DBModifyPhoneTopCell.m
//  Ji
//
//  Created by ssgm on 16/6/16.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBModifyPhoneTopCell.h"

@implementation DBModifyPhoneTopCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{

    UILabel *tip = [ELUtil createLabelFont:13 color:EL_TextColor_Dark];
    tip.text = @"发送验证码到手机";
    [self.contentView addSubview:self.tipLabel=tip];
    
    UILabel *phone =[ELUtil createLabelFont:18 color:EL_TextColor_Dark];
    [self.contentView addSubview:self.phoneLabel=phone];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [tip makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(0);
        make.height.equalTo(kRadioValue(30));
        make.height.equalTo(ws.contentView).offset(kRadioValue(-50));
    }];
    
    [phone makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.top.equalTo(tip.bottom);
        make.height.equalTo(kRadioValue(50));
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];

}


@end
