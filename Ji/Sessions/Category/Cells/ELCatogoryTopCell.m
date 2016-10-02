//
//  ELCatogoryTopCell.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCatogoryTopCell.h"
#import "ELTopCatoryModel.h"

@implementation ELCatogoryTopCell
{
    UILabel *titleLabel_;
}


- (void)o_configViews{
    titleLabel_ = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    titleLabel_.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel_];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_TextColor_Light;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [titleLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
        make.height.equalTo(44);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(ws.contentView);
        make.height.equalTo(1);
    }];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        titleLabel_.textColor = EL_MainColor;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else{
        titleLabel_.textColor = EL_TextColor_Dark;
        self.contentView.backgroundColor = EL_BackGroundColor;
    }
}

- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[ELTopCatoryModel class]]) {
        ELTopCatoryModel *model = self.data;
        titleLabel_.text = model.name;
    }
}

@end
