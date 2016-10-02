//
//  DBOrderAddressCell.h
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

//订单地址cell
@interface DBOrderAddressCell : ELRootCell
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIImageView *iconImageview;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UILabel *userLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@end
