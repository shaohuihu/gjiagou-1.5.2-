//
//  ELSpecificationCell.h
//  Ji
//
//  Created by evol on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
@class ELSpecificationCell;
@protocol ELSpecificationCellDelegate <NSObject>

@optional
- (void)specCell:(ELSpecificationCell *)cell didSelectWithKey:(NSString *)key value:(NSString *)value;

@end

@interface ELSpecificationCell : ELRootCell

@end
