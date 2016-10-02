//
//  DBPingjiaAddPicCell.h
//  Ji
//
//  Created by ssgm on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@class DBPingjiaAddPicCell;
@protocol AddPicDelegate <NSObject>

-(void)cell:(DBPingjiaAddPicCell*)cell addBtnClick:(UIButton*)btn;

@end

@interface DBPingjiaAddPicCell : ELRootCell
@property(nonatomic,strong)UIButton *addBtn;

@end
