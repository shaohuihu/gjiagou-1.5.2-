//
//  ELProductListController.m
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELProductListController.h"
#import "ELProductListTopView.h"
#import "ELCatoryService.h"
#import "ELProductListModel.h"
#import "ELProductOrderView.h"
#import "ELProductBrandView.h"
#import "ELBrandModel.h"
#import "ELGoodDetailController.h"
#import "DBNodataView.h"

@interface ELProductListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) ELProductListTopView *topView;
@property (nonatomic, strong) ELProductOrderView *orderView;
@property (nonatomic, strong) ELProductBrandView *brandView;

@property (nonatomic, strong) DBNodataView *noDadaView;

//请求参数
@property (nonatomic, strong) NSMutableDictionary *para;
@end

@implementation ELProductListController
{
    NSInteger curPage_;
}



- (void)o_viewLoad {
    self.navigationItem.rightBarButtonItem = self.notiItem;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"搜索商品";
}

- (void)o_configDatas{
    _datas = [NSMutableArray array];
    _para = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *areaId = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
    [_para setObject:areaId forKey:@"areaId"];
    if (self.categoryId != 0) {
        [_para setObject:@(self.categoryId) forKey:@"category_id"];
    }
    if (self.searchText.length > 0) {
        [_para setObject:self.searchText forKey:@"keywords"];
        self.searchBar.text = self.searchText;
    }
}

- (void)o_configViews{
    
    [self.view addSubview:self.noDadaView];

    UITableView *tableView               = [[UITableView alloc] init];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    [tableView registerClasses:@[@"ELProductListCell"]];
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
        make.left.bottom.right.equalTo(ws.view);
        make.top.equalTo(ws.view).offset(44);
    }];
    
    [self.noDadaView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableView);
    }];
    
    [self.view addSubview:self.topView];
}

- (void)o_loadDatas{
}


- (void)o_searchDidTap{
    [_para setObject:self.searchText forKey:@"keywords"];
    [self p_headerRefresh];
}

- (void)o_searchFieldDidChange:(NSString *)text {
    [super o_searchFieldDidChange:text];
    text = text?:@"";
    [_para setObject:text forKey:@"keywords"];
}


#pragma mark - Refresh Datas

- (void)p_loadDatas {
    WS(ws);
    [ELCatoryService getCategoryGoodsWithPage:curPage_ para:_para block:^(BOOL success, id result) {
        [self p_endRefresh];
        if (success) {
            if (curPage_ == 1) {
                [_datas removeAllObjects];
            }
            NSArray *array = [ELProductListModel mj_objectArrayWithKeyValuesArray:result];
            [_datas addObjectsFromArray:array];
            self.noDadaView.hidden = _datas.count != 0;
            ws.tableView.hidden = !self.noDadaView.hidden;
            [ws.tableView reloadData];
        }
    }];
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
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}


#pragma mark - Private

- (void)p_topViewSelectIndex:(NSInteger )index{
    [self.navigationItem.titleView endEditing:YES];
    if (index == 0) {
        if (self.orderView.superview != nil) {
            [self.topView setLeftButtonType:0];
            [self.orderView hide];
        }else{
            [self.orderView showInView:self.view belowView:self.topView];
            [self.topView setLeftButtonType:1];
        }
    }else if(index == 1){
        if (self.orderView.superview != nil) {
            [self.orderView hide];
        }
        [_para setObject:@"month_sold" forKey:@"sort_by"];
        [self p_headerRefresh];
    }else if(index == 2){
        if (self.orderView.superview != nil) {
            [self.orderView hide];
        }
        [self.brandView showInView:self.view.window];
    }
}

- (void)p_orderViewSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [_para setObject:@"price_desc" forKey:@"sort_by"];
            break;
        case 1:
            [_para setObject:@"price_asc" forKey:@"sort_by"];
            break;
        case 2:
            [_para setObject:@"is_hot" forKey:@"sort_by"];
            break;
        default:
            break;
    }
    [self p_headerRefresh];
}

- (void)p_brandViewSelectModel:(ELBrandModel *)model{
    if (model == nil) {
        [_para setObject:@"" forKey:@"brand_id"];
    }else
        [_para setObject:@(model.id) forKey:@"brand_id"];
    [self p_headerRefresh];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELProductListCell"];
    [cell setData:_datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELProductListModel *model = _datas[indexPath.row];
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - Getters 
- (DBNodataView *)noDadaView {
    if (_noDadaView == nil) {
        _noDadaView = [DBNodataView new];
        [_noDadaView setImage:@"ic_person_product_img" andUpLabel:@"暂无商品" andDownLabel:nil andBtn:nil];
    }
    return _noDadaView;
}

- (ELProductListTopView *)topView{
    if (_topView == nil) {
        WS(ws);
        _topView = [[ELProductListTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [_topView setSelectBlock:^(NSInteger index) {
            [ws p_topViewSelectIndex:index];
        }];
    }
    return _topView;
}


- (ELProductOrderView *)orderView {
    if (_orderView == nil) {
        WS(ws);
        _orderView = [[ELProductOrderView alloc] initWithFrame:CGRectMake(0, self.topView.el_bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.topView.el_bottom - 64)];
        [_orderView setSelectBlock:^(NSInteger index) {
            [ws p_orderViewSelectIndex:index];
        }];
    }
    return _orderView;
}

- (ELProductBrandView *)brandView {
    if (_brandView == nil) {
        WS(ws);
        _brandView = [[ELProductBrandView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _brandView.categoryId = self.categoryId;
        [_brandView setSelectBlock:^(ELBrandModel *model) {
            [ws p_brandViewSelectModel:model];
        }];
    }
    return _brandView;
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
