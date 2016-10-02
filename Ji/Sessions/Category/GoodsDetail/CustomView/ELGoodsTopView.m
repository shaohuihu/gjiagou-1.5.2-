//
//  ELGoodsTopView.m
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodsTopView.h"

@interface ELGoodsTopView ()

@property (nonatomic, weak) UIView *bottomView;

@end

@implementation ELGoodsTopView
{
    UIButton *lastButton_;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}

- (void)p_setUp {
    CGFloat width = self.el_width/3;
    [@[@"商品",@"详情",@"评价"] enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
        [button setTitleColor:EL_MainColor forState:UIControlStateSelected];
        [button setFrame:CGRectMake(idx*width, 0, width, self.el_height)];
        button.titleLabel.font = kFont_System(14.f);
        [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+idx;
        [self addSubview:button];
        
        if (idx == 0) {
            lastButton_ = button;
            button.selected = YES;
            UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.el_height -2, width, 2)];
            bottomView.backgroundColor = EL_MainColor;
            [self addSubview:self.bottomView = bottomView];
        }
    }];
}

- (void)onButtonTap:(UIButton *)button {
    [self setStateButton:button];
    if (self.selectBlock) {
        self.selectBlock(button.tag-100);
    }
}

- (void)setStateButton:(UIButton *)button{
    lastButton_.selected = NO;
    button.selected = YES;
    lastButton_ = button;
    self.bottomView.el_left = button.el_left;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    UIButton *button = [self viewWithTag:100+selectIndex];
    [self setStateButton:button];
}

@end
