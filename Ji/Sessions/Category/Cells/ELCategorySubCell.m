
//
//  ELCategorySubCell.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCategorySubCell.h"
#import "ELTopCatoryModel.h"
#import <objc/runtime.h>

@interface ELCategorySubCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *lastButton;
@end


static char modelKey;

@implementation ELCategorySubCell
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
    label.font = kFont_Bold(14.f);
    label.textColor = EL_TextColor_Dark;
    [topView_ addSubview:self.titleLabel = label];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = EL_MainColor;
    [topView_ addSubview:lineView];
    WS(ws);
    [topView_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.contentView);
        make.height.equalTo(40);
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(topView_);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label);
        make.top.equalTo(label.bottom).offset(2);
        make.height.equalTo(2);
    }];
    
}

- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        _lastButton = nil;
        ELTopCatoryModel *model = self.data[@"model"];
        self.titleLabel.text = model.name;
        [contentView_.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSArray *arr = self.data[@"values"];
        if (arr.count > 0) {
            [arr enumerateObjectsUsingBlock:^(ELTopCatoryModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
                objc_setAssociatedObject(button, &modelKey, obj, OBJC_ASSOCIATION_RETAIN);
                [contentView_ addSubview:button];

                UILabel *label = [ELUtil createLabelFont:13 color:EL_TextColor_Dark];
                label.text = obj.name;
                if (obj.isHot) {
                    label.textColor = EL_MainColor;
                }
                label.textAlignment = NSTextAlignmentCenter;
                [button addSubview:label];
                
                CGFloat width = (SCREEN_WIDTH*25/32)/3;
                CGFloat height = 30;
                if (idx == arr.count - 1) {
                    [button makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(height);
                        make.width.equalTo(self.contentView).multipliedBy(1.0/3);
                        make.left.equalTo(width*(idx%3));
                        make.top.equalTo(idx/3*height+5);
                        make.bottom.equalTo(contentView_).offset(-5);
                    }];
                    _lastButton = button;

                }else{
                    [button makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(height);
                        make.width.equalTo(self.contentView).multipliedBy(1.0/3);
                        make.left.equalTo(width*(idx%3));
                        make.top.equalTo(idx/3*height+5);
                    }];
                }
                
                [label makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(button);
                    make.left.equalTo(15);
                    make.right.equalTo(button.right).offset(-8);
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

- (void)onButtonTap:(UIButton *)button{
    ELTopCatoryModel * model = (ELTopCatoryModel *)objc_getAssociatedObject(button, &modelKey);
    if ([self.delegate respondsToSelector:@selector(cellDidSelectWithModel:)]) {
        [self.delegate cellDidSelectWithModel:model];
    }
}

@end
