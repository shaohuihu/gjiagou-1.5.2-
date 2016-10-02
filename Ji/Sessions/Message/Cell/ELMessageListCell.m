//
//  ELMessageListCell.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMessageListCell.h"
#import "ELMessageListModel.h"
#import "ELMessageModel+bind.h"

@interface ELMessageListCell ()

@property (nonatomic, weak) UIButton *checkoutButton;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation ELMessageListCell

- (void)o_configViews{
    
    
    UIButton *checkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_unchecked"] forState:UIControlStateNormal];
    [checkoutButton setImage:[UIImage imageNamed:@"ic_checked"] forState:UIControlStateSelected];
    [checkoutButton addTarget:self action:@selector(onCheckoutButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.checkoutButton = checkoutButton];
    
    UIImageView *icon = [UIImageView new];
    [self.contentView addSubview: self.icon = icon];
    
    UILabel *nameLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel = nameLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-13);
        make.centerY.equalTo(ws.contentView);
    }];
    
    [checkoutButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView.left).offset(kRadioXValue(13.f));
        make.centerY.equalTo(ws.contentView);
    }];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(checkoutButton.right).offset(10);
        make.centerY.equalTo(ws.contentView);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];
    
}


- (void)onCheckoutButtonTap:(UIButton *)button {
    button.selected = !button.selected;
    ELMessageModel *model = self.data;
    [model bindBool:button.selected];
    if ([self.delegate respondsToSelector:@selector(listCellDidSelect:)]) {
        [self.delegate listCellDidSelect:self];
    }
}


- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[ELMessageModel class]]) {
        ELMessageModel *model = self.data;
        self.nameLabel.text = model.messageTitle;
        if (model.readStatus == 0) {
            self.icon.image = [UIImage imageNamed:@"ic_arrow_small_right"];//未读
        }else{
            self.icon.image = [UIImage imageNamed:@"ic_notice_checkmark"];//已读
        }
        self.checkoutButton.selected = [model getBool];
    }
}

@end
