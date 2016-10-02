//
//  ELCategoryDelegate.h
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELTopCatoryModel;
@protocol ELCategoryDelegateProtocol  <NSObject>

@optional
- (void)dataDidLoad;
- (void)modelDidSelectIndex:(NSInteger)index model:(ELTopCatoryModel *)model;

@end

@interface ELCategoryDelegate : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, weak) id<ELCategoryDelegateProtocol> delegate;

- (void)loadDataWithCompletion:(void(^)())completion;

@end
