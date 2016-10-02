//
//  ELShopSearchCell.m
//  Ji
//
//  Created by evol on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopSearchCell.h"
#import "ELShopSearchModel.h"
#import <objc/runtime.h>

@interface ELShopSearchCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *lastButton;

@end

static char modelKey;

@implementation ELShopSearchCell
{
    UIView *topView_;
    UIView *contentView_;

}
- (void)o_configViews{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    topView_ = [UIView new];
    [self.contentView addSubview:topView_];
    
    contentView_ = [UIView new];
    [self.contentView addSubview:contentView_];
    
    UILabel *label = [UILabel new];
    label.font = kFont_Bold(15.f);
    label.textColor = EL_TextColor_Dark;
    [topView_ addSubview:self.titleLabel = label];
    
    UIButton *subLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [subLabel setTitle:@"查看全部" forState:UIControlStateNormal];
    [subLabel setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    [subLabel addTarget:self action:@selector(onAllProTap) forControlEvents:UIControlEventTouchUpInside];
    [subLabel sizeToFit];
    subLabel.titleLabel.font = kFont_System(14.f);
    [topView_ addSubview:subLabel];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_small_right"]];
    [topView_ addSubview:icon];
    
    WS(ws);
    [topView_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.contentView);
        make.height.equalTo(40);
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(topView_);
    }];
    
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView_);
        make.right.equalTo(topView_).offset(-15);
    }];
    
    [subLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView_);
        make.right.equalTo(icon.left).offset(-10);
    }];
        
}

- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[ELShopSearchModel class]]) {
        _lastButton = nil;
        ELShopSearchModel *model = self.data;
        self.titleLabel.text = model.name;
        [contentView_.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSArray *arr = model.childList;
        if (arr.count > 0) {
            [arr enumerateObjectsUsingBlock:^(ELChildlistModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.backgroundColor = EL_BackGroundColor;
                [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
                objc_setAssociatedObject(button, &modelKey, obj, OBJC_ASSOCIATION_RETAIN);
                [contentView_ addSubview:button];
                
                UILabel *label = [ELUtil createLabelFont:13 color:EL_TextColor_Dark];
                label.text = obj.name;
                [button addSubview:label];
                
                CGFloat width = (SCREEN_WIDTH - 5)/2;
                CGFloat height = 44;
                
                WS(ws);
                if (idx == arr.count - 1) {
                    if (idx%2 == 0) {
                        [button makeConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(height);
                            make.width.equalTo(width);
                            make.left.equalTo(ws.contentView);
                            make.top.equalTo(idx/2*(height+5));
                            make.bottom.equalTo(contentView_).offset(-5);
                        }];
                    }else{
                        [button makeConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(height);
                            make.width.equalTo(width);
                            make.right.equalTo(ws.contentView);
                            make.top.equalTo(idx/2*(height+5));
                            make.bottom.equalTo(contentView_).offset(-5);
                        }];
                    }
                    _lastButton = button;
                    
                }else{
                    if (idx%2 == 0) {
                        [button makeConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(height);
                            make.width.equalTo(width);
                            make.left.equalTo(ws.contentView);
                            make.top.equalTo(idx/2*(height+5));
                        }];
                    }else{
                        [button makeConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(height);
                            make.width.equalTo(width);
                            make.right.equalTo(ws.contentView);
                            make.top.equalTo(idx/2*(height+5));
                        }];
                    }
                }
                
                [label makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(button);
                    make.left.equalTo(10);
//                    make.right.equalTo(button.right).offset(-8);
                }];
            }];
        }
    }
}

- (void)updateConstraints{
    [super updateConstraints];
    WS(ws);
    [contentView_ makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView_.bottom);
        make.left.right.bottom.equalTo(ws.contentView);
    }];
}


- (void)onButtonTap:(UIButton *)button
{
    ELChildlistModel * model = (ELChildlistModel *)objc_getAssociatedObject(button, &modelKey);
    if ([self.delegate respondsToSelector:@selector(shopCellDidSelectWithModel:)]) {
        [self.delegate shopCellDidSelectWithModel:model];
    }
}

- (void)onAllProTap {
    if ([self.delegate respondsToSelector:@selector(shopCellPresentAllProducts:)]) {
        [self.delegate shopCellPresentAllProducts:self.data];
    }
}

@end
