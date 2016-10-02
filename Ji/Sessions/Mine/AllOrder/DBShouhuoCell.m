//
//  DBShouhuoCell.m
//  Ji
//
//  Created by ssgm on 16/6/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBShouhuoCell.h"

@implementation DBShouhuoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    self.shouhuoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shouhuoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.shouhuoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.shouhuoBtn.titleLabel.font = kFont_System(14);
    [self.shouhuoBtn setBackgroundImage:[UIImage imageNamed:@"ic_butn_line_3"] forState:UIControlStateNormal];
    [self.shouhuoBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.shouhuoBtn];
    WS(ws);
    
    [self.shouhuoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.right.equalTo(-10);
        make.bottom.equalTo(-10);
        make.height.equalTo(kRadioValue(26));
        make.width.equalTo(kRadioValue(90));
    }];

}

-(void)btn:(UIButton*)btn{
    
    if ([self.delegate respondsToSelector:@selector(shouhuoCell:click:)]) {
        [self.delegate shouhuoCell:self click:btn];
    }
}
-(void)o_dataDidChanged{


}
@end
