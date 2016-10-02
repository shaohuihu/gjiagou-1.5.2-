//
//  DBGoodSaveCell.m
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBGoodSaveCell.h"
#import "DBGoodSaveModel.h"
@implementation DBGoodSaveCell

{
    UIImageView *imageView_;
    UILabel     *nameLabel_;
    UILabel     *priceLabel_;
    UIButton    *deleteBtn_;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self p_configView];
    }
    return self;
}


- (void)p_configView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    imageView_ = [UIImageView new];
    imageView_.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView_];
    
    nameLabel_ = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    nameLabel_.textAlignment = NSTextAlignmentCenter;
    nameLabel_.numberOfLines = 0;
    [self.contentView addSubview:nameLabel_];
    
    
    priceLabel_ = [ELUtil createLabelFont:14.f color:EL_MainColor];
    priceLabel_.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:priceLabel_];
    
    deleteBtn_ = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn_ setImage:[UIImage imageNamed:@"ic_person_delete_icon"] forState:UIControlStateNormal];
//    [deleteBtn_ setBackgroundImage:[UIImage imageNamed:@"ic_person_delete_icon"] forState:UIControlStateNormal];
    deleteBtn_.hidden = YES;
    [deleteBtn_ addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleteBtn_];
    
    WS(ws);
    [imageView_ makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(8);
        make.left.equalTo(8);
        make.right.equalTo(ws.contentView).offset(-8);
        make.height.equalTo(imageView_.width);
    }];
    
    [deleteBtn_ makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView_.right);
        make.centerY.equalTo(imageView_.top);
        make.width.equalTo(kRadioValue(40));
        make.height.equalTo(kRadioValue(40));
    }];
    
    [nameLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.lessThanOrEqualTo(35);
        make.top.equalTo(imageView_.bottom).offset(8);
    }];
    
    [priceLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(ws.contentView).offset(-10);
        make.top.equalTo(nameLabel_.bottom).offset(8);
    }];
}

- (void)setData:(id)data{
    _data = data;
    if([self.data isKindOfClass:[DBGoodSaveModel class]]){
        DBGoodSaveModel *model = self.data;
        [imageView_ sd_setImageWithURL:ELIMAGEURL(model.goodsImg)];
        nameLabel_.text = model.goodsName;
        NSString *string = [NSString stringWithFormat:@"￥%.2f",model.price];
        priceLabel_.text= DBPRICE(string);
    }
}


-(void)btnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(goodsSaveCell:delete:)]) {
        [self.delegate goodsSaveCell:self delete:btn];
    }
}

-(void)deleteBtnIsHidden:(BOOL)ishidden{
    if (ishidden) {
        deleteBtn_.hidden = YES;
    }else{
        deleteBtn_.hidden = NO;
        
    }
}
@end
