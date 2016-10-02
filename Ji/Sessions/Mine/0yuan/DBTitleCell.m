//
//  DBTitleCell.m
//  Ji
//
//  Created by ssgm on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBTitleCell.h"

@implementation DBTitleCell{

    UILabel *titleLabel_;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    self.contentView.backgroundColor = [UIColor whiteColor];    
    titleLabel_           = [UILabel new];
    titleLabel_.font      = kFont_System(15.f);
    titleLabel_.textColor = EL_TextColor_Dark;
    [self.contentView addSubview:titleLabel_];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [titleLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(15);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.equalTo(0.5);
    }];

}

-(void)o_dataDidChanged{
    
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        titleLabel_.text = [self.data stringForKey:@"title"];
    }
}
@end
