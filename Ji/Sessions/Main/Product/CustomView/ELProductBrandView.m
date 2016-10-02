//
//  ELProductBrandView.m
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELProductBrandView.h"
#import "ELCatoryService.h"
#import "ELBrandModel.h"
#import <objc/runtime.h>

@interface ELProductBrandView ()

@property (nonatomic, weak) UIView *brandsView;
@property (nonatomic, weak) UIView *contentView;

@end

static char modelKey;
@implementation ELProductBrandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}


- (void)p_setUp{
    
    [self addTarget:self action:@selector(onSelfTap) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];

    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(kRadioValue(65), 0, SCREEN_WIDTH -kRadioValue(65), SCREEN_HEIGHT)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView = contentView];
    
    UILabel *titleLabel = [ELUtil createLabelFont:16.f color:[UIColor blackColor]];
    titleLabel.text = @"商品筛选";
    [titleLabel sizeToFit];
    titleLabel.el_centerX = contentView.el_width/2;
    titleLabel.el_top = 30;
    [contentView addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"ic_back_button"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.el_left = 15;
    button.el_centerY = titleLabel.el_centerY;
    [contentView addSubview:button];
    
    UILabel *fixBrand = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    fixBrand.text = @"品牌";
    [fixBrand sizeToFit];
    fixBrand.el_left = 10;
    fixBrand.el_top = button.el_bottom + 25;
    [contentView addSubview:fixBrand];
    
    UIView *brandsView = [[UIView alloc] initWithFrame:CGRectMake(0, fixBrand.el_bottom + 15, contentView.el_width, 0)];
    brandsView.el_height = SCREEN_HEIGHT - brandsView.el_top;
    [contentView addSubview:self.brandsView = brandsView];
}

- (void)setCategoryId:(NSInteger)categoryId{
    _categoryId = categoryId;
    WS(ws);
    [ELCatoryService getCategoryBrandsWithCategoryId:categoryId block:^(BOOL success, id result) {
        if (success) {
            NSArray<ELBrandModel *> *array = [ELBrandModel mj_objectArrayWithKeyValuesArray:result];
            [ws p_setUpBrandsView:array];
        }
    }];
}

- (void)p_setUpBrandsView:(NSArray<ELBrandModel *> *)brands{
    CGFloat margin = 10;
    CGFloat itemWith = (self.brandsView.el_width - 4*kRadioValue(margin))/3;
    CGFloat itemHeight = 30;
    
    if(brands.count > 0){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"全部" forState:UIControlStateNormal];
        button.layer.borderColor = EL_TextColor_Light.CGColor;
        button.layer.borderWidth = 1.f;
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = kFont_System(14.f);
        [button setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
        [button setFrame:CGRectMake(margin, margin, itemWith, itemHeight)];
        objc_setAssociatedObject(button, &modelKey, nil, OBJC_ASSOCIATION_RETAIN);
        [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.brandsView addSubview:button];
    }
    
    [brands enumerateObjectsUsingBlock:^(ELBrandModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj.name forState:UIControlStateNormal];
        button.layer.borderColor = EL_TextColor_Light.CGColor;
        button.layer.borderWidth = 1.f;
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = kFont_System(14.f);
        [button setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
        [button setFrame:CGRectMake(margin+(idx+1)%3*(itemWith+margin), margin + (idx+1)/3*(itemHeight +margin), itemWith, itemHeight)];
        objc_setAssociatedObject(button, &modelKey, obj, OBJC_ASSOCIATION_RETAIN);
        [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.brandsView addSubview:button];
    }];
}

#pragma mark - Response

- (void)onSelfTap{
    [self hide];
}

- (void)onButtonTap:(UIButton *)button{
    ELBrandModel * model = (ELBrandModel *)objc_getAssociatedObject(button, &modelKey);
    if (self.selectBlock) {
        self.selectBlock(model);
    }
    [self hide];
}

#pragma mark - Public
- (void)showInView:(UIView *)view {
    self.contentView.el_left = SCREEN_WIDTH;
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.el_left = kRadioValue(65);
    } completion:^(BOOL finished) {
        self.contentView.el_left = kRadioValue(65);
    }];
}


- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.el_left = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
