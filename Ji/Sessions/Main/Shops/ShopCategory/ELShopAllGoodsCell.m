//
//  ELShopAllGoodsCell.m
//  Ji
//
//  Created by evol on 16/6/16.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopAllGoodsCell.h"

@interface ELShopAllGoodsCell ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation ELShopAllGoodsCell

- (void)o_configViews{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *label = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    label.text = @"全部宝贝";
    [self.contentView addSubview:label];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(13);
        make.centerY.equalTo(self.contentView);
    }];
}

@end
