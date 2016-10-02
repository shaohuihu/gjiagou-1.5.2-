//
//  ELReMaiViewController.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELReMaiViewController.h"
#import "ELRemaiCell.h"
#import "ELMainService.h"
#import "ELHotGoodsModel.h"
#import "ELGoodDetailController.h"
@interface ELReMaiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation ELReMaiViewController
{
    NSInteger curPage_;
}


- (void)o_configDatas{
    _datas = [NSMutableArray arrayWithCapacity:0];
}

- (void)o_configViews{
    self.title = @"热卖";
    self.navigationItem.rightBarButtonItem = self.notiItem;

    [self.view addSubview:self.collectionView];
    WS(ws);
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}
#pragma mark - Private

- (void)p_endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}


- (void)p_loadDatas {
    NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
    WS(ws);
    if ([cid isKindOfClass:[NSString class]] && cid.length > 0) {
        [ELMainService getHomeGoods:cid page:curPage_ count:20 block:^(BOOL success, id result) {
            [self p_endRefresh];
            if(success){
                NSArray *arr = result;
                if (curPage_ == 1) {
                    [_datas removeAllObjects];
                }
                [_datas addObjectsFromArray:[ELHotGoodsModel mj_objectArrayWithKeyValuesArray:arr]];
                if (_datas.count == 0) {
                    ws.collectionView.mj_footer.hidden = YES;
                }
                [self.collectionView reloadData];

            }
        }];
    }
}

#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        //定义每个UICollectionView 的大小
        CGFloat width = (SCREEN_WIDTH - 1)/2;
        CGFloat height = width *45/32;
        flowLayout.itemSize = CGSizeMake(width,height);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
        
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[ELRemaiCell class] forCellWithReuseIdentifier:@"cell"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = EL_BackGroundColor;
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        WS(ws);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            curPage_ = 1;
            [ws p_loadDatas];
        }];
        
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            curPage_++;
            [ws p_loadDatas];
        }];
        [_collectionView.mj_header beginRefreshing];

    }
    return _collectionView;
}


#pragma mark - UICollectionView delegate dataSource
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datas.count;
}


#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ELRemaiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell setData:_datas[indexPath.row]];
    return cell;
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    ELHotGoodsModel *model = _datas[indexPath.row];
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
