//
//  DBGoodsSaveViewController.m
//  Ji
//
//  Created by sbq on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
// 这个是收藏页面

#import "DBGoodsSaveViewController.h"
#import "DBMineService.h"
#import "DBGoodSaveCell.h"
#import "DBGoodSaveModel.h"
#import "DBNodataView.h"
#import "ELGoodDetailController.h"
#import "ELReMaiViewController.h"
@interface DBGoodsSaveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DBGoodsSaveDelegate>

@property (nonatomic, strong) NSMutableArray     *datas;
@property (nonatomic, strong) DBNodataView       *noDataView;
@property (nonatomic, strong) DBGoodSaveModel    *shopModel;
@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, weak  ) UIButton           *collectButton;

@end


@implementation DBGoodsSaveViewController
{
    NSInteger   curPage_;
    BOOL        isHidden_;
}

- (void)o_load{
    self.datas = [NSMutableArray arrayWithCapacity:0];
   // self.hidesBottomBarWhenPushed = YES;
    isHidden_ = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    self.title = @"商品收藏";
    [self el_setRightNavTitle:@"编辑"];
}

-(void)el_onRightNavBarTap{
    if (self.datas.count==0) {
        return;
    }
    NSString *titles =  self.navigationItem.rightBarButtonItem.title;
    if ([titles isEqualToString:@"编辑"]) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        isHidden_ = NO;
    }else if ([titles isEqualToString:@"完成"]){
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        isHidden_ = YES;
    }
    
    [self.collectionView reloadData];
    DDLog(@"");
    
}

- (void)o_configViews
{

    [self.view addSubview:self.noDataView];
    
    WS(ws);
    self.noDataView.addClickBlock = ^(UIButton*btn){
        NSLog(@"暂无店铺，随便逛逛");
        ELReMaiViewController *reVC = [[ELReMaiViewController alloc]init];
        [ws.navigationController pushViewController:reVC animated:YES];
    };

    [_noDataView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(1);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT-65);
    }];
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view.bottom);
        
    }];
}

#pragma mark - Refresh Datas

- (void)p_loadDatas {
    WS(ws);
    [DBMineService accFavoriteWithUid:UidStr count:20 page:curPage_ block:^(BOOL success, id result) {
        [self p_endRefresh];
        if (success) {
            if(curPage_ == 1){
                [self.datas removeAllObjects];
            }
            NSArray *tmpArray = [DBGoodSaveModel mj_objectArrayWithKeyValuesArray:result[@"results"]];
            [self.datas addObjectsFromArray:tmpArray];
            if (tmpArray.count == 0) {
                ws.collectionView.mj_footer.hidden = YES;
            }else{
                ws.collectionView.mj_footer.hidden = NO;
            }
            
            if (self.datas.count==0 ) {
                ws.collectionView.hidden = YES;
                ws.noDataView.hidden = NO;
                ws.navigationItem.rightBarButtonItem.customView.hidden = YES;
            }else{
                ws.collectionView.hidden = NO;
                ws.noDataView.hidden = YES;
                ws.navigationItem.rightBarButtonItem.customView.hidden = NO;
                
            }
            [ws.collectionView reloadData];
        }
    }];
    
    
    
//    [ELMainService getShopHome:self.shopId page:curPage_ block:^(BOOL success, id result) {
//        [self p_endRefresh];
//        if(success){
//            ELMainShopTopModel *model = [ELMainShopTopModel mj_objectWithKeyValues:result];
//            _shopModel = model;
//            __block NSMutableArray *bannerImages = [NSMutableArray arrayWithCapacity:0];
//            [model.goodsSlides enumerateObjectsUsingBlock:^(ELGoodsslidesModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
//                [bannerImages addObject:model.goodsImage];
//            }];
//            [ws.bannerView setImageViewAry:bannerImages];
//            [ws.topView sd_setImageWithURL:ELIMAGEURL(model.shopInfo.bannerPath)];
//            
//            if(curPage_ == 1){
//                [_datas removeAllObjects];
//            }
//            [_datas addObjectsFromArray:model.goodsList];
//            if (_datas.count == 0) {
//                ws.collectionView.mj_footer.hidden = YES;
//            }
//            [ws.collectionView reloadData];
//        }
//    }];
//    if (Uid) {
//        [ELMainService isShopFavList:self.shopId uId:Uid block:^(BOOL success, id result) {
//            if (success) {
//                self.collectButton.selected = [(NSNumber *)result boolValue];
//            }
//        }];
//    }
    
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
    return self.datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"DBGoodSaveCell";
    DBGoodSaveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.delegate = self;
    [cell setData:self.datas[indexPath.row]];
    DBGoodSaveCell *goodscell = (DBGoodSaveCell*)cell;
    [goodscell deleteBtnIsHidden:isHidden_];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    ELGoodDetailController *goodDetial = [[ELGoodDetailController alloc]init];
    DBGoodSaveModel *model = self.datas[indexPath.item];
    goodDetial.goodId =model.relevanceId ;
    [self.navigationController pushViewController:goodDetial animated:YES];
}



#pragma mark - Response


#pragma mark - Getters
-(DBNodataView *)noDataView
{
    if (_noDataView==nil) {
        _noDataView = [DBNodataView new];
        [_noDataView setImage:@"ic_person_product_img" andUpLabel:@"暂无收藏商品" andDownLabel:@"" andBtn:@"随便逛逛"];
        _noDataView.hidden = YES;

    }
    return _noDataView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, kRadioValue(15));//头部大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) collectionViewLayout:flowLayout];
        CGFloat space = kRadioValue(10);
        CGFloat width = (SCREEN_WIDTH - 3*space)/2;
        CGFloat height = width *45/32;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, space, space, space);//上左下右
        [_collectionView registerClass:[DBGoodSaveCell class] forCellWithReuseIdentifier:@"DBGoodSaveCell"];
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


#pragma mark--cellDelegate

-(void)goodsSaveCell:(DBGoodSaveCell*)cell delete:(UIButton*)btn{
    NSIndexPath *indexPath =  [self.collectionView indexPathForCell:cell];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DBGoodSaveModel *model = self.datas[indexPath.row];
        [DBMineService delCollectionWithUid:UidStr recId:integerToString(model.collectionId) block:^(BOOL success, id result) {
            if (success) {
                [self.datas removeObjectAtIndex:indexPath.row];
                [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
                [self.view el_makeToast:@"删除商品成功"];
                
            }else{
                [self.view el_makeToast:result];
            }
        }];
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
