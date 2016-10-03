//
//  ELShopMainController.m
//  Ji
//
//  Created by hushaohui on 16/10/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopMainController.h"
#import "ELMainService.h"
#import "ELMainShopTopModel.h"
#import "ELMainBannerView.h"
#import "ELShopHomeCell.h"
#import "ELShopSearchController.h"
#import "ELGoodDetailController.h"
#import "ELShopProductListController.h"
#import "ELShopMainHeaderView.h"
#import "XLPlainFlowLayout.h"
#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout.h>



typedef NS_ENUM(NSInteger, ShopMainType) {
    ShopMainTypeHome,            // 店铺首页
    ShopMainTypeAllGoods,         // 全部商品
    ShopMainTypeNewGoods          //上新
};


@interface ELShopMainController ()<ELMainBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger  pageNumber ;//当前页数
}

@property (nonatomic, strong) NSMutableArray     *datas;
@property (nonatomic, strong) ELMainShopTopModel *topModel;
@property (nonatomic, strong) UIView             *tableHeaderView;
@property (nonatomic, strong) ELMainBannerView   *bannerView;
@property (nonatomic, weak  ) UIImageView        *topView;
@property (nonatomic, strong) UIView             *bottomView;

@property (nonatomic, strong) ELMainShopTopModel *shopModel;
@property (nonatomic, weak)   UICollectionView   *collectionView;
@property (nonatomic, weak )  UIButton           *collectButton;
@property (nonatomic, strong) UIButton           *categoryButton;
@property (nonatomic, strong) UIWebView *callWebView;


@property (nonatomic, strong)NSMutableArray *homeArry;  ///<店铺首页数组

@property (nonatomic, assign)ShopMainType type;  ///<当前页面的type
@property (nonatomic, weak)ELShopMainHeaderView *headerView ;  ///<头部视图

@end
@implementation ELShopMainController


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

- (void)onProductCategoryTap {
    ELShopSearchController * vc = [[ELShopSearchController alloc] init];
    vc.shopId = self.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)o_viewLoad
{
    [self setup];
}

- (void)o_configDatas
{
    //默认显示店铺首页
    self.type = ShopMainTypeHome;
    
    self.datas = [NSMutableArray array];
    self.homeArry = [NSMutableArray array];
}

- (void)o_loadDatas
{
    [self setupData];
}

- (void)setup
{
    UIBarButtonItem *cateItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryButton];
    self.navigationItem.rightBarButtonItems = @[self.notiItem,cateItem];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.placeholder = @"搜索商品";
    //添加collectionView
    XLPlainFlowLayout *flowOut = [[XLPlainFlowLayout alloc] init];
   // flowOut.parallaxHeaderReferenceSize = CGSizeMake(SCREEN_WIDTH, 255);
    
   // UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
     XLPlainFlowLayout *flowLayout = [[XLPlainFlowLayout alloc] init];
    flowLayout.naviHeight = 0;
    flowLayout.itemNum = 1;
 //   CSStickyHeaderFlowLayout *flowLayout = [[CSStickyHeaderFlowLayout alloc] init];
 //   flowLayout.parallaxHeaderReferenceSize = CGSizeMake(SCREEN_WIDTH, -100);
   flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, kRadioValue(255));//头部大小
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    CGFloat width = (SCREEN_WIDTH - 1)/2;
    CGFloat height = width * 45/32;
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
    [collectionView registerClass:[ELShopHomeCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = EL_BackGroundColor;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新头部
    }];
    collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //刷新尾部
    }];
    [collectionView.mj_header beginRefreshing];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

}

- (void)setupData
{
    pageNumber = 1;
    //测试下数据
    WS(ws);
    [ELMainService getShopHome:self.shopId page:pageNumber block:^(BOOL success, id result) {
        if(success){
            ELMainShopTopModel *model = [ELMainShopTopModel mj_objectWithKeyValues:result];
            _shopModel = model;
            if(pageNumber == 1){
                [self.datas removeAllObjects];
            }
            [self.datas addObjectsFromArray:model.recommendedGoods];
            if (_datas.count == 0) {
                ws.collectionView.mj_footer.hidden = YES;
            }
            [self.headerView setupData:model];
            [ws.collectionView.mj_header endRefreshing];
            [ws.collectionView reloadData];
        }
    }];
}


#pragma mark - UICollectionView delegate dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.type == ShopMainTypeHome){
        if(section == 0){
             return self.datas.count;
        }else{
            return self.datas.count;
        }
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(self.type == ShopMainTypeHome){
        return 2;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ELShopHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell setData:self.datas[indexPath.row]];
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(!self.headerView) return CGSizeMake(SCREEN_WIDTH, 300);
    return CGSizeMake(SCREEN_WIDTH, [self.headerView getHeaderHeight]);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    ELShopMainHeaderView *header = [[ELShopMainHeaderView
                                     alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,MAXFLOAT)];
    [headerView addSubview:header];
    header.controlelr = self;
    self.headerView = header;
    return headerView;
}



//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//{
//        　if(self.type == ShopMainTypeHome){
//            if(indexPath.section == 0){
//    
//                CGFloat width = (SCREEN_WIDTH - 1)/2;
//                CGFloat height = width * 45/2;
//                return CGSizeMake(width, height);
//            }else{
//                CGFloat width = (SCREEN_WIDTH - 1)/2;
//                CGFloat height = width * 45/2;
//                return CGSizeMake(width, height);
//            }
//        }
//    return CGSizeZero;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView
//　　layout:(UICollectionViewLayout *)collectionViewLayout
//　　sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    　　return CGSizeMake(104.0f, 104.0f);
//}



//- (CGSize)collectionView:(UICollectionView *)collectionView
//　　layout:(UICollectionViewLayout *)collectionViewLayout
//　　sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    　if(self.type == ShopMainTypeHome){
//        if(indexPath.section == 0){
//            
//            CGFloat width = (SCREEN_WIDTH - 1)/2;
//            CGFloat height = width * 45/2;
//            return CGSizeMake(width, height);
//        }else{
//            CGFloat width = (SCREEN_WIDTH - 1)/2;
//            CGFloat height = width * 45/2;
//            return CGSizeMake(width, height);
//        }
//    }
//    return CGSizeZero;
//}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELGoodslistModel *model = _datas[indexPath.row];
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}





@end
