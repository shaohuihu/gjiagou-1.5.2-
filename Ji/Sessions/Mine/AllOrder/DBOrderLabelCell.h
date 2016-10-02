//
//  DBOrderLabelCell.h
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

//订单详情左右都是labelcell
@interface DBOrderLabelCell : ELRootCell
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIButton * commentBtn;

-(void)setLeft:(NSString*)left right:(NSString*)right;
@end
