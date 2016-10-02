//
//  DBShopSaveViewController.m
//  Ji
//
//  Created by sbq on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBShopSaveViewController.h"
#import "DBNodataView.h"
#import "DBMineService.h"
#import "DBShopCollectionCell.h"
#import "DBShopSaveModel.h"
#import "ELMainShopController.h"
#import "ELReShopController.h"
@interface DBShopSaveViewController ()<UITableViewDataSource,UITableViewDelegate,DBShopCollectionDelegate>

@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)DBNodataView *noDataView;

@end

@implementation DBShopSaveViewController{
    NSInteger curPage_;
    BOOL isHidden_;
}
-(void)o_load{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    isHidden_ = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    self.title = @"店铺收藏";
    
    [self el_setRightNavTitle:@"编辑"];

}

-(void)el_onRightNavBarTap{
    if (self.dataArray.count==0) {
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
    
    [_table reloadData];
    DDLog(@"");

}

-(void)o_configViews{
    
    _noDataView = [DBNodataView new];
    [_noDataView setImage:@"ic_person_collect_img" andUpLabel:@"暂无收藏店铺" andDownLabel:@"" andBtn:@"随便逛逛"];
    [self.view addSubview:_noDataView];
    
    WS(ws);
    _noDataView.addClickBlock = ^(UIButton*btn){
        NSLog(@"暂无店铺，随便逛逛");
        ELReShopController *reVC = [[ELReShopController alloc]init];
        [ws.navigationController pushViewController:reVC animated:YES];
    };
    
    [_noDataView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(1);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT-65);
    }];
    
    

    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    [self.view addSubview:_table];
    _table.estimatedRowHeight = 44;
    _table.rowHeight = UITableViewAutomaticDimension;
    
    [_table registerClasses:@[@"DBShopCollectionCell"]];
    
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws p_headerRefresh];
    }];
    
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws p_footerRefresh];
    }];
    [_table.mj_header beginRefreshing];
    
    
    [_table makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-49);
    }];
    
}

#pragma mark - Refresh Datas

- (void)p_loadDatas {
    WS(ws);
    // {"pagination":{"count":10,"page":1},"user_id":271}
    [DBMineService accFavshopWithUid:UidStr count:20 page:curPage_ block:^(BOOL success, id result) {
        [self p_endRefresh];
        if (success) {
            NSArray *shopList = [DBShopSaveModel mj_objectArrayWithKeyValuesArray:result[@"results"]];
            
            if(curPage_ == 1){
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:shopList];
            
            if (shopList.count == 0) {
                ws.table.mj_footer.hidden = YES;
            }else{
                ws.table.mj_footer.hidden = NO;

            }
            
            if (self.dataArray.count==0 ) {
                ws.table.hidden = YES;
                ws.noDataView.hidden = NO;
                ws.navigationItem.rightBarButtonItem.customView.hidden = YES;
            }else{
                ws.table.hidden = NO;
                ws.noDataView.hidden = YES;
                ws.navigationItem.rightBarButtonItem.customView.hidden = NO;

            }
            [ws.table reloadData];
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
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
}



#pragma mark - Table Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBShopSaveModel *data = self.dataArray[indexPath.section];
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBShopCollectionCell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:data];
    DBShopCollectionCell *shopcell = (DBShopCollectionCell*)cell;
    [shopcell deleteBtnIsHidden:isHidden_];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DBShopSaveModel *model = self.dataArray[indexPath.section];
    ELMainShopController *shop = [[ELMainShopController alloc]init];
    shop.shopId = model.relevanceId ;
    [self.navigationController pushViewController:shop animated:YES];

}
#pragma mark - Cell Delegate

-(void)shopCollectionCell:(DBShopCollectionCell *)cell delete:(UIButton *)btn{
    NSIndexPath *indePath = [self.table indexPathForCell:cell];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DBShopSaveModel *model = self.dataArray[indePath.section];
        
        [DBMineService delShopWithUid:integerToString(model.userId) recId:integerToString(model.collectionId) block:^(BOOL success, id result) {
            if (success) {
                [self.dataArray removeObjectAtIndex:indePath.section];
                [self.table deleteSections:[NSIndexSet indexSetWithIndex:indePath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.view el_makeToast:@"取消收藏成功"];
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
