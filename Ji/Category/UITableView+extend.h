//
//  UITableView+extend.h
//  THApp
//
//  Created by evol on 16/5/11.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (extend)

- (void)registerClasses:(NSArray *)cellClasses;
-(void)clearExtraLine;

@end
