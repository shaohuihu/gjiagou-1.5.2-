//
//  ELCategorySubCell.h
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
@class ELTopCatoryModel;

@protocol ELCategorySubCellDelegate <NSObject>

@optional
- (void )cellDidSelectWithModel:(ELTopCatoryModel *)model;

@end

@interface ELCategorySubCell : ELRootCell

@end
