//
//  DBShopCollectionCell.h
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@class DBShopCollectionCell;
@protocol DBShopCollectionDelegate <NSObject>

-(void)shopCollectionCell:(DBShopCollectionCell*)cell delete:(UIButton*)btn;

@end

@interface DBShopCollectionCell : ELRootCell


-(void)deleteBtnIsHidden:(BOOL)ishidden;

@end
