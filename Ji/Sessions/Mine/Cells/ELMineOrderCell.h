//
//  ELMineOrderCell.h
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@protocol ELMineOrderCellDelegate <NSObject>

@optional
- (void)orderCellDidSelectIndex:(NSInteger)index;

@end

@interface ELMineOrderCell : ELRootCell

@property(nonatomic,strong)NSMutableArray *datas;
    


@end
