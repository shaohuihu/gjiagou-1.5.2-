//
//  DBPayCell.h
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@class DBPayCell;
@protocol payCellDelaget <NSObject>

-(void)payCell:(DBPayCell*)cell click:(UIButton*)btn;

@end
//订单付款、取消cell
@interface DBPayCell : ELRootCell
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *payBtn;
@end
