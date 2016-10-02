//
//  DBPersionDownCell.m
//  Ji
//
//  Created by ssgm on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPersionDownCell.h"

@implementation DBPersionDownCell
{
//    UIImageView *imgView_;//图片
    UILabel *titleLabel_;//左边
    UILabel *subLabel_;//右边
}
- (void)o_configViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    imgView_              = [UIImageView new];
//    [self.contentView addSubview:imgView_];
    
    titleLabel_           = [UILabel new];
    titleLabel_.font      = kFont_System(15.f);
    titleLabel_.textColor = EL_TextColor_Dark;
    [self.contentView addSubview:titleLabel_];
    
    subLabel_ = [ELUtil createLabelFont:14 color:EL_TextColor_Light];
    [self.contentView addSubview:subLabel_];
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
//    [imgView_ mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(15);
//        make.centerY.equalTo(ws.contentView);
//    }];
    
    [titleLabel_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).offset(10);
        make.centerY.equalTo(ws);
    }];
    
    [subLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.right.equalTo(ws.contentView).offset(-5);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.equalTo(0.5);
    }];
}


-(void)setTitle:(NSString *)titles{
    titleLabel_.text = titles;
}
-(void)setRightLabel:(NSString *)rights{
    subLabel_.text = rights;
}
@end
