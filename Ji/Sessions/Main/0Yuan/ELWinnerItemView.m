//
//  ELWinnerItemView.m
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELWinnerItemView.h"

@interface ELWinnerItemView ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *areaLabel;
@property (nonatomic, weak) UILabel *lotteryLabel;

@end
@implementation ELWinnerItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)setName:(NSString *)name area:(NSString *)area lottery:(NSString *)lottery{
    self.nameLabel.text = name;
    self.areaLabel.text = area;
    self.lotteryLabel.text = lottery;
}

- (void)setUp {
    UILabel *nameLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    [self addSubview:self.nameLabel = nameLabel];
    
    UILabel *areaLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    [self addSubview:self.areaLabel = areaLabel];
    
    UILabel *lotteryLabel = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    [self addSubview:self.lotteryLabel = lotteryLabel];
    WS(ws);
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioValue(20)-3);
        make.centerY.equalTo(ws);
    }];
    
    [areaLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioValue(95)-3);
        make.centerY.equalTo(ws);
    }];
    
    [lotteryLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kRadioValue(210)-3);
        make.centerY.equalTo(ws);
        make.right.equalTo(ws).offset(-10);
    }];
}

@end
