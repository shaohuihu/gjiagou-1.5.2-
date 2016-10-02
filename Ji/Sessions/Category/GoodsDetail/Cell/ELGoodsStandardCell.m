//
//  ELGoodsStandardCell.m
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodsStandardCell.h"

@implementation ELGoodsStandardCell

- (void)o_configViews {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.textLabel.text = @"产品规格";
    self.textLabel.textColor = EL_TextColor_Dark;
    self.textLabel.font = kFont_System(14);
}
@end
