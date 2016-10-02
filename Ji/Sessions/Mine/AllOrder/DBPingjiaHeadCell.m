//
//  DBPingjiaHeadCell.m
//  Ji
//
//  Created by ssgm on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPingjiaHeadCell.h"

@implementation DBPingjiaHeadCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{

    _goodsImageView = [UIImageView new];
    [self.contentView addSubview:_goodsImageView];
    
    _nameLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    _nameLabel.numberOfLines = 0;
    [self.contentView addSubview:_nameLabel];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [_goodsImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(70));
        make.width.equalTo(kRadioValue(70));
        make.height.equalTo(ws.contentView).offset(-20);
    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImageView.right).offset(10);
        make.top.equalTo(10);
        make.right.equalTo(-5);
    }];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.equalTo(0.5);
    }];
    
}

-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[Goods_List class]]) {
        Goods_List *goods = self.data;
        if (goods.goodsImage.length>0) {
            [self.goodsImageView sd_setImageWithURL:ELIMAGEURL(goods.goodsImage)];
        }
        self.nameLabel.text = goods.goodsName;
    }

}
@end
