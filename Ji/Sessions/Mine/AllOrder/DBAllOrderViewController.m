

//
//  DBAllOrderViewController.m
//  Ji
//
//  Created by sbq on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBAllOrderViewController.h"
#import "DBMineService.h"
#import "DBShopHeadCell.h"
#import "DBContentCell.h"
#import "DBSumCell.h"
#import "DBPayCell.h"
#import "DBOrder.h"
#import "DBShouhuoCell.h"
#import "DBNodataView.h"
#import "DBOrderDetialViewController.h"
#import "DBPingjiaViewController.h"
#import "ELShopService.h"
#import "UIAlertView+NTESBlock.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DBMineService.h"
#import "JSDropDownMenu.h"
#import "ELBasicViewController.h"
/********************这里面有微信支付需要用的东西****************************/
#import "WXApiManager.h"
#import "WXApiManager.h"
#import "ELOrderInfoModel.h"
//进行捷信分期支付
#import "JieViewController.h"
#import "ELGoodDetailController.h"
#import "ELShopController.h"

@interface DBAllOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ContentDelagte,payCellDelaget,shouhuoCellDelaget>{
    NSString * payment;
    NSString * pay_code;
    //这个是用来接收index.path.row
    NSInteger  tempS;
    NSMutableArray * listAry;
}

@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)DBNodataView *noDataView;
@property (nonatomic, strong) ELOrderInfoModel *orderInfoModel;


@end

@implementation DBAllOrderViewController
{
    NSInteger   curPage_;
    BOOL        isHidden_;
}
#pragma mark-这是即可以是待付款订单、待发货订单、待收货订单、待评价订单、退款订单
-(void)o_load{
    self.datas = [NSMutableArray arrayWithCapacity:0];//初始化一个可变的数组
    curPage_ = 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.notiItem;//设置最右边的item,为...
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];//设置最左边的“<”号
    self.title = self.vcTitle;
    // Do any additional setup after loading the view.
#pragma mark-如果这次页面是从选择支付方式页面挑战出来的就给他自定制一个tabbar
    if (_tag==1) {
        UIImage* img=[UIImage imageNamed:@"ic_back_button"];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame =CGRectMake(0, 0,11, 20);
        
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        [btn addTarget: self action: @selector(doback) forControlEvents: UIControlEventTouchUpInside];
        
        UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:btn];
        
        self.navigationItem.leftBarButtonItem=item;
    }
    
}
#pragma mark-这个是我在选择支付方式的时候指定值返回的leftitem的方法
-(void)doback{
    
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
//   
   
    for (UIViewController *controller in self.navigationController.viewControllers) {
       
        if (self.navigationController.viewControllers.count==4) {
            if ([controller isKindOfClass:[ELShopController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        else{
        
        if ([controller isKindOfClass:[ELGoodDetailController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
        }
        DDLog(@"所有的子视图控制器%@",controller);
        
    }
    
    
    
}
- (void)o_configViews {
    _noDataView = [DBNodataView new];
    [_noDataView setImage:@"ic_person_collect_img" andUpLabel:@"暂无订单" andDownLabel:@"" andBtn:@"随便逛逛"];
    [self.view addSubview:_noDataView];
    _noDataView.addBtn.hidden = YES;
    
    WS(ws);
    _noDataView.addClickBlock = ^(UIButton*btn){
        NSLog(@"暂无订单，随便逛逛");
    };
    
    [_noDataView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(1);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT-65);
    }];
    
    
    self.view.backgroundColor            = EL_BackGroundColor;
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"DBShopHeadCell",@"DBContentCell",@"DBSumCell",@"DBPayCell",@"DBShouhuoCell"]];
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws p_headerRefresh];
    }];
//    //MJRefreshBackNormalFooter
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [ws p_footerRefresh];
//    }];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws p_footerRefresh];
    }];
    [tableView.mj_header beginRefreshing];
    
}

#pragma mark - Refresh Datas

- (void)p_loadDatas {
    WS(ws);
    //我的订单
    
    [DBMineService myOrderUid:UidStr count:20 page:curPage_ type:self.orderType block:^(BOOL success, id result) {
        [self p_endRefresh];
        if (success) {
            NSArray *shopList = [DBOrder mj_objectArrayWithKeyValuesArray:result[@"orderList"]];
            
            
            if(curPage_ == 1){
                [self.datas removeAllObjects];
            }
  /****************************************在这里对程序作出改动******************************/
          
            NSDictionary * dic=[[NSDictionary alloc]init];
       
            NSString * string=[NSString string];
            listAry=[[NSMutableArray alloc]init];
            NSMutableArray * tempAry=[[NSMutableArray alloc]init];
            
          for (int i=0; i<shopList.count; i++) {
              dic=[shopList objectAtIndex:i];
            
              string=[dic valueForKey:@"orderNo"];
             if (![listAry containsObject:string]) {
                  [listAry addObject:string];
                  [tempAry addObject:dic];
             }
            
       }
            DDLog(@"tempAry%@",listAry);
            
            [self.datas addObjectsFromArray:tempAry];
           //[self.datas addObjectsFromArray:shopList];
            NSLog(@"^^^^%@",shopList);
            
            
            if (shopList.count == 0) {
                ws.tableView.mj_footer.hidden = YES;
            }else{
                ws.tableView.mj_footer.hidden = NO;
                
            }
            if (self.datas.count==0 ) {
                ws.tableView.hidden = YES;
                ws.noDataView.hidden = NO;
                ws.navigationItem.rightBarButtonItem.customView.hidden = YES;
            }else{
                ws.tableView.hidden = NO;
                ws.noDataView.hidden = YES;
                ws.navigationItem.rightBarButtonItem.customView.hidden = NO;
                
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
//有多少个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //原来是datas.count
    
    return _datas.count;
    
    DDLog(@"分组的个数%lu",(unsigned long)_datas.count);
   
 
}


//订单状态 状态  1交易关闭(已取消)2(默认):未付款;3:已付款,待发货;4:已发货;5：已收货;6：申请退货退款
//每个分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DBOrder *order = self.datas[section];
    
    if (order.state == 2 || order.state==4) {
        //这里做了一些改动，原来为3+order.goods_list.count
        return 3+order.goods_list.count;
    }else{
        //这里做出了改动，原来为2+order.goods_list.count;
        return 2+order.goods_list.count;
    }
    /***************************这里边有我需要改动的地方*******************************/
    //+ (NSURLSessionTask *)saveCommentWithUid:(NSString*)orderNo  block:(AFCompletionBlock)block{
    }

/*
 *  有关退款订单的相关方法
 */
//返回每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBOrder *order = self.datas[indexPath.section];
   
    
    ELRootCell *cell = nil;
    if (indexPath.row==0) {
//在这个头里面加个东西
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBShopHeadCell"];
        DBShopHeadCell *headerCell = (DBShopHeadCell*)cell;
        if ([self.vcTitle isEqualToString:@"退款订单"]) {
            cell.data = order;
            [headerCell setDataTuikuan];
            

        }else{
            cell.data = order;
            [headerCell setDataFeituikuan];
        }
        return cell;
    }else if (indexPath.row > 0 && indexPath.row <= order.goods_list.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBContentCell"];
        Goods_List *goods = order.goods_list[indexPath.row-1];
        cell.delegate = self;
        [cell setData:goods];

        DBContentCell *contentCell = (DBContentCell*)cell;
        if ([self.vcTitle isEqualToString:@"退款订单"]) {
#pragma mark-这里面有改动的地方
           
        DDLog(@"打印订单的状态%ld",(long)order.state);
//            NSUserDefaults *getpaymentNSU=[NSUserDefaults standardUserDefaults];
//            NSString * paymentSS=[getpaymentNSU objectForKey:@"payment"];
//            DDLog(@"打印一下订单的payment%@",paymentSS);
//            if (![paymentSS isEqualToString:@"3"]) {
//                contentCell.commentBtn.hidden=NO;
//                
//                
//                if (order.state==1) {
//                    
//                    [contentCell.commentBtn setTitle:@"退款处理中" forState:UIControlStateNormal];
//                }
//                if (order.state==2) {
//                    
//                    [contentCell.commentBtn setTitle:@"商家已同意" forState:UIControlStateNormal];
//                }
//                if (order.state==3) {
//                    
//                    [contentCell.commentBtn setTitle:@"退款失败" forState:UIControlStateNormal];
//                }
//                if (order.state==4) {
//                    
//                    
//                    [contentCell.commentBtn setTitle:@"退款处理中" forState:UIControlStateNormal];
//                }
//                if (order.state==5) {
//                    
//                    [contentCell.commentBtn setTitle:@"退款成功" forState:UIControlStateNormal];
//                }
//                if (order.state==6) {
//                    
//                    [contentCell.commentBtn setTitle:@"退款处理中" forState:UIControlStateNormal];
//                }
//
//                
//            }
          
                   contentCell.commentBtn.hidden=YES;
            
            
                          // _shopNameLabel.text = order.shopName;
                DDLog(@"这个是我想打印的order:%@",order);
                
           // }
            
            

            
            
            DDLog(@"订单的状态%@",_datas);
            
        }
    else{
            contentCell.commentBtn.hidden = NO;
            [contentCell setCommtnBtn:order];
        }
        contentCell.commentBtn.tag = 10000*indexPath.section+1000*(indexPath.row-1);
    }else if (indexPath.row == order.goods_list.count+1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBSumCell"];
        [cell setData:order];
    }else{
        if (order.state==2) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBPayCell"];
            cell.delegate = self;
        }
        if (order.state==4) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DBShouhuoCell"];
            cell.delegate = self;
        }
    }
    [cell setData:order];
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
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
//这个是点击cell的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        DDLog(@"我点击了第一行");
    }
    
 /**********************这里面有改动的地方，我让一个全局的变量来接收这个indexpath.section*****************/
    //用一个全局的变量，让这个全局的变量来接收我们点击的那个cell
    tempS=indexPath.section;
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   // [self setHidesBottomBarWhenPushed:YES];
    DBOrder *order = self.datas[indexPath.section];
    
    DBOrderDetialViewController *detial = [[DBOrderDetialViewController alloc]init];
    detial.orderId = integerToString(order.orderId);
    detial.payment=integerToString(order.payment);
    
    DDLog(@"order:%@",order);
  
    if (indexPath.row > 0 && indexPath.row <= order.goods_list.count) {
      
        
       
        
       
        if ([self.vcTitle isEqualToString:@"退款订单"]) {
            detial.vcTitle = self.vcTitle;
              DDLog(@"退款订单数量%lu",(unsigned long)order.goods_list.count);
        }
        [self.navigationController pushViewController:detial animated:YES];
    }
}


#pragma mark---contentCelldelegate

-(void)commentBtnClick:(UIButton *)commentBtn{
    if ([commentBtn.titleLabel.text isEqualToString:@"已评价"]) {
        [self.view el_makeToast:@"已经评价完毕"];
        return;
    }
    NSInteger orderIndex = commentBtn.tag/10000;
    NSInteger goodsIndex = commentBtn.tag%10000/1000;
 
    DBOrder *order = self.datas[orderIndex];
    Goods_List *goods = order.goods_list[goodsIndex];
    DBPingjiaViewController *pingjiaVC = [[DBPingjiaViewController alloc]init];
    pingjiaVC.goods = goods;
    pingjiaVC.order = order;
    [self.navigationController pushViewController:pingjiaVC animated:YES];
}


#pragma mark---paycelldelegate

-(void)payCell:(DBPayCell *)cell click:(UIButton *)btn{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DBOrder *order = self.datas[indexPath.section];
    
    if (cell.cancelBtn==btn) {
        NSLog(@"点击了取消订单");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"订单是否取消？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [DBMineService cancelOrderWithUid:UidStr orderId:integerToString(order.orderId) block:^(BOOL success, id result) {
                if (success) {
                    [self.view el_makeToast:@"取消订单成功"];
                    [self.datas removeObjectAtIndex:indexPath.section];
                    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                }else{
                    [self.view el_makeToast:result];
                }
            }];
        }];
        
        [alert addAction:cancel];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else{
        NSLog(@"订单付款");
        //调到支付宝进行付款
        [self p_getOrderRsa:order];
        //order.payment
       

    }
}

#pragma mark - Private

#pragma mark-这个是待付款页面点击支付的一个方法
- (void)p_getOrderRsa:(DBOrder*)order {
    Order_Info *info = order.order_info;
   // DDLog(@"%d",order.payment);
    DDLog(@"pay_code%@",info.pay_code);
    
  
    WS(ws);
 //在这里进行判断payment的数值，来决定我们用的哪一个支付方式
    /****************这里面有需要更改的东西，原来是根据payment进行判断的，现在改用pay_code来进行判断(原来是order.payment，现在为info.pay_code)********************************/
    
    DDLog(@"order.payment=%ld",(long)order.payment);
  if( order.payment==0){
    [ELShopService getAliPayInfoWithOrderId:info.order_sn totalFee:info.order_amount subject:info.subject block:^(BOOL success, id result) {
        if (success) {
            NSString *appScheme = [ws appSchema:@"alipay"];
            [[AlipaySDK defaultService] payOrder:result fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"++++++++++++++++reslut = %@",resultDic);
            }];
        }
    }];
   }
    
   else if(order.payment==1){
       
       NSString * res=[self jumpToBizPay];
       if (![@"" isEqual:res]) {
           UIAlertView * alter=[[UIAlertView alloc]initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alter show];
       }
       
   }
   else if (order.payment==3){
       
       [ELShopService     MessageJiexinWithOrderNo:info.order_sn block:^(BOOL success,id result){
           if (success) {
               DDLog(@"获取用户的活动信息%@",result);
               //NSArray * array=result[@"orderHistory"];
               //利用post请求，将数据传递过去
               //接口地址
               NSString * url=@"https://api-uat.homecredit.cn/morest/api/customer/activities";
               
               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
               manager.requestSerializer = [AFJSONRequestSerializer serializer];
               [manager POST:url parameters:result progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if (success) {
                       DDLog(@"post请求成功");
                       DDLog(@"成功后返回的数据%@",responseObject);
                       
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   DDLog(@"post请求失败");
                   DDLog(@"失败原因%@",error);
                   
                   
               }];
               
               
               
           }
           else{
               DDLog(@"用户活动信息获取失败");
               
           }
           
           
       }];
       //传递申请信息
       [ELShopService    turnJiexinWithOrderNo:info.order_sn block:^(BOOL success,id result){
           if (success) {
               DDLog(@"传递申请信息%@",result);
               
               //在这里面我要重定向的方式将数据传递到客户的接口
               
               
               //NSString * url=@"https://api-uat.homecredit.cn/morest/auth?z={0}";
               NSString * url=@"https://api-uat.homecredit.cn/morest/auth";
               NSString * string=[NSString stringWithFormat:@"%@?z=%@",url,result];
               // http://test.cangjiaquan.com/demo/settlement_info.php?id=-6664321037758168297
               
               
               DDLog(@"我最后的数据%@",string
                     );
               //这个是我增加的代码
               //                        AFSecurityPolicy * secutityPolicy=[[AFSecurityPolicy alloc]init];
               //                        [secutityPolicy setAllowInvalidCertificates:YES];
               
               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
               //                        [manager setSecurityPolicy:secutityPolicy];
               manager.responseSerializer = [AFHTTPResponseSerializer serializer];
               manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
               
               [manager GET:string parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                   DDLog(@"申请成功: %@", responseObject);
                   
                   
                   JieViewController * jieVC=[[JieViewController alloc]init];
                   
                   //[self presentViewController:jieVC animated:YES completion:nil];
                   jieVC.urlS=string;
                   //                            [self.navigationController pushViewController:jieVC animated:YES];
                   [self presentViewController:jieVC animated:YES completion:nil];
                   
                   
               } failure:^(NSURLSessionTask *operation, NSError *error) {
                   
                   DDLog(@"申请失败Error: %@", error);
               }];
               
               
               
               
               
               
               
           }
           else{
               
           }
           
       }];
       
       
       
       
       
       
       
       
   }

    
    
    
   }




- (NSString *)jumpToBizPay {
    // static NSString * orderId=@"1464247251134";
    //根据查询微信api文档，我们需要添加两个需要的判断
    // 判断是否安装了微信
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"没有安装微信");
    }else if (![WXApi isWXAppSupportApi]){
        NSLog(@"不支持微信支付");
    }
    
    
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    /*************************这里面有改动的地方，原来的为_orderInfoModel.order_sn，现在为sTring*************************/
    NSString * urlString=[NSString stringWithFormat:@"%@order/toWx?orderNo=%@",HTTP_BASE_URL,listAry [tempS]];
    
    //NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        
        NSDictionary  * dic=[dict objectForKey:@"data"];
        NSLog(@"url:%@",urlString);
        NSLog(@"dict:%@",dict);
        if(dic != nil){
            NSMutableString *retcode = [dic objectForKey:@"retcode"];
            
            
            NSLog(@"retcode%@",retcode);
            
            //这里有改动的地方，原来的是retcode.intvalue==0
            if (retcode.intValue==0){
                NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dic objectForKey:@"partnerid"];
                NSLog(@"req.partnerId%@",req.partnerId);
                req.prepayId            = [dic objectForKey:@"prepayid"];
                NSLog(@"req.prepayId%@",req.prepayId);
                req.nonceStr            = [dic objectForKey:@"noncestr"];
                NSLog(@"req.nonceStr%@",req.nonceStr);
                req.timeStamp           = stamp.intValue;
                NSLog(@"req.timeStamp%u",(unsigned int)req.timeStamp);
                req.package             = [dic objectForKey:@"package"];
                NSLog(@"req.package%@",req.package);
                req.sign                = [dic objectForKey:@"sign"];
                NSLog(@"req.sign%@",req.sign);
                //发送请求到微信，等待微信返回响应的
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dic objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
    
}



- (NSString *)appSchema:(NSString *)name
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    NSArray * array = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    for ( NSDictionary * dict in array )
    {
        if ( name )
        {
            NSString * URLName = [dict objectForKey:@"CFBundleURLName"];
            if ( nil == URLName )
            {
                continue;
            }
            
            if ( NO == [URLName isEqualToString:name] )
            {
                continue;
            }
        }
        
        NSArray * URLSchemes = [dict objectForKey:@"CFBundleURLSchemes"];
        if ( nil == URLSchemes || 0 == URLSchemes.count )
        {
            continue;
        }
        
        NSString * schema = [URLSchemes objectAtIndex:0];
        if ( schema && schema.length )
        {
            return schema;
        }
    }
    
    return nil;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}


#pragma mark - Response

- (void)onAliPayResponse:(NSNotification *)notification {
    NSNumber *result = notification.object;
    if (result.boolValue == YES) {
        [self.view el_makeToast:@"支付成功"];
        
    }else{
        [self.view el_makeToast:@"支付失败"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}



#pragma mark--shouhuocellDelegate
-(void)shouhuoCell:(DBShouhuoCell *)cell click:(UIButton *)btn{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    DBOrder *order = self.datas[indexPath.section];
    
    if (btn) {
        NSLog(@"收货点击");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认收货？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [DBMineService affirmReceivedWithUid:UidStr orderId:integerToString(order.orderId) block:^(BOOL success, id result) {
                if (success) {
                    [self.view el_makeToast:@"收货成功"];
                    [self.datas removeObjectAtIndex:indexPath.section];
                    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                }else{
                    [self.view el_makeToast:result];
                }
            }];
            
        }];
        
        [alert addAction:cancel];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }

}
@end
