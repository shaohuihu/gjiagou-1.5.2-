//
//  DBGoodSaveCell.h
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBGoodSaveCell;
@protocol DBGoodsSaveDelegate <NSObject>

-(void)goodsSaveCell:(DBGoodSaveCell*)cell delete:(UIButton*)btn;

@end


@interface DBGoodSaveCell : UICollectionViewCell

@property (nonatomic, strong) id data;
@property (nonatomic, weak) id<DBGoodsSaveDelegate>delegate;
-(void)deleteBtnIsHidden:(BOOL)ishidden;

@end
