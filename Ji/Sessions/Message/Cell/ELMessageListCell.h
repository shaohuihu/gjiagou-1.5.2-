//
//  ELMessageListCell.h
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
@class ELMessageListCell;

@protocol ELMessageListCellDelegate <NSObject>
@optional
- (void)listCellDidSelect:(ELMessageListCell *)cell;

@end

@interface ELMessageListCell : ELRootCell

@end
