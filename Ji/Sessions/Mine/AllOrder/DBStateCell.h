//
//  DBStateCell.h
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

//订单详情状态cell
@interface DBStateCell : ELRootCell
@property(nonatomic,strong)UILabel *stateLabel;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *gjiagouImageView;

-(void)setDataTuikuan;
-(void)setDataFeituikuan;
@end
