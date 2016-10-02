//
//  ELSpecCountCell.h
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@protocol ELSpecCountCellDelegate <NSObject>
@optional
- (void)countCellDidChange:(NSInteger)count;
- (NSInteger)getOriginCount;
@end

@interface ELSpecCountCell : ELRootCell

@end
