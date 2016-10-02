//
//  DBShouhuoCell.h
//  Ji
//
//  Created by ssgm on 16/6/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"


@class DBShouhuoCell;
@protocol shouhuoCellDelaget <NSObject>

-(void)shouhuoCell:(DBShouhuoCell*)cell click:(UIButton*)btn;

@end


@interface DBShouhuoCell : ELRootCell
@property(nonatomic,strong)UIButton *shouhuoBtn;
@end
