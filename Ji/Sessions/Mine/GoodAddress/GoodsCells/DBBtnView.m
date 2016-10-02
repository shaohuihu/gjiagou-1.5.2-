
//
//  DBBtnView.m
//  Ji
//
//  Created by sbq on 16/5/22.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBBtnView.h"

@implementation DBBtnView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)awakeFromNib{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
    self.img = [UIImageView new];
    [self addSubview:self.img];
    
    self.name = [UILabel new];
    self.name.font = kFont_System(13);
    self.name.textColor = EL_TextColor_Light;
    [self addSubview:self.name];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"" forState:UIControlStateNormal];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"ic_butn_edit"] forState:UIControlStateNormal];
    [self addSubview:self.btn];
    
    WS(ws);
    [self.img makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.left.equalTo(8);
        make.bottom.equalTo(-5);
        make.width.equalTo(ws.img.height);
    }];
    
    [self.name makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.equalTo(ws).offset(-5);
        make.bottom.equalTo(0);
    }];

    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (void)drawRect:(CGRect)rect {
    
    
    
}

@end


