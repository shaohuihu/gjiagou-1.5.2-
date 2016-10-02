//
//  ELLoginFooterView.m
//  Ji
//
//  Created by sbq on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELLoginFooterView.h"

@implementation ELLoginFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(10, 15, SCREEN_WIDTH-20, kRadioValue(35));
//    [self.loginBtn setImage:[UIImage imageNamed:@"ic_login_button"] forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = kFont_System(16);
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"ic_login_button"] forState:UIControlStateNormal];
    [self addSubview:self.loginBtn];
    
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(10, CGRectGetMaxY(self.loginBtn.frame)+5, 60, kRadioValue(35));
    [self.registerBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = kFont_System(14);
    [self addSubview:self.registerBtn];
    
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetBtn.frame = CGRectMake(SCREEN_WIDTH-70, CGRectGetMaxY(self.loginBtn.frame)+5, 60, kRadioValue(35));
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = kFont_System(14);
    [self addSubview:self.forgetBtn];
    
    [self.loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    

}
-(void)btnClick:(UIButton*)btn{

    if ([self.delegate respondsToSelector:@selector(touchWithBtn:)]) {
        [self.delegate touchWithBtn:btn];
    }
}
@end
