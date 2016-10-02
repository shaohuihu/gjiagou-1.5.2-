//
//  ELMainCategoryCell.h
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@class ELMainCategoryCell;

@protocol ELMainCategoryCellDelegate <NSObject>
@optional
- (void)cell:(ELMainCategoryCell *)cell didSelectedIndex:(NSInteger)index;

@end

@interface ELMainCategoryCell : ELRootCell

@end
