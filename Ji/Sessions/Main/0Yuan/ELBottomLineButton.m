//
//  ELBottomLineButton.m
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELBottomLineButton.h"

@interface ELBottomLineButton ()

@property (nonatomic, weak) UIImageView *boView;

@end

@implementation ELBottomLineButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)setUp {
    UIImageView *boView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_zero_bigline"]];
    boView.hidden = YES;
    [self addSubview:self.boView = boView];
    WS(ws);
    [boView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.equalTo(3);
    }];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.boView.hidden = !selected;
}

@end
