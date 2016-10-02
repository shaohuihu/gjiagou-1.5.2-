//
//  ELDrawCell.m
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELDrawCell.h"
#import "ELBottomLineButton.h"
#import "EL0YuanModel.h"
#import "ELDrawItemView.h"

static char boolKey;

@interface ELDrawCell ()<ELDrawItemViewDelegate>

@end

@implementation ELDrawCell
{
    UIView *topView_;
    UIView *contentView_;
    NSInteger selectIndex_;
}

- (void)o_configViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    topView_ = [UIView new];
    [self.contentView addSubview:topView_];
//
    UIView *topItemView = [UIView new];
    topItemView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [topView_ addSubview:topItemView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_zero_line"]];
    [topItemView addSubview:leftView];

    UIImageView *zeroIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_zero_text"]];
    [topItemView addSubview:zeroIcon];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开奖规则" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xe7a343) forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(onDrawRule) forControlEvents:UIControlEventTouchUpInside];
    [topItemView addSubview:button];
    
    
//
    WS(ws);
    [topView_ makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.contentView);
    }];
    
    [topItemView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(3.5);
        make.left.right.equalTo(topView_);
    }];
    
    [leftView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(topItemView);
    }];
    
    [zeroIcon makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView.right).offset(5);
        make.centerY.equalTo(topItemView);
    }];
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topItemView).offset(-10);
        make.centerY.equalTo(topItemView);
    }];
    
    for (int i = 0; i < 2; i++) {
        NSArray *titles = @[@"限时开奖",@"即将开奖"];
        ELBottomLineButton *todayButton = [[ELBottomLineButton alloc] init];
        [todayButton setTitle:titles[i] forState:UIControlStateNormal];
        [todayButton setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
        [todayButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [todayButton addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        todayButton.titleLabel.font = kFont_System(14.f);
        todayButton.tag = 100 + i;
        [topView_ addSubview:todayButton];
        
        if (i == 0) {
            todayButton.selected = YES;
            [todayButton makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topItemView.bottom);
                make.width.equalTo(topView_).multipliedBy(0.5);
                make.left.bottom.equalTo(topView_);
                make.height.equalTo(40);
            }];
        }else{
            [todayButton makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topItemView.bottom);
                make.width.equalTo(topView_).multipliedBy(0.5);
                make.right.equalTo(topView_);
                make.height.equalTo(40);
            }];
        }
    }
    contentView_ = [UIView new];
    [self.contentView addSubview:contentView_];
}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[EL0YuanModel class]]) {
        EL0YuanModel *model = self.data;
        NSArray<ELDrawtomModel *> *array;
        NSNumber * boolValue = (NSNumber *)objc_getAssociatedObject(self.data, &boolKey);

        ELBottomLineButton *btn = [topView_ viewWithTag:100+selectIndex_];
        btn.selected = NO;
        if (boolValue.boolValue == YES) {
            array = model.drawTom;
            selectIndex_ = 1;
        }else{
            array = model.drawGoodsList;
            selectIndex_ = 0;
        }
        ELBottomLineButton * theButton = [topView_ viewWithTag:100+selectIndex_];
        theButton.selected = YES;
        
        __block ELDrawItemView *lastView;
        [contentView_.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [array enumerateObjectsUsingBlock:^(ELDrawtomModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ELDrawItemView *itemView = [[ELDrawItemView alloc] init];
            itemView.delegate = self;
            itemView.model = obj;
            itemView.type = boolValue.integerValue;
            [contentView_ addSubview:itemView];
           
            if (idx == array.count - 1) {
                [itemView makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.top.equalTo(lastView.bottom);
                    }else{
                        make.top.equalTo(contentView_);
                    }
                    make.left.right.equalTo(contentView_);
                    make.bottom.equalTo(contentView_);
                }];
            }else{
                [itemView makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.top.equalTo(lastView.bottom);
                    }else{
                        make.top.equalTo(contentView_);
                    }
                    make.left.right.equalTo(contentView_);
                }];
            }
            
            lastView = itemView;
        }];
    }
}

- (void)onButtonTap:(ELBottomLineButton *)button{
    if (button.tag - 100 == 1) {
        objc_setAssociatedObject(self.data, &boolKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    }else{
        objc_setAssociatedObject(self.data, &boolKey, @(NO), OBJC_ASSOCIATION_RETAIN);
    }
    if ([self.delegate respondsToSelector:@selector(drawCellDidTab)]) {
        [self.delegate drawCellDidTab];
    }
}

- (void)onDrawRule
{
    if ([self.delegate respondsToSelector:@selector(drawCellOnDrawRuleTap)]) {
        [self.delegate drawCellOnDrawRuleTap];
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

#pragma mark - ELDrawItemViewDelegate

- (void)itemViewDidSelectWithModel:(ELDrawtomModel *)model {
    if ([self.delegate respondsToSelector:@selector(drawCellActionTapWithModel:type:)]) {
        NSNumber * boolValue = (NSNumber *)objc_getAssociatedObject(self.data, &boolKey);
        [self.delegate drawCellActionTapWithModel:model type:boolValue.integerValue];
    }
}

- (void)itemViewImageDidTapWithModel:(ELDrawtomModel *)model {
    if ([self.delegate respondsToSelector:@selector(drawCellImageDidTapWithModel:)]) {
        [self.delegate drawCellImageDidTapWithModel:model];
    }
}

@end
