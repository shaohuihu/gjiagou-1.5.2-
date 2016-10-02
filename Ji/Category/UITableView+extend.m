//
//  UITableView+extend.m
//  THApp
//
//  Created by evol on 16/5/11.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "UITableView+extend.h"

@implementation UITableView (extend)


- (void)registerClasses:(NSArray *)cellClasses {
	[cellClasses enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerClass:NSClassFromString(obj) forCellReuseIdentifier:obj];
    }];
}

-(void)clearExtraLine{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
    [self setTableHeaderView:view];
}

@end
