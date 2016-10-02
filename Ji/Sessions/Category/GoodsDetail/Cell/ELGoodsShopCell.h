//
//  ELGoodsShopCell.h
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@protocol ELGoodsShopCellDelegate <NSObject>
@optional
- (void)shopCellOnContactTap;
- (void)shopCellOnShopInfoTap;
- (void)shopCellOnShopCategoryTap;

@end

@interface ELGoodsShopCell : ELRootCell

@end
