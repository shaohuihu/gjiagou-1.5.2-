//
//  DBShopHeadCell.h
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
#import "DBOrder.h"

//订单店铺名cell
@interface DBShopHeadCell : ELRootCell
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *shopNameLabel;
@property(nonatomic,strong)UIImageView *tipImageView;
@property(nonatomic,strong)UILabel *stateLabel;

-(void)setDataTuikuan;
-(void)setDataFeituikuan;
@end
