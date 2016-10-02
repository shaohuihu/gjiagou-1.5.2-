//
//  ELRegFooterView.m
//  Ji
//
//  Created by ssgm on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRegFooterView.h"

@implementation ELRegFooterView

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
    self.okBtn.frame = CGRectMake(10, CGRectGetMaxY(self.tipLabel.frame)+50, SCREEN_WIDTH-20, kRadioValue(35));
    [self.okBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.okBtn.titleLabel.font = kFont_System(16);
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okBtn setBackgroundImage:[UIImage imageNamed:@"ic_login_button"] forState:UIControlStateNormal];
    [self addSubview:self.okBtn];
    
    
    self.xieyiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.okBtn.frame)+5, SCREEN_WIDTH-100, 25)];
    self.xieyiLabel.textAlignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"注册即视为同意济佳购平台服务协议"];
    [str addAttribute:NSForegroundColorAttributeName value:EL_TextColor_Dark range:NSMakeRange(0,7)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7,9)];

    [str addAttribute:NSFontAttributeName value:kFont_System(12) range:NSMakeRange(0, 7)];
    [str addAttribute:NSFontAttributeName value:kFont_System(13) range:NSMakeRange(7, 9)];
    self.xieyiLabel.attributedText = str;
    [self addSubview:self.xieyiLabel];
    
    
    self.xieyiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xieyiBtn.frame = self.xieyiLabel.frame;
    [self.xieyiBtn setTitle:@"" forState:UIControlStateNormal];
    [self.xieyiBtn setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    self.xieyiBtn.titleLabel.font = kFont_System(14);
    [self addSubview:self.xieyiBtn];
    
}


@end
