//
//  DBOrderDetialViewController.m
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBOrderDetialViewController.h"
#import "DBMineService.h"
#import "DBOrder.h"
#import "DBOrderDetialModel.h"
#import "DBStateCell.h"
#import "DBOrderAddressCell.h"
#import "DBShopHeadCell.h"
#import "DBContentCell.h"
#import "DBOrderLabelCell.h"
#import "DBOrderTimeCell.h"
#import "DBShouhuoCell.h"
#import "DBTuikuanViewController.h"
#import "ELGoodDetailController.h"
@interface DBOrderDetialViewController ()<UITableViewDelegate,UITableViewDataSource,ContentDelagte>


@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)DBOrderDetialModel *orderDetialModel;
@property(nonatomic,strong)NSMutableArray *timeArray;

@end

@implementation DBOrderDetialViewController

-(void)o_viewAppear{
    [self.tableView.mj_header beginRefreshing];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    self.title = @"订单详情";
}
-(void)o_load{
    self.datas = [NSMutableArray arrayWithCapacity:0];
    self.timeArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)o_configViews {

    self.view.backgroundColor            = EL_BackGroundColor;
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"DBStateCell",@"DBOrderAddressCell",@"DBShopHeadCell",@"DBContentCell",@"DBOrderLabelCell",@"DBOrderTimeCell"]];
    tableView.estimatedRowHeight         = 30;
    tableView.backgroundColor            = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws p_headerRefresh];
    }];
}
#pragma mark - Refresh Datas

- (void)p_loadDatas {
    WS(ws);
    [DBMineService orderDetailUid:UidStr orderId:self.orderId block:^(BOOL success, id result) {
        [self p_endRefresh];
        if (success) {
            self.orderDetialModel = [DBOrderDetialModel mj_objectWithKeyValues:result];
            self.timeArray  = [self getTimeArray];
            [ws.tableView reloadData];
        }
    }];
}

- (void)p_headerRefresh{
    [self p_loadDatas];
}

- (void)p_footerRefresh{
    [self p_loadDatas];
}

- (void)p_endRefresh{
    [self.tableView.mj_header endRefreshing];
}

-(NSMutableArray*)getTimeArray{

    Order *order = self.orderDetialModel.order;
    NSString *codeStr = order.orderNo;//订单编号
    NSString *createTime = [DBHandel getTimeStringWithSecond:order.createDate];//创建时间
    NSString *payTime = [DBHandel getTimeStringWithSecondStr:order.payTime];//付款时间
    NSString *sendTime = [DBHandel getTimeStringWithSecondStr:order.sendDate];//发货时间
    NSString *successTime = [DBHandel getTimeStringWithSecondStr:order.successDate];//收货时间
    
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:0];
    if (codeStr.length>0) {
        [muArr addObject:[NSString stringWithFormat:@"订单编号:%@",codeStr]];
    }
    if (createTime.length>0) {
        [muArr addObject:[NSString stringWithFormat:@"创建时间:%@",createTime]];

    }
    if (payTime.length>0) {
        [muArr addObject:[NSString stringWithFormat:@"付款时间:%@",payTime]];

    }
    if (sendTime.length>0) {
        [muArr addObject:[NSString stringWithFormat:@"发货时间:%@",sendTime]];

    }
    if (successTime.length>0) {
        [muArr addObject:[NSString stringWithFormat:@"收货时间:%@",successTime]];

    }
    return muArr;

}
#pragma mark - UITableViewDelegate UITableViewDataSource
//告知有多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//告知每个分区有多少行
//订单状态 状态  1交易关闭(已取消)2(默认):未付款;3:已付款,待发货;4:已发货;5：已收货;6：申请退货退款
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 5+self.orderDetialModel.goodsList.count;
    
    }else{
        return self.timeArray.count;
    }
}
//告知每个分区的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *goodList = self.orderDetialModel.goodsList;
    Shop *shopModel = self.orderDetialModel.shop;
    Order *order = self.orderDetialModel.order;
    NSLog(@"987%d",goodList.count);
    NSLog(@"765%@",shopModel);
    NSLog(@"654%@",order);
    ELRootCell *cell = nil;
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBStateCell"];
            [cell setData:order];
            
//            DBStateCell *stateCell = (DBStateCell*)cell;
//            if ([self.vcTitle isEqualToString:@"退款订单"]) {
//                cell.data = order;
//                [stateCell setDataTuikuan];
//                
//            }else{
//                cell.data = order;
//                [stateCell setDataFeituikuan];
//            }
            
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBOrderAddressCell"];
            [cell setData:order];

        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {//商店名
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBShopHeadCell"];
            [cell setData:shopModel];
        }else if (indexPath.row<=goodList.count && indexPath.row>0){//商品内容
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBContentCell"];
            cell.delegate = self;
            Goods_List *good = goodList[indexPath.row-1];
            DBContentCell *contentCell = (DBContentCell*)cell;
            contentCell.commentBtn.tag = 5000+indexPath.row-1;
            contentCell.vcTitle = self.vcTitle;
            
            [contentCell setShouhouBtn:order and:good];
            
            [cell setData:good];
#pragma mark这里面我改了些东西
            NSUserDefaults *getpaymentNSU=[NSUserDefaults standardUserDefaults];
            NSString * paymentSS=[getpaymentNSU objectForKey:@"payment"];
            DDLog(@"打印一下订单的payment%@",paymentSS);
//            if ([paymentSS isEqualToString:@"3"]) {
//                contentCell.commentBtn.hidden=YES;
//            }
//            else{
                contentCell.commentBtn.hidden=NO;
           // }

        }else if (indexPath.row==goodList.count+1){//商品总价
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBOrderLabelCell"];
            
            NSString *goodsPrice = [NSString stringWithFormat:@"￥%.2f",order.totalPrice];
            DBOrderLabelCell *labelCell = (DBOrderLabelCell*)cell;
            [labelCell setLeft:@"商品总价" right:DBPRICE(goodsPrice)];

        }else if (indexPath.row==goodList.count+2){//运费
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBOrderLabelCell"];
            NSString *shipPrice = [NSString stringWithFormat:@"￥%.2f",order.shipping];
            DBOrderLabelCell *labelCell = (DBOrderLabelCell*)cell;
            [labelCell setLeft:@"运费(快递)" right:DBPRICE(shipPrice)];
        
        }else if (indexPath.row==goodList.count+3){//订单总价
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBOrderLabelCell"];
            NSString *countPrice = [NSString stringWithFormat:@"￥%.2f",order.countMoney];
            DBOrderLabelCell *labelCell = (DBOrderLabelCell*)cell;
            [labelCell setLeft:@"订单总价" right:DBPRICE(countPrice)];
        }else{//实付款
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBOrderLabelCell"];
            NSString *payment = [NSString stringWithFormat:@"￥%.2f",order.countMoney];
            DBOrderLabelCell *labelCell = (DBOrderLabelCell*)cell;
            [labelCell setLeft:@"实付款" right:DBPRICE(payment)];
        
        }
    
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBOrderTimeCell"];
        [cell setData:self.timeArray[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
    if (section==2) {
        return 15;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[self setHidesBottomBarWhenPushed:YES];
    ELRootCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[DBContentCell class]]) {
        //进去商品详情页
        NSArray *goodList = self.orderDetialModel.goodsList;
        Goods_List *good = goodList[indexPath.row-1];

        ELGoodDetailController *goodVC = [[ELGoodDetailController alloc]init];
        goodVC.goodId = good.goodsId;
        [self.navigationController pushViewController:goodVC animated:YES];
    }
}

-(void)commentBtnClick:(UIButton *)commentBtn{
    Order *order = self.orderDetialModel.order;
    NSInteger index = commentBtn.tag-5000;
    NSArray *goodList = self.orderDetialModel.goodsList;
    Goodslist *good = goodList[index];
    //不能再点了
    if ( good.status==1|| good.status==3|| good.status==4) {
        return;
    }
    WS(ws);
//    NSUserDefaults *getpaymentNSU=[NSUserDefaults standardUserDefaults];
//    NSString * paymentSS=[getpaymentNSU objectForKey:@"payment"];
//    DDLog(@"打印一下订单的payment%@",paymentSS);
//    if ([paymentSS isEqualToString:@"0"]||[paymentSS isEqualToString:@"1"]) {
        [DBMineService calCountWithUid:UidStr orderId:integerToString(order.orderId) goodId:integerToString(good.id) block:^(BOOL success, id result) {
            if (success) {
                DBTuikuanViewController *tui = [[DBTuikuanViewController alloc]init];
                tui.good = good;
                tui.order = order;
                [ws.navigationController pushViewController:tui animated:YES];
            }else{
                [self showCustomHudSingleLine:result];
            }
        }];
   // }
    //在这里要做一个判断，如果是支付宝和微信支付的就走这个接口，else如果是捷信支付的就走新的那个接口 
//    else if ([paymentSS isEqualToString:@"3"]){
//        [DBMineService JiexincalCountWithUid:UidStr orderId:integerToString(order.orderId) block:^(BOOL success,id result){
//            if (success) {
//                DBTuikuanViewController *tui = [[DBTuikuanViewController alloc]init];
//                tui.good = good;
//                tui.order = order;
//                [ws.navigationController pushViewController:tui animated:YES];
//                DDLog(@"成功了");
//            }else{
//                [self showCustomHudSingleLine:result];
//            }
//            
//        }];
//
//    }
    

}
@end
