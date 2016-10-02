//
//  DBShopCollectionCell.m
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBShopCollectionCell.h"
#import "DBShopSaveModel.h"
@implementation DBShopCollectionCell
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    UIButton *_deleteBtn;
    UIImageView *_deleteImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{

    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = EL_TextColor_Dark;
    _nameLabel.font = kFont_System(14);
    [self.contentView addSubview:_nameLabel];
    
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@"ic_person_delete_icon"] forState:UIControlStateNormal];
    _deleteBtn.hidden = YES;
    [_deleteBtn setTitle:@"" forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.contentView addSubview:_deleteBtn];
    
    WS(ws);
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.centerY.equalTo(ws.contentView);
        make.width.equalTo(kRadioValue(44));
        make.height.equalTo(ws.contentView).offset(-16);
        make.height.equalTo(kRadioValue(44));
        
    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.right).offset(10);
        make.centerY.equalTo(ws.contentView);
    }];
    
    [_deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.right.equalTo(-20);
        make.width.equalTo(kRadioValue(36));
        make.height.equalTo(kRadioValue(36));
    }];

}


-(void)o_dataDidChanged{
    
    if ([self.data isKindOfClass:[DBShopSaveModel class]]) {
        DBShopSaveModel *model = (DBShopSaveModel*)self.data;
        _nameLabel.text = model.shopName;
        if (model.shopImg.length>0) {
            [_iconImageView sd_setImageWithURL:ELIMAGEURL(model.shopImg)];
        }
    }
}

-(void)btnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(shopCollectionCell:delete:)]) {
        [self.delegate shopCollectionCell:self delete:btn];
    }
}

-(void)deleteBtnIsHidden:(BOOL)ishidden{
    if (ishidden) {
        _deleteBtn.hidden = YES;
    }else{
        _deleteBtn.hidden = NO;
    
    }
}
@end
