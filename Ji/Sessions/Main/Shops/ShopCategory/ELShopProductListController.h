//
//  ELShopProductListController.h
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELBasicViewController.h"

@interface ELShopProductListController : ELBasicViewController

@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) BOOL isSearch;

@end
