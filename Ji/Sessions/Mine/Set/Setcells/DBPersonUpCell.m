//
//  DBPersonUpCell.m
//  Ji
//
//  Created by ssgm on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPersonUpCell.h"

@implementation DBPersonUpCell
{
    UIImageView *imgView_;//图片
    UILabel *titleLabel_;//左边
    UILabel *subLabel_;//右边
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
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    imgView_              = [UIImageView new];
    [self.contentView addSubview:imgView_];
    
    titleLabel_           = [UILabel new];
    titleLabel_.font      = kFont_System(15.f);
    titleLabel_.textColor = EL_TextColor_Dark;
    [self.contentView addSubview:titleLabel_];
    

    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    

    WS(ws);
    [imgView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(0);
        make.centerY.equalTo(ws.contentView);
        make.height.equalTo(ws.contentView).offset(-20);
        make.height.equalTo(kRadioValue(50));
        make.width.equalTo(kRadioValue(50));

    }];
    
    [titleLabel_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).offset(10);
        make.centerY.equalTo(imgView_);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.equalTo(0.5);
    }];

    imgView_.layer.masksToBounds = YES;
    imgView_.layer.cornerRadius = kRadioValue(25);

}


-(void)setTitle:(NSString *)titles{
    titleLabel_.text = titles;
}
-(void)setImageWithUrl:(NSString*)url{
    if (url.length>0) {
        [imgView_ sd_setImageWithURL:ELIMAGEURL(url)];
    }else{
        imgView_.image = [UIImage imageNamed:@"ic_person"];
    }
}
@end
