//
//  DBZeroViewController.m
//  Ji
//
//  Created by ssgm on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBZeroViewController.h"
#import "DBTitleCell.h"
#import "DBCircleCell.h"
#import "DBGoodsCell.h"
#import "DBMineService.h"
#import "DBLcModel.h"
#import "DBZeroModel.h"
#import "DBZeroDetialViewController.h"
#import "ELMainService.h"
@interface DBZeroViewController ()<UITableViewDelegate,UITableViewDataSource,DBGoodsDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *lclist;//抽奖码
@property (nonatomic, strong) NSArray  *datas;
@property (nonatomic, strong) NSMutableArray  *goodslist;//奖品

@end

@implementation DBZeroViewController
{
    NSInteger curPage_;
    NSMutableArray * temA;
}

-(void)o_loadDatas{
    self.title = @"我的0元购";
    curPage_ = 1;
    self.navigationItem.rightBarButtonItem = self.notiItem;
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    self.goodslist = [NSMutableArray arrayWithCapacity:0];
    self.lclist = [NSMutableArray arrayWithCapacity:0];
    

    
}
- (void)o_configDatas{
    _datas = @[@[
                   @{
                       @"title":@"我的抽奖码",
                       @"cellClass":@"DBTitleCell"
                       },
                   @{
                       @"cellClass":@"DBCircleCell"
                       }
                   ],
               @[
                   @{
                       @"title":@"我的中奖商品",
                       @"cellClass":@"DBTitleCell"
                       },
                   @{
                       @"cellClass":@"DBGoodsCell"
                       }
                   ]
               ];
}

- (void)o_configViews {
    
    self.view.backgroundColor            = EL_BackGroundColor;
    
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"DBTitleCell",@"DBCircleCell",@"DBGoodsCell"]];
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(0);
    }];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws p_headerRefresh];
    }];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws p_footerRefresh];
    }];
    [tableView.mj_header beginRefreshing];
}


#pragma mark - Refresh Datas
- (void)p_loadDatas {
    WS(ws);
    // {"pagination":{"count":10,"page":1},"user_id":271}
    [DBMineService lotteryWithUid:UidStr count:20 page:curPage_ block:^(BOOL success, id result) {
        [self p_endRefresh];
        if(success){
            
            if(curPage_ == 1){
                [self.goodslist removeAllObjects];
            }
            self.lclist = [DBLcModel mj_objectArrayWithKeyValuesArray:result[@"lc"]];
            /****************在这里面我要对数据进行改动************************/
            
            temA=[NSMutableArray array];
            temA=result[@"lc"];
            NSDictionary * DATA1=[NSDictionary dictionary];
            NSString * temS=[NSString string];
            NSMutableArray * array1=[NSMutableArray array];
            for (int i=0; i<temA.count; i++) {
                DATA1 =[temA objectAtIndex:i];
                temS=[DATA1 objectForKey:@"goodsPicture"];
                
                [array1 addObject:temS];
            }
            
            
            
            
            DDLog(@"求成功%@",DATA1);
            
            DDLog(@"最终数据%@",array1);
            
            

            
            
            NSMutableArray *array  = [DBZeroModel mj_objectArrayWithKeyValuesArray:result[@"results"]];
            [self.goodslist addObjectsFromArray:array];
            if (array.count==0) {
                ws.tableView.mj_footer.hidden = YES;
            }else{
                ws.tableView.mj_footer.hidden = NO;
            }
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
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}




#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        return 1+(self.goodslist.count+1)/2;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = nil;
    

    if ((indexPath.section==0 && indexPath.row==0 ) || (indexPath.section==1 && indexPath.row==0)) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBTitleCell"];
        [cell setData:_datas[indexPath.section][indexPath.row]];
    }
    if (indexPath.section==0 && indexPath.row==1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBCircleCell"];
        [cell setData:self.lclist];
    }
    if (indexPath.section==1 && indexPath.row >=1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBGoodsCell"];

        cell.delegate = self;
        DBGoodsCell *goodsCell = (DBGoodsCell*)cell;
        if (self.goodslist.count%2==0) {
            //偶数
            DBZeroModel *leftModel = self.goodslist[2*(indexPath.row-1)];
            DBZeroModel *rightModel = self.goodslist[2*(indexPath.row-1)+1];
            [goodsCell setDataForleft:leftModel right:rightModel];
        }
        
        if (self.goodslist.count%2==1) {
            //奇数
            if (self.goodslist.count==2*(indexPath.row-1)+1) {
                DBZeroModel *leftModel = self.goodslist[2*(indexPath.row-1)];
                [goodsCell setDataForleft:leftModel right:nil];
            }else{
                DBZeroModel *leftModel = self.goodslist[2*(indexPath.row-1)];
                DBZeroModel *rightModel = self.goodslist[2*(indexPath.row-1)+1];
                [goodsCell setDataForleft:leftModel right:rightModel];
            }
        }
    }
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}


#pragma mark - DBGoodsCellDelegate

-(void)dbGoodsCell:(DBGoodsCell *)cell selectAtIndex:(NSInteger)index{

    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSLog(@"点击了第%d个",2*(indexPath.row-1)+index);
    DBZeroModel *model = self.goodslist[2*(indexPath.row-1)+index];
    DBZeroDetialViewController *de = [[DBZeroDetialViewController alloc]init];
    de.goodsId = model.goodsId;
    [self.navigationController pushViewController:de animated:YES];
    
}


@end