//
//  ELMineProductCell.h
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
#import "ELMainProductModel.h"

@protocol ELMineProductCellDelegate <NSObject>

@optional
- (void)productCellDidSelectWithModel:(ELMainGood *)model;

@end

@interface ELMineProductCell : ELRootCell


@end
