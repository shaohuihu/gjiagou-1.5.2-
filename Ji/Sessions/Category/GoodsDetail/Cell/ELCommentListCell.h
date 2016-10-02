//
//  ELCommentListCell.h
//  Ji
//
//  Created by evol on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
@class ELCommentListCell;

@protocol ELCommentListCellDelegate <NSObject>
@optional
- (void)cellNeedReload:(ELCommentListCell *)cell;

@end

@interface ELCommentListCell : ELRootCell

@end
