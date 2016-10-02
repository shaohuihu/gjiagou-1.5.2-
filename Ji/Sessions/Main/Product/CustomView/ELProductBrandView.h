//
//  ELProductBrandView.h
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELBrandModel;
@interface ELProductBrandView : UIButton

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, copy) void(^selectBlock)(ELBrandModel * model);
@property (nonatomic, assign) NSInteger selectIndex;

- (void)showInView:(UIView *)view;
- (void)hide;

@end
