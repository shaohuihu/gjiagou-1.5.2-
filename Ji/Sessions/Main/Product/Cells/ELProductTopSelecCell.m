//
//  ELProductTopSelecCell.m
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELProductTopSelecCell.h"

@interface ELProductTopSelecCell ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *icon;

@end

@implementation ELProductTopSelecCell

- (void)o_configViews {
    
    UILabel *nameLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.nameLabel = nameLabel];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pitch_on"]];
    [self.contentView addSubview:self.icon = icon];
    
    WS(ws);
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(ws.contentView);
    }];
    
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-10);
        make.centerY.equalTo(ws.contentView);
    }];
}


- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[NSString class]]) {
        self.nameLabel.text = self.data;
    }
}


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.nameLabel.textColor = EL_MainColor;
        self.icon.hidden = NO;
    }else{
        self.nameLabel.textColor = EL_TextColor_Light;
        self.icon.hidden = YES;
    }
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
