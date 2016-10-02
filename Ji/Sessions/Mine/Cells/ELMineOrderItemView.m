//
//  ELMineOrderItemView.m
//  Ji
//
//  Created by evol on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMineOrderItemView.h"

@implementation ELMineOrderItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setUp];
    }
    return self;
}


- (void)setTitle:(NSString*)title image:(NSString *)image count:(NSInteger)count{
    _nameLabel.text = title;
    _icon.image = [UIImage imageNamed:image];
    _countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
}

- (void)p_setUp {
    
    [self setBackgroundImage:imageWithColor(EL_TextColor_Light, 1, 1) forState:UIControlStateHighlighted];
    
    CGFloat countWidth = 12;
    
    UIImageView *icon = [UIImageView new];
    [self addSubview:self.icon = icon];
    
    UILabel *titleLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Light];
    [self addSubview:self.nameLabel = titleLabel];
    
    UILabel *countLabel = [ELUtil createLabelFont:9 color:[UIColor whiteColor]];
    countLabel.layer.cornerRadius = countWidth/2;
    countLabel.layer.masksToBounds = YES;
    countLabel.backgroundColor = [UIColor redColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.countLabel = countLabel];
    
    WS(ws);
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(20);
        make.centerX.equalTo(ws);
    }];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon).offset(20);
        make.bottom.equalTo(ws).offset(-20);
        make.centerX.equalTo(icon);
    }];
    
    [countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(icon.right);
        make.centerY.equalTo(icon.top);
        make.size.equalTo(CGSizeMake(countWidth, countWidth));
    }];
}

@end
