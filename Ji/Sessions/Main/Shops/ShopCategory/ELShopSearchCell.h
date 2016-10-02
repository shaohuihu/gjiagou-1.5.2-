//
//  ELShopSearchCell.h
//  Ji
//
//  Created by evol on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
#import "ELShopSearchModel.h"

@protocol ELShopSearchCellDelegate <NSObject>
@optional
- (void)shopCellDidSelectWithModel:(ELChildlistModel *)model;
- (void)shopCellPresentAllProducts:(ELShopSearchModel *)model;
@end

@interface ELShopSearchCell : ELRootCell

@end
