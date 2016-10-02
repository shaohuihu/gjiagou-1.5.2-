//
//  ELCartListCell.h
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
@class ELCartListCell;

@protocol ELCartListCellDelegate <NSObject>
@optional
- (void)listCell:(ELCartListCell *)cell didCheckoutButtonSelectWithIndexPath:(NSIndexPath *)indexPath;
- (void)listCell:(ELCartListCell *)cell didChangeCount:(NSInteger)count;

@end

@interface ELCartListCell : ELRootCell
@property (nonatomic, assign) NSInteger type;//0结算 1删除
- (void)onDelTap;
@end
