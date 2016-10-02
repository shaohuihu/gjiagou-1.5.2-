//
//  ELHomeGoodsCell.h
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//


//热卖
#import "ELRootCell.h"

@class ELHotGoodsModel;

@protocol ELHomeGoodsCellDelegate <NSObject>

@optional
- (void)homeGoodsCellDidClickWithModel:(ELHotGoodsModel *)model;

@end

@interface ELHomeGoodsCell : ELRootCell

@end
