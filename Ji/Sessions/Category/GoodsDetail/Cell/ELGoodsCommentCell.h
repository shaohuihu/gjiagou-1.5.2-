//
//  ELGoodsCommentCell.h
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@protocol ELGoodsCommentCellDelegate <NSObject>

@optional
- (void)commentCellTapToCheckAll;

@end

@interface ELGoodsCommentCell : ELRootCell

@end
