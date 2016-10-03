//
//  ELShopProductListController.m
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopProductListController.h"
#import "ELMainService.h"
#import "ELMainShopTopModel.h"
#import "ELGoodDetailController.h"

@interface ELShopProductListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) ELMainShopTopModel *shopModel;

@end

@implementation ELShopProductListController
{
    NSInteger curPage_;
}


- (void)o_viewLoad{
    self.navigationItem.rightBarButtonItem = self.notiItem;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"搜索店铺内商品";
}

- (void)o_configDatas {
    _datas = [NSMutableArray arrayWithCapacity:0];
    curPage_ = 1;
}

- (void)o_configViews {
    UITableView *tableView               = [[UITableView alloc] init];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    [tableView registerClasses:@[@"ELShopGoodsListCell"]];
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws p_headerRefresh];
    }];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws p_footerRefresh];
    }];
    [tableView.mj_header beginRefreshing];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.equalTo(ws.view);
    }];
}


#pragma mark - Search

- (void)o_searchDidTap{
    self.isSearch = YES;
    curPage_ = 1;
    [self p_loadDatas];
}

#pragma mark - Refresh Datas

- (void)p_loadDatas {
    WS(ws);
    if (_isSearch) {
        [ELMainService getShopSearchWithShopId:self.shopId text:self.searchText pageNo:curPage_ block:^(BOOL success, id result) {
            [ws p_endRefresh];
            if (success) {
                ws.shopModel = [ELMainShopTopModel mj_objectWithKeyValues:result];
                NSArray *array = _shopModel.recommendedGoods;
                if (curPage_ == 1) {
                    [ws.datas removeAllObjects];
                }
                [ws.datas addObjectsFromArray:array];
                [ws.tableView reloadData];
            }
        }];
    }else{
        [ELMainService getShopCategoryGoods:self.shopId categoryId:self.categoryId level:self.level pageNo:curPage_ block:^(BOOL success, id result) {
            [ws p_endRefresh];
            if (success) {
                ws.shopModel = [ELMainShopTopModel mj_objectWithKeyValues:result];
                NSArray *array = _shopModel.recommendedGoods;
                if (curPage_ == 1) {
                    [ws.datas removeAllObjects];
                }
                [ws.datas addObjectsFromArray:array];
                [ws.tableView reloadData];
            }
        }];
    }
}

- (void)p_headerRefresh{
    curPage_ = 1;
    [self p_loadDatas];
}

- (void)p_footerRefresh{
    curPage_++;
    [self p_loadDatas];
}

- (void)p_endRefresh{
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}


#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELShopGoodsListCell"];
    [cell setData:_datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELGoodslistModel *model = _datas[indexPath.row];
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = model.goodsId;
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
