//
//  ELSpecificationCell.m
//  Ji
//
//  Created by evol on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELSpecificationCell.h"
#import "ELGoodsDetailModel.h"
#import "NSString+Tools.h"

@interface ELSpecificationCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *lastButton;

@end

static char modelKey;
@implementation ELSpecificationCell
{
    UIView *topView_;
    UIView *contentView_;
    UIButton *selectButton_;
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
    
    WS(ws);
    [topView_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.contentView);
        make.height.equalTo(30);
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(topView_);
    }];
    
}

- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[ELGoodsSpecification class]]) {
        ELGoodsSpecification *model = self.data;
        self.titleLabel.text = model.name;
        [contentView_.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSArray *arr = model.value;
        if (arr.count > 0) {
            [arr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:obj forState:UIControlStateNormal];
                [button setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [button setBackgroundImage:imageWithColor(EL_BackGroundColor, 1, 1) forState:UIControlStateNormal];
                [button setBackgroundImage:imageWithColor(EL_MainColor, 1, 1) forState:UIControlStateSelected];
                button.layer.cornerRadius = 5;
                button.layer.masksToBounds = YES;
                button.titleLabel.font = kFont_System(14);
                objc_setAssociatedObject(button, &modelKey, obj, OBJC_ASSOCIATION_RETAIN);
                BOOL isSelect = [obj getBool];
                if (isSelect) {
                    selectButton_ = button;
                    button.selected = YES;
                }
                [contentView_ addSubview:button];
                
//                UILabel *label = [ELUtil createLabelFont:13 color:EL_TextColor_Dark];
//                label.text = obj;
//                label.textAlignment = NSTextAlignmentCenter;
//                [button addSubview:label];
                CGFloat leftMaigin = 10;
                CGFloat space = 20;
                CGFloat width = (SCREEN_WIDTH - 2*leftMaigin - 3*space)/4;
                CGFloat height = 30;
                if (idx == arr.count - 1) {
                    [button makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(height);
                        make.width.equalTo(width);
                        make.left.equalTo(leftMaigin + (width+space)*(idx%4));
                        make.top.equalTo(idx/4*(height+space)+5);
                        make.bottom.equalTo(contentView_).offset(-5);
                    }];
                    _lastButton = button;
                    
                }else{
                    [button makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(height);
                        make.width.equalTo(width);
                        make.left.equalTo(leftMaigin + (width+space)*(idx%4));
                        make.top.equalTo(idx/4*(height+space)+5);
                    }];
                }
                
//                [label makeConstraints:^(MASConstraintMaker *make) {
//                    make.center.equalTo(button);
//                    make.left.equalTo(15);
//                    make.right.equalTo(button.right).offset(-8);
//                }];
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
    if (selectButton_) {
        selectButton_.selected = NO;
        NSString * title = (NSString *)objc_getAssociatedObject(selectButton_, &modelKey);
        [title bindBool:NO];
    }
    button.selected = YES;
    selectButton_ = button;
    NSString * title = (NSString *)objc_getAssociatedObject(button, &modelKey);
    [title bindBool:YES];
    ELGoodsSpecification *model = self.data;
    if ([self.delegate respondsToSelector:@selector(specCell:didSelectWithKey:value:)]) {
        [self.delegate specCell:self didSelectWithKey:model.name value:title];
    }
}
@end
