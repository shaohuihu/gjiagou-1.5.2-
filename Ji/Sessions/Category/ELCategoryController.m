//
//  ELCategoryController.m
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCategoryController.h"
#import "ELCatoryService.h"
#import "ELCategoryDelegate.h"
#import "ELCatogoryTopCell.h"
#import "ELTopCatoryModel.h"
#import "ELCategorySubCell.h"
#import "ELProductListController.h"
#import "ELGoodsTopCell.h"

@interface ELCategoryController ()<UITableViewDelegate,UITableViewDataSource,ELCategoryDelegateProtocol,ELCategorySubCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UITableView *subTableView;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) ELCategoryDelegate *categoryDelegate;
@property (nonatomic, strong) NSArray *subDatas;
@property (nonatomic, strong) NSMutableDictionary *dictDatas;
@end

@implementation ELCategoryController


-(void)o_viewLoad {
    self.navigationItem.rightBarButtonItem = self.notiItem;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.el_width = kRadioValue(250);
    self.searchBar.placeholder = @"搜索商品";
    [self.navigationController.navigationBar setBackgroundImage:imageWithColor(BQ_CategoryColor, 1, 1) forBarMetrics:UIBarMetricsDefault];

}

- (void)o_loadDatas{
    WS(ws);
    [self.categoryDelegate loadDataWithCompletion:^{
        [ws.tableView reloadData];
        
        [ws.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        ELTopCatoryModel *model = self.categoryDelegate.datas.firstObject;
        [ws p_loadSubDatasWithId:model.id];
    }];
}

- (void)o_configDatas {
    _dictDatas = [NSMutableDictionary dictionary];
}

- (void)o_viewAppear {
    CGFloat bottomMargin = 0;
    if (self.tabBarController.tabBar.hidden) {
        bottomMargin = 0;
    }else{
        bottomMargin = -49;
    }
    WS(ws);
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).offset(bottomMargin);
    }];
    
    [self.subTableView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).offset(bottomMargin);
    }];
    
    [self.navigationController.navigationBar setBackgroundImage:imageWithColor(BQ_CategoryColor, 1, 1) forBarMetrics:UIBarMetricsDefault];
    
    

}
-(void)doshare{
    
}
- (void)o_configViews{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self.categoryDelegate;
    tableView.dataSource = self.categoryDelegate;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[ELCatogoryTopCell class] forCellReuseIdentifier:@"ELCatogoryTopCell"];
    tableView.backgroundColor = EL_BackGroundColor;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView = tableView];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-49);
        make.width.equalTo(SCREEN_WIDTH*7/32);
    }];
    
    
    tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 44;
    [tableView registerClasses:@[@"ELCategorySubCell"]];
    [self.view addSubview:self.subTableView = tableView ];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.tableView.right);
        make.bottom.equalTo(ws.view).offset(-49);
        make.right.top.equalTo(ws.view);
    }];

}

#pragma mark - Search

- (void)o_searchDidTap{
    ELProductListController *vc = [ELProductListController new];
    vc.searchText = self.searchText;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private

- (void)p_loadSubDatasWithId:(NSInteger)cid{
    [_dictDatas removeAllObjects];
    WS(ws);
    [ELCatoryService getSubCategoriesWithId:cid block:^(BOOL success, id result) {
        if (success) {
            NSArray *datas = [ELTopCatoryModel mj_objectArrayWithKeyValuesArray:result];
            
            [datas enumerateObjectsUsingBlock:^(ELTopCatoryModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:obj forKey:@"model"];
                [_dictDatas setObject:dict forKey:@(idx)];
                [ELCatoryService getSubCategories1WithId:obj.id block:^(BOOL success, id result) {
                    if (success) {
                        NSArray *subModels = [ELTopCatoryModel mj_objectArrayWithKeyValuesArray:result];
                        NSMutableDictionary *subDict = [_dictDatas objectForKey:@(idx)];
                        [subDict setObject:subModels forKey:@"values"];
                        [ws.subTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
            }];
            [ws.subTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dictDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [_dictDatas objectForKey:@(indexPath.row)];
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELCategorySubCell"];
    cell.delegate = self;
    [cell setData:data];
    return cell;
}


#pragma mark - ELCategoryDelegateProtocol

- (void)modelDidSelectIndex:(NSInteger)index model:(ELTopCatoryModel *)model{
    [self p_loadSubDatasWithId:model.id];
}

#pragma mark - ELCategorySubCellDelegate

- (void )cellDidSelectWithModel:(ELTopCatoryModel *)model{
    ELProductListController *vc = [ELProductListController new];
    vc.categoryId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getters

- (ELCategoryDelegate *)categoryDelegate{
    if (_categoryDelegate == nil) {
        _categoryDelegate = [[ELCategoryDelegate alloc] init];
        _categoryDelegate.delegate = self;
    }
    return _categoryDelegate;
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
