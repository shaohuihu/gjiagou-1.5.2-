//
//  DBPayCell.m
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPayCell.h"

@implementation DBPayCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{

    
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.payBtn setTitle:@"付款" forState:UIControlStateNormal];
    [self.payBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = kFont_System(14);
    [self.payBtn setBackgroundImage:[UIImage imageNamed:@"ic_butn_line_3"] forState:UIControlStateNormal];
    [self.payBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.payBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = kFont_System(14);
    [self.cancelBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];

    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"ic_butn_line_2"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.cancelBtn];
    

    
    WS(ws);
    
    [self.payBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.right.equalTo(-10);
        make.bottom.equalTo(-10);
        make.height.equalTo(kRadioValue(26));
        make.width.equalTo(kRadioValue(90));
    }];
    
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.payBtn.left).offset(-10);
        make.centerY.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(26));
        make.width.equalTo(kRadioValue(90));

    }];
    
}


-(void)o_dataDidChanged{



}
-(void)btn:(UIButton*)btn{

    if ([self.delegate respondsToSelector:@selector(payCell:click:)]) {
        [self.delegate payCell:self click:btn];
    }
}

@end
