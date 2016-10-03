//
//  ELReShopController.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELReShopController.h"
#import "ELMainService.h"
#import "ELReshopCell.h"
#import "ELHotShopModel.h"
#import "ELMainShopController.h"
#import "ELShopMainController.h"

@interface ELReShopController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ELReShopController

- (void)o_configDatas{
    _datas = [NSMutableArray arrayWithCapacity:0];
}

- (void)o_configViews{
    self.title = @"热门店铺";
    self.navigationItem.rightBarButtonItem = self.notiItem;

    [self.view addSubview:self.collectionView];
    WS(ws);
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}

- (void)o_loadDatas {
    NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
    if ([cid isKindOfClass:[NSString class]] && cid.length > 0) {
        [ELMainService getHotShop:cid page:1 block:^(BOOL success, id result) {
            if (success) {
                NSArray *arr = result[@"shopList"];
                _datas = [ELHotShopModel mj_objectArrayWithKeyValuesArray:arr];
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
        CGFloat width = (SCREEN_WIDTH - 5*6)/4;
        CGFloat height = width *594/1600;
        flowLayout.itemSize = CGSizeMake(width,height);
        flowLayout.minimumLineSpacing = 6;
        flowLayout.minimumInteritemSpacing = 6;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 0, 6);//上左下右
        
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[ELReshopCell class] forCellWithReuseIdentifier:@"cell"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = EL_BackGroundColor;
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
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
    ELReshopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell setData:_datas[indexPath.row]];
    return cell;
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELHotShopModel *model = _datas[indexPath.row];
    ELShopMainController  *vc = [ELShopMainController new];
    vc.shopId = model.shopId;
    vc.title = model.name;
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
