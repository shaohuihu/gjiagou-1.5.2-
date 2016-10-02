//
//  ELMineSubCell.m
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMineSubCell.h"

@implementation ELMineSubCell
{
    UILabel *titleLabel_;
    UILabel *subLabel_;
}
- (void)o_configViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    [titleLabel_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(ws.contentView);
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

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        titleLabel_.text = [self.data stringForKey:@"title"];
    }
}

@end
