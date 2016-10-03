//
//  ELMainShopController.m
//  Ji
//
//  Created by evol on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMainShopController.h"
#import "ELMainService.h"
#import "ELMainShopTopModel.h"
#import "ELMainBannerView.h"
#import "ELShopHomeCell.h"
#import "ELShopSearchController.h"
#import "ELGoodDetailController.h"
#import "ELShopProductListController.h"

@interface ELMainShopController ()<ELMainBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray     *datas;
@property (nonatomic, strong) ELMainShopTopModel *topModel;
@property (nonatomic, strong) UIView             *tableHeaderView;
@property (nonatomic, strong) ELMainBannerView   *bannerView;
@property (nonatomic, weak  ) UIImageView        *topView;
@property (nonatomic, strong) UIView             *bottomView;

@property (nonatomic, strong) ELMainShopTopModel *shopModel;
@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, weak  ) UIButton           *collectButton;
@property (nonatomic, strong) UIButton           *categoryButton;

@property (nonatomic, strong) UIWebView *callWebView;

@end


@implementation ELMainShopController
{
    NSInteger curPage_;
}

- (void)o_viewLoad {
    UIBarButtonItem *cateItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryButton];
    self.navigationItem.rightBarButtonItems = @[self.notiItem,cateItem];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"搜索商品";
}

- (void)o_configDatas{
    _datas = [NSMutableArray arrayWithCapacity:0];
}

- (void)o_configViews
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    
    WS(ws);
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(ws.view);
        make.height.equalTo(49);
    }];

    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.bottomView.top);
    }];
}

- (void)o_loadDatas {
    if (Uid) {
        [ELMainService isShopFavList:self.shopId uId:Uid block:^(BOOL success, id result) {
            if (success) {
                self.collectButton.selected = [(NSNumber *)result boolValue];
            }
        }];
    }
}


#pragma mark - Search

- (void)o_searchDidTap{
    ELShopProductListController *vc = [[ELShopProductListController alloc] init];
    vc.isSearch = YES;
    vc.searchText = self.searchText;
    vc.shopId = self.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Refresh Datas

- (void)p_loadDatas {
    WS(ws);
    [ELMainService getShopHome:self.shopId page:curPage_ block:^(BOOL success, id result) {
        [self p_endRefresh];
        if(success){
            ELMainShopTopModel *model = [ELMainShopTopModel mj_objectWithKeyValues:result];
            _shopModel = model;
            __block NSMutableArray *bannerImages = [NSMutableArray arrayWithCapacity:0];
            [model.goodsSlides enumerateObjectsUsingBlock:^(ELGoodsslidesModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                [bannerImages addObject:model.goodsImage];
            }];
            
            [ws.bannerView setImageViewAry:bannerImages];
            [ws.topView sd_setImageWithURL:ELIMAGEURL(model.shopInfo.bannerPath)];
            
            if(curPage_ == 1){
                [_datas removeAllObjects];
            }
            [_datas addObjectsFromArray:model.recommendedGoods];
            if (_datas.count == 0) {
                ws.collectionView.mj_footer.hidden = YES;
            }
            [ws.collectionView reloadData];
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
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

#pragma mark - UICollectionView delegate dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ELShopHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell setData:_datas[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    [headerView addSubview:self.tableHeaderView];//头部广告栏
    
    
    
    
    
    return headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELGoodslistModel *model = _datas[indexPath.row];
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - Response 


- (void)onProductCategoryTap {
    ELShopSearchController * vc = [[ELShopSearchController alloc] init];
    vc.shopId = self.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onContactTap {
    NSString *qqurl = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",_shopModel.shopInfo.qq];
    NSURL *url = [NSURL URLWithString:qqurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    webView.delegate = self;
    [self.callWebView loadRequest:request];
}

- (void)onFavTap:(UIButton *)button{
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    if (button.selected == NO) {
        [ELMainService addShopFavList:self.shopId uId:Uid block:^(BOOL success, id result) {
            if (success) {
                [self.view el_makeToast:@"收藏成功!"];
                self.collectButton.selected = YES;
            }
        }];
    }
}

#pragma mark - ELMainBannerViewDelegate

- (void)didClickPage:(ELMainBannerView *)view atIndex:(NSInteger)index {
    ELGoodsslidesModel *model = _shopModel.goodsSlides[index];
    if (model.fullPath == nil || model.fullPath.length < 1) {
        return;
    }
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = [model.fullPath componentsSeparatedByString:@"="].lastObject.integerValue;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getters

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, kRadioValue(255));//头部大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) collectionViewLayout:flowLayout];
        CGFloat width = (SCREEN_WIDTH - 1)/2;
        CGFloat height = width *45/32;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
        [_collectionView registerClass:[ELShopHomeCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = EL_BackGroundColor;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        WS(ws);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [ws p_headerRefresh];
        }];
        
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [ws p_footerRefresh];
        }];
        [_collectionView.mj_header beginRefreshing];
    }
    return _collectionView;
}


- (UIView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(100))];
        topView.userInteractionEnabled = YES;
        UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectButton setBackgroundImage:[UIImage imageNamed:@"ic_butn_shop_collect"] forState:UIControlStateNormal];
        [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
        [collectButton setTitle:@"已收藏" forState:UIControlStateSelected];
        collectButton.titleLabel.font = kFont_System(14.f);
        [collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [collectButton addTarget:self action:@selector(onFavTap:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:self.collectButton = collectButton];
        [_tableHeaderView addSubview:self.topView = topView];
        
        [collectButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView).offset(-10);
            make.bottom.equalTo(topView).offset(-20);
        }];
        
        [_tableHeaderView addSubview:self.bannerView];
        self.bannerView.el_top = topView.el_bottom + 10;
        _tableHeaderView.el_height = self.bannerView.el_bottom + 10;
    }
    return _tableHeaderView;
}


- (ELMainBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[ELMainBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(135))];
        _bannerView.delegate = self;
    }
    return _bannerView;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        UIView *view = [UIView new];
        view.backgroundColor = EL_Color_Line;
        UIButton *cateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cateButton setBackgroundImage:imageWithColor([UIColor whiteColor], 1, 1) forState:UIControlStateNormal];
        [cateButton setTitle:@"宝贝分类" forState:UIControlStateNormal];
        [cateButton setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
        [cateButton addTarget:self action:@selector(onProductCategoryTap) forControlEvents:UIControlEventTouchUpInside];
        cateButton.titleLabel.font = kFont_System(14.f);
        [view addSubview:cateButton];
        
        UIButton *contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [contactButton setTitle:@"联系卖家" forState:UIControlStateNormal];
        [contactButton setBackgroundImage:imageWithColor([UIColor whiteColor], 1, 1) forState:UIControlStateNormal];
        [contactButton setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
        [contactButton addTarget:self action:@selector(onContactTap) forControlEvents:UIControlEventTouchUpInside];
        [contactButton setImage:[UIImage imageNamed:@"ic_contact"] forState:UIControlStateNormal];
        contactButton.titleLabel.font = kFont_System(14.f);
        [view addSubview:contactButton];
        _bottomView = view;
        
        CGFloat width = (SCREEN_WIDTH - 1)/2;
        [cateButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(view);
            make.top.equalTo(1);
            make.width.equalTo(width);
        }];
        
        [contactButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(view);
            make.width.equalTo(width);
            make.top.equalTo(cateButton);
        }];
    }
    
    return _bottomView;
}

- (UIButton *)categoryButton {
    if (_categoryButton == nil) {
        _categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryButton setTitle:@"分类" forState:UIControlStateNormal];
        UIImage *image = [[UIImage imageNamed:@"ic_list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_categoryButton setImage:image forState:UIControlStateNormal];
        [_categoryButton setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
        _categoryButton.titleLabel.font = kFont_System(14.f);
        [_categoryButton addTarget:self action:@selector(onProductCategoryTap) forControlEvents:UIControlEventTouchUpInside];
        
        [_categoryButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 30, 0, -15)];
        [_categoryButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -20, -15)];
        [_categoryButton sizeToFit];
    }
    return _categoryButton;
}

- (UIWebView *)callWebView {
    if (_callWebView == nil) {
        _callWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_callWebView];
    }
    return _callWebView;
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
