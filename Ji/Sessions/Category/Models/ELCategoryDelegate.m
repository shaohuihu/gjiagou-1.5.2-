//
//  ELCategoryDelegate.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCategoryDelegate.h"
#import "ELCatoryService.h"
#import "ELTopCatoryModel.h"
@implementation ELCategoryDelegate


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)loadDataWithCompletion:(void(^)())completion{
    [ELCatoryService getCategoriesWithBlock:^(BOOL success, id result) {
        if (success) {
            _datas = [ELTopCatoryModel mj_objectArrayWithKeyValuesArray:result];
            if (completion) {
                completion();
            }
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELCatogoryTopCell"];
    [cell setData:_datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELRootCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    if ([self.delegate respondsToSelector:@selector(modelDidSelectIndex:model:)]) {
        [self.delegate modelDidSelectIndex:indexPath.row model:self.datas[indexPath.row]];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    return indexPath;
}

@end
