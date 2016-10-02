//
//  ELMineHotCell.h
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@class ELHotShopModel;

@protocol ELMineHotCellDelegate <NSObject>
@optional
- (void)hotShopDidSelectWithModel:(ELHotShopModel *)model;

@end

@interface ELMineHotCell : ELRootCell

@end
