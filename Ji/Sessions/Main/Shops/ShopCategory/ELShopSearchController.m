//
//  ELShopSearchController.m
//  Ji
//
//  Created by evol on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopSearchController.h"
#import "ELMainService.h"   
#import "ELShopSearchModel.h"
#import "ELShopSearchCell.h"
#import "ELShopProductListController.h"
@interface ELShopSearchController ()<UITableViewDelegate,UITableViewDataSource,ELShopSearchCellDelegate>

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation ELShopSearchController

- (void)o_viewLoad{
    self.navigationItem.rightBarButtonItem = self.notiItem;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"搜索店铺内商品";
}

- (void)o_loadDatas {
    WS(ws);
    [ELMainService getShopCategory:self.shopId block:^(BOOL success, id result) {
        if (success) {
            _datas = [ELShopSearchModel mj_objectArrayWithKeyValuesArray:result];
            [ws.tableView reloadData];
        }
    }];
}

- (void)o_configViews{
    UITableView *tableView               = [[UITableView alloc] init];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    [tableView registerClasses:@[@"ELShopAllGoodsCell",@"ELShopSearchCell"]];
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];

}

#pragma mark - Search

- (void)o_searchDidTap{
    ELShopProductListController *vc = [[ELShopProductListController alloc] init];
    vc.isSearch = YES;
    vc.searchText = self.searchText;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else
        return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = nil;
    if (indexPath.section == 0) {
        identifier = @"ELShopAllGoodsCell";
    }else{
        identifier = @"ELShopSearchCell";
    }
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.delegate = self;
    if (indexPath.section == 1) {
        [cell setData:_datas[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


#pragma mark - ELShopSearchCellDelegate

- (void)shopCellDidSelectWithModel:(ELChildlistModel *)model{
    ELShopProductListController *vc = [[ELShopProductListController alloc] init];
    vc.shopId = self.shopId;
    vc.categoryId = model.id;
    vc.level = 3;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)shopCellPresentAllProducts:(ELShopSearchModel *)model{
    ELShopProductListController *vc = [[ELShopProductListController alloc] init];
    vc.shopId = self.shopId;
    vc.categoryId = model.id;
    vc.level = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
