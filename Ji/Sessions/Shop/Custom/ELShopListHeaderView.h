//
//  ELShopListHeaderView.h
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCartListModel.h"

@protocol ELShopListHeaderViewDelegate <NSObject>

@optional
- (void)topViewCheckoutButtonDidTapWithSection:(NSInteger)section selected:(BOOL)selected;

@end

@interface ELShopListHeaderView : UIView

@property (nonatomic, strong) ELCartListModel *model;
@property (nonatomic, assign) NSInteger section;

@property (nonatomic, weak) id<ELShopListHeaderViewDelegate> delegate;

- (void)setState:(BOOL)isAll;

@end
