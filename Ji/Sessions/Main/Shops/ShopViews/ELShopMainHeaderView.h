//
//  ELShopMainHeaderView.h
//  Ji
//
//  Created by hushaohui on 16/10/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELMainShopTopModel;
/**
 *  首页头部视图
 */
@interface ELShopMainHeaderView : UIView

@property (nonatomic, weak)UIViewController *controlelr;  ///<控制器
@property (nonatomic, weak)UICollectionView *collectionView;  ///<九宫格

- (CGFloat)getHeaderHeight;
- (void)setupData:(ELMainShopTopModel *)model;
@end
