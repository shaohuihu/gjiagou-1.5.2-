//
//  ELMainController.m
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMainController.h"
#import "ELMainBannerView.h"
#import "ELLocationController.h"
#import "ELMainService.h"
#import "ELBannerModel.h"
#import "UIImageView+WebCache.h"
#import "ELMainProductModel.h"
#import "ELHotGoodsModel.h"
#import "ELHotShopModel.h"
#import "ELMainCategoryCell.h"
#import "ELReMaiViewController.h"
#import "ELReShopController.h"
#import "ELMainShopController.h"
#import "ELFenqiController.h"
#import "ELMineHotCell.h"
#import "EL0YuanController.h"
#import "ELMineProductCell.h"
#import "ELGoodDetailController.h"
#import "ELHomeGoodsCell.h"
#import "ELCategoryController.h"
#import "ELProductListController.h"
#import "ELShopService.h"
#import "ELCartListModel.h"
#import "ELTabBarController.h"

@interface ELMainController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    ELMainBannerViewDelegate,
    ELMainCategoryCellDelegate,
    ELMineHotCellDelegate,
    ELMineProductCellDelegate,
    ELHomeGoodsCellDelegate
>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) ELMainBannerView *bannerView;
@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *hotGoods;
@property (nonatomic, strong) NSArray *hotShops;
@end

@implementation ELMainController


- (void)o_viewAppear{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self updateLocation];
    [self p_loadBanners];
    if (Uid) {
        [ELShopService getCartListWithBlock:^(BOOL success, id result) {
            if (success) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSArray *array = result[@"goods_list"];
                    __block NSInteger totalCount = 0;
                    array = [ELCartListModel mj_objectArrayWithKeyValuesArray:array];
                    [array enumerateObjectsUsingBlock:^(ELCartListModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                        [model.goodslist enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            totalCount += obj.goods_number;
                        }];
                    }];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [(ELTabBarController *)self.tabBarController setBadgeValue:totalCount];
                    });
                });
            }
        }];
    }
}

- (void)o_viewLoad
{
    [self.navigationController.navigationBar setBackgroundImage:imageWithColor(EL_MainColor, 1, 1) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation) name:@"AddressUpdate" object:nil];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"搜索商品/商店";
    self.searchBar.backgroundColor = [UIColor whiteColor];
    [self el_setRightNavImage:[[UIImage imageNamed:@"ic_notice"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:EL_TextColor_Dark}];

}

- (void)o_configDatas {
    
}

- (void)o_configViews{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    [tableView registerClasses:@[@"ELMainCategoryCell",@"ELMineSubCell",@"ELMineHotCell",@"ELMineProductCell",@"ELHomeGoodsCell"]];
    tableView.tableHeaderView = self.bannerView;
    tableView.estimatedRowHeight = 44;
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-49);
    }];
}

- (void)o_loadDatas{
    NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
    if ([cid isKindOfClass:[NSString class]] && cid.length > 0) {
        [ELMainService getHotShop:cid page:1 block:^(BOOL success, id result) {
            if(success){
                NSArray *arr = result[@"shopList"];
                _hotShops = [ELHotShopModel mj_objectArrayWithKeyValuesArray:arr];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        [ELMainService getHotGoods:cid block:^(BOOL success, id result) {
            if (success) {
                _hotGoods = [ELHotGoodsModel mj_objectArrayWithKeyValuesArray:result];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
//        [ELMainService getHomeGoods:cid page:1 count:5 block:^(BOOL success, id result) {
//            if(success){
//                NSArray *arr = result;
//                _hotGoods = [ELHotGoodsModel mj_objectArrayWithKeyValuesArray:arr];
//                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
//
//            }
//        }];
        
        [ELMainService getHotGoodsCategory:cid block:^(BOOL success, id result) {
            if (success) {
                NSArray *arr  = result[@"data"];
                _categories = [ELMainProductModel mj_objectArrayWithKeyValuesArray:arr];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
}

#pragma mark - Search

- (void)o_searchDidTap{
    ELProductListController *vc = [ELProductListController new];
    vc.searchText = self.searchText;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Response 

- (void)el_onRightNavBarTap {
    [self o_onNotiTap];
}

#pragma mark - Private

- (void)p_loadBanners{
    NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
    if ([cid isKindOfClass:[NSString class]] && cid.length > 0) {
        WS(ws);
        [ELMainService getBannerWithAreaId:cid block:^(BOOL success, id result) {
            if (success) {
                NSArray *arr = result[@"player"];
                ws.banners = [ELBannerModel mj_objectArrayWithKeyValuesArray:arr];
                [ws p_setBannerView];
            }
        }];
    }
}

- (void)p_setBannerView{
    __block NSMutableArray *bannerImages = [NSMutableArray arrayWithCapacity:0];
    [self.banners enumerateObjectsUsingBlock:^(ELBannerModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [bannerImages addObject:model.imgUrl];
    }];
    
    [self.bannerView setImageViewAry:bannerImages];
}


- (NSString *)indentiferWithIndex:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return @"ELMainCategoryCell";
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return @"ELMineSubCell";
        }else{
            return @"ELMineHotCell";
        }
    }else if(indexPath.section == 3){
        return @"ELMineProductCell";
    }else{
        return @"ELHomeGoodsCell";
    }
}

#pragma mark - Response
- (void)updateLocation{
    NSString *cityName = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityName"];
    if ([cityName isKindOfClass:[NSString class]] && cityName.length>0) {
        [self.leftButton setTitle:cityName forState:UIControlStateNormal];
        [self.leftButton sizeToFit];
    }

}
- (void)onLocationTap{
    ELLocationController *vc = [[ELLocationController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return _categories.count;
    }
    if (section == 1)
        return 2;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:[self indentiferWithIndex:indexPath]];
    cell.delegate = self;
    if (indexPath.section == 1 && indexPath.row == 0) {
        [cell setData:@{@"title":@"热门店铺"}];
    }else if (indexPath.section == 3){
        [cell setData:_categories[indexPath.row] index:indexPath];
    }else if(indexPath.section == 2){
        [cell setData:_hotGoods];
    }else if(indexPath.section == 1 && indexPath.row == 1){
        [cell setData:_hotShops];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 2) return 0.01;
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        ELReShopController *vc = [ELReShopController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - ELMainBannerViewDelegate
- (void)didClickPage:(ELMainBannerView *)view atIndex:(NSInteger)index{
    ELMainShopController  *vc = [ELMainShopController new];
    ELBannerModel *model = self.banners[index];
    vc.shopId = model.link;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ELHomeGoodsCellDelegate

- (void)homeGoodsCellDidClickWithModel:(ELHotGoodsModel *)model {
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ELMineHotCellDelegate
- (void)hotShopDidSelectWithModel:(ELHotShopModel *)model{
    ELMainShopController  *vc = [ELMainShopController new];
    vc.shopId = model.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ELMainCategoryCellDelegate
- (void)cell:(ELMainCategoryCell *)cell didSelectedIndex:(NSInteger)index{
    if (index == 0) {//热卖
        ELReMaiViewController *vc = [[ELReMaiViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1){//分期
        ELFenqiController *vc = [[ELFenqiController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 2){//电器城
        ELMainShopController  *vc = [ELMainShopController new];
        vc.title = @"电器城";
        vc.shopId = DianQiCheng;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 3){//济佳汇
        ELMainShopController  *vc = [ELMainShopController new];
        vc.title = @"济佳汇";
        vc.shopId = JiJiaHui;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 4){//热门店铺
        ELReShopController *vc = [ELReShopController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 5){//本地特产
        
        ELMainShopController  *vc = [ELMainShopController new];
        vc.title = @"本地特产";
        vc.shopId = BenDiTeChan;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 6){//济佳购
        EL0YuanController *vc = [[EL0YuanController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 7){//分类
        ELCategoryController *vc = [[ELCategoryController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - ELMineProductCellDelegate

- (void)productCellDidSelectWithModel:(ELMainGood *)model
{
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Getters

- (ELMainBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[ELMainBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(135))];
        _bannerView.delegate = self;
    }
    return _bannerView;
}

- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"ic_address"] forState:UIControlStateNormal];
        [_leftButton setTitle:@"济宁" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        _leftButton.titleLabel.font = kFont_System(16.f);
        [_leftButton sizeToFit];
        [_leftButton addTarget:self action:@selector(onLocationTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
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
