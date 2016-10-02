//
//  ELDrawCell.h
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
#import "EL0YuanModel.h"

@protocol ELDrawCellDelegate <NSObject>

@optional
- (void)drawCellDidTab;
//0 抽奖 1查看
- (void)drawCellActionTapWithModel:(ELDrawtomModel *)model type:(NSInteger)type;
- (void)drawCellImageDidTapWithModel:(ELDrawtomModel *)model;
- (void)drawCellOnDrawRuleTap;
@end

@interface ELDrawCell : ELRootCell

@end
