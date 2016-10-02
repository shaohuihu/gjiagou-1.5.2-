//
//  DBPingjiaAddPicCell.m
//  Ji
//
//  Created by ssgm on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPingjiaAddPicCell.h"

@implementation DBPingjiaAddPicCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"ic_butn_add_pic"] forState:UIControlStateNormal];
    [_addBtn setTitle:@"   添加晒单图片" forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.titleLabel.font = kFont_System(13);
     [self.contentView addSubview:_addBtn];
    
    WS(ws);
    [_addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.contentView);
        
        make.height.equalTo(kRadioValue(28));
        make.width.equalTo(kRadioValue(140));
    }];
}


-(void)add:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(cell:addBtnClick:)]) {
        [self.delegate cell:self addBtnClick:btn];
    }
}

-(void)o_dataDidChanged{


}
@end
