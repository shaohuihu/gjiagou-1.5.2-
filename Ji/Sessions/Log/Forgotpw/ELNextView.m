//
//  ELNextView.m
//  Ji
//
//  Created by sbq on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELNextView.h"

@implementation ELNextView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.tipLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 30)];
    self.tipLabel.text = @"请输入8-16位数字和字母组合";
    self.tipLabel.textColor = EL_TextColor_Light;
    self.tipLabel.font = kFont_System(12);
    [self addSubview:self.tipLabel];

    self.okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okBtn.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, kRadioValue(35));
    [self.okBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.okBtn.titleLabel.font = kFont_System(16);
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okBtn setBackgroundImage:[UIImage imageNamed:@"ic_login_button"] forState:UIControlStateNormal];
    [self addSubview:self.okBtn];

    
}



@end
