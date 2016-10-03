//
//  ELShopSelectTypeView.h
//  Ji
//
//  Created by hushaohui on 16/10/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELShopSelectTypeView;
@protocol ELShopSelectTypeViewDelegate <NSObject>
- (void)selectShopTypeView:(ELShopSelectTypeView *)typeView typeIndex:(NSInteger)index;

@end

/**
 *  选择type  View
 */
@interface ELShopSelectTypeView : UIView
@property (nonatomic, weak)id<ELShopSelectTypeViewDelegate>  delegate;  ///<代理
@end
