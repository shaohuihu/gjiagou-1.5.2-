//
//  DBGoodsCell.m
//  Ji
//
//  Created by ssgm on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBGoodsCell.h"

@implementation DBGoodsCell
{
    UIView *view_left;
    UIImageView *imageView_left;
    UILabel *titleLabel_left;
    UITapGestureRecognizer *tap_left;

    
    UIView *view_right;
    UIImageView *imageView_right;
    UILabel *titleLabel_right;
    UITapGestureRecognizer *tap_right;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    
    view_left = [UIView new];
    [self.contentView addSubview:view_left];
    
    imageView_left = [UIImageView new];
    [view_left addSubview:imageView_left];
    
    titleLabel_left = [UILabel new];
    titleLabel_left.font = kFont_System(13);
    titleLabel_left.textColor = EL_TextColor_Dark;
    [view_left addSubview:titleLabel_left];

    view_right = [UIView new];
    [self.contentView addSubview:view_right];

    imageView_right = [UIImageView new];
    [view_right addSubview:imageView_right];
    
    titleLabel_right = [UILabel new];
    titleLabel_right.font = kFont_System(13);
    titleLabel_right.textColor = EL_TextColor_Dark;
    [view_right addSubview:titleLabel_right];

    
    UIView *lineshu = [UIView new];
    lineshu.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineshu];
    
    UIView *lineheng = [UIView new];
    lineheng.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineheng];
    
    WS(ws);
    [view_left makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.height.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(85));
        make.width.equalTo(SCREEN_WIDTH/2);
    }];
    
    [imageView_left makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view_left).offset(8);
        make.top.equalTo(view_left).offset(8);
        make.right.equalTo(view_left).offset(-8);
        make.height.equalTo(38);
    }];
    
    [titleLabel_left makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView_left.bottom);
        make.left.equalTo(imageView_left);
        make.right.equalTo(imageView_left);
        make.bottom.equalTo(view_left);
    }];
    
    
    
    
    [view_right makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2);
        make.height.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(85));
        make.width.equalTo(SCREEN_WIDTH/2);
    }];
    
    [imageView_right makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view_right).offset(8);
        make.top.equalTo(view_right).offset(8);
        make.right.equalTo(view_right).offset(-8);
        make.height.equalTo(38);
    }];
    
    [titleLabel_right makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView_right.bottom);
        make.left.equalTo(imageView_right);
        make.right.equalTo(imageView_right);
        make.bottom.equalTo(view_right);
    }];
    
    
    [lineshu makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.contentView);
        make.width.equalTo(0.5);
        make.height.equalTo(ws.contentView);
    }];
    [lineheng makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];
    
    
    tap_left = [[UITapGestureRecognizer alloc]init];
    [tap_left addTarget:self action:@selector(tapView:)];
    [view_left addGestureRecognizer:tap_left];
    
    tap_right = [[UITapGestureRecognizer alloc]init];
    [tap_right addTarget:self action:@selector(tapView:)];
    [view_right addGestureRecognizer:tap_right];
}


-(void)tapView:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(dbGoodsCell:selectAtIndex:)]) {
        NSInteger index ;
        if (tap==tap_left) {
            index = 0;
        }else{
            index = 1;
        }
        [self.delegate dbGoodsCell:self selectAtIndex:index];
    }

}
//UIView *view_left;
//UIImageView *imageView_left;
//UILabel *titleLabel_left;
//UITapGestureRecognizer *tap_left;
-(void)setDataForleft:(DBZeroModel *)leftModel right:(DBZeroModel *)rightModel{
    //判断基数
    if (rightModel==nil && leftModel!=nil) {
        view_right.hidden = YES;
        view_left.hidden = NO;
        if (leftModel.goodsPicture.length>0) {
            [imageView_left sd_setImageWithURL:ELIMAGEURL(leftModel.goodsPicture)];
        }
        titleLabel_left.text = [NSString stringWithFormat:@"%@",leftModel.goodsName];
    }
    if (leftModel!=nil && rightModel!=nil) {
        view_right.hidden = NO;
        view_left.hidden = NO;
        if (leftModel.goodsPicture.length>0) {
            [imageView_left sd_setImageWithURL:ELIMAGEURL(leftModel.goodsPicture)];
        }
        titleLabel_left.text = [NSString stringWithFormat:@"%@",leftModel.goodsName];
        
        if (rightModel.goodsPicture.length>0) {
            [imageView_right sd_setImageWithURL:ELIMAGEURL(rightModel.goodsPicture)];
        }
        titleLabel_right.text = [NSString stringWithFormat:@"%@",rightModel.goodsName];
    }
}
@end
