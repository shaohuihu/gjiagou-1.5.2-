//
//  DBGoodsCell.h
//  Ji
//
//  Created by ssgm on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
#import "DBZeroModel.h"
@class DBGoodsCell;
@protocol DBGoodsDelegate <NSObject>

-(void)dbGoodsCell:(DBGoodsCell*)cell selectAtIndex:(NSInteger)index;

@end

@interface DBGoodsCell : ELRootCell

-(void)setDataForleft:(DBZeroModel*)leftModel right:(DBZeroModel*)rightModel;
@end
