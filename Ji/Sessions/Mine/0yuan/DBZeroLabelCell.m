
//
//  DBZeroLabelCell.m
//  Ji
//
//  Created by sbq on 16/6/12.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBZeroLabelCell.h"

@implementation DBZeroLabelCell


-(void)o_configViews{

    UILabel *label = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    label.numberOfLines = 0;
    [self.contentView addSubview:self.namelabel=label];
    
    WS(ws);
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(ws.contentView).offset(-10);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];
    
}


-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[NSString class]]) {
        NSString *messgae = self.data;
        self.namelabel.text = messgae;
    }
}
@end
