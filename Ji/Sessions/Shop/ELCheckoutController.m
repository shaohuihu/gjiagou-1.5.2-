//
//  ELCheckoutController.m
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCheckoutController.h"
#import "ELShopService.h"
#import "ELCheckoutBottomView.h"
#import "ELCartListModel.h"
#import "ELOrderInfoModel.h"
#import "UIAlertView+NTESBlock.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DBGoodsAddressViewController.h"
#import "AddressListModel.h"
#import "ELCatoryService.h"
#import "ELGoodsDetailModel.h"
#import "JSDropDownMenu.h"
#import "ELMainService.h"
#import "ELSorceCell.h"
/****************添加的微信支付的东西*****************************/
#import "WXApiManager.h"
#import "WXApiManager.h"
//支付方式选择页面
#import "ELbadSViewController.h"

//#import "TableViewController.h"
//用来设置textView
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface ELCheckoutController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate,UITextViewDelegate>{
    NSString * order_No;
    /**********************下拉选择器*********************************/
    NSMutableArray * _data2;
    NSInteger _currentData2Index;
     NSString * payStr;
    NSString * temStr;
    NSInteger tempnumber;
    NSInteger number;
    UIActionSheet *actionSheet;
    
    NSInteger   payment;
    NSMutableDictionary *dict ;
    
    NSString * pay_code;
    NSNumber *cartId;
    NSString *cid;
  int tem;
    int i;
    int temp;
    NSArray *dic;
    UITextView * text;
    CGSize size;
    UIImageView * imageV;
    UITableView *tableView ;
   
    
}

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, weak) ELCheckoutBottomView *bottomView;
@property (nonatomic, strong) ELOrderInfoModel *orderInfoModel;
@end


@implementation ELCheckoutController

-(void)viewWillAppear:(BOOL)animated{
    temp=0;
    tem=0;i=0;
    pay_code=@"alipay";
    self.tabBarController.tabBar.hidden=YES;
    DDLog(@"结算页面的goodID%ld",(long)self.goodID);
    }
- (void)o_viewLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAliPayResponse:) name:ELNotification_alipayResult object:nil];
    //监听键盘是不是出现获取消失
//    //监听键盘消失
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    //监听键盘出现
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(keyboardWasShown:)
//     
//                                                 name:UIKeyboardDidShowNotification object:nil];
//    
//    //添加手势点击空白处键盘消失
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    //将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
}
//键盘出现的方法
-(void)keyboardWasShown:(NSNotification * )note{
    
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-44-keyBoardRect.size.height);
        
        
        
    }];
  

}


#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-44);
                
        
    }];
  
 [tableView reloadData];
}

//取消键盘的方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    //[text resignFirstResponder];
//    for (UIView * view in [self.view subviews]) {
//        [view removeFromSuperview];
//    }
//    [self o_configViews];
    [text resignFirstResponder];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark-支付的方法
- (void)o_configDatas {
    
    if (self.fromNow) {
    
    //在这里获得catid
    [ELCatoryService saveCartForBillWithGoodsId:self.goodsDetailModel.goods.goodsId price:@(self.totalMoney) count:self.count storage:[NSString stringWithFormat:@"%@",@(self.postage)] channel:2  standard:self.stardandValue block:^(BOOL success, id result) {
        if (success) {
            cartId = result[@"cartId"];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
            [dict setObject:@(Uid) forKey:@"uid"];
            
            
            NSMutableArray * subA=[NSMutableArray array];
            [subA addObject:cartId];
            NSString * comdorderStr=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:subA options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
            //                DDLog(@"希望可以尽快解决吧%@",comdorderStr);
            
            // [dict setObject:@[cartId]  forKey:@"cartIds"];
            //[dict setObject:@[(cartId)] forKey:@"cartIds"];
            // [dict setObject:comdorderStr forKey:@"cattIds"];
            [dict setObject:comdorderStr forKey:@"cartIds"];
            
            
            
            
            [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/isVoucher") parameters:jsonDict(dict)
                                             progress:nil
                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                  ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                  
                                                  
                                                  DDLog(@"是否可以使用代金券responseObject:%@",responseObject);
                                                  
                                                
                                                  dic=responseObject[@"data"];
                                                
//                                                  NSUserDefaults * daiMonNSU=[NSUserDefaults standardUserDefaults];
//                                                  [daiMonNSU setObject:monS forKey:@"daiMon"];
 
                                                if ([dic isEqual:[NSNull null]]) {
                                                  //  NSString *price=[dic objectForKey:@""];
                                                    
                                                    _datas = @[@[
                                                                   @{
                                                                       @"cellClass":@"ELCheckoutAddressCell"
                                                                       }
                                                                   ],
                                                               @[
                                                                   @{
                                                                       @"cellClass":@"ELCheckoutOrderCell"
                                                                       },
                                                                   
                                                                   @{
                                                                       @"title":@"配送方式",
                                                                       @"subTitle":@"快递",
                                                                       @"cellClass":@"ELCheckoutBottomCell"
                                                                       },
                                                                   
                                                                   
                                                                   @{
                                                                      
                                                                       
                                                                       @"title":@"备注",
                                                                       
                                                                       @"subTitle":@"",
                                                                       @"cellClass":@"ELRemarkCell"
                                                                       },
                                                                   
                                                                   ],
                                                               
                                                               ];
                                                    
                                                    [_tableView reloadData];
                                                    
                                    
                                                    
                                                      
                                                }
                                                      else{
                                                         
                                                          NSDictionary * subDic=[dic objectAtIndex:0];
                                                           NSString * price=[subDic objectForKey:@"creditFrom"];
                                                          DDLog(@"代金券的价格%@",price);
                                                          NSUserDefaults * daiMonNSU=[NSUserDefaults standardUserDefaults];
                                                          [daiMonNSU setObject:price forKey:@"daiMon"];
                                                          NSString * showMS=[NSString stringWithFormat:@"使用%@元代金券",price];
                                                          DDLog(@"代金券的标题title:%@",showMS);
                                                          _datas = @[@[
                                                                         @{
                                                                             @"cellClass":@"ELCheckoutAddressCell"
                                                                             }
                                                                         ],
                                                                     @[
                                                                         @{
                                                                             @"cellClass":@"ELCheckoutOrderCell"
                                                                             },
                                                                         
                                                                         @{
                                                                             @"title":@"配送方式",
                                                                             @"subTitle":@"快递",
                                                                             @"cellClass":@"ELCheckoutBottomCell"
                                                                             },
                                                                         
                                                                         
                                                                         @{
                                                                             
                                                                             
                                                                             @"title":@"备注",
                                                                             
                                                                             @"subTitle":@"",
                                                                             @"cellClass":@"ELRemarkCell"
                                                                             },
                                                                         
                                                                         @{
                                                                             @"title":showMS,
                                                                             
                                                                             @"subTitle":@"",
                                                                             
                                                                             @"cellClass":@"ELCheckoutBottomCell"
                                                                             },
                                                                         ],
                                                                     
                                                                    
                                                                     
                                                            ];
                                                          
                                                          [_tableView reloadData];

                                                          
                                                          
                                                          
                                                          
                                                          
                                                      
                                                      
                                                      
                                                      
                                                  }
                                                  
                                                  
                                                  
                                                  
                                                  if (status.succeed == 1) {
                                                  }else{
                                                      
                                                  }
                                                  
                                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                  
                                              }];
            
            
            
            
            
            
            
            
        } else {
            [self showCustomHudSingleLine:@"结算失败"];
        }
 }];
    
    
    
    }
    //在这里面我要先对从购物车过来的进行一次判断
    else{
        if ([self.red_id isEqual:[NSNull null]]) {
            
            _datas = @[@[
                           @{
                               @"cellClass":@"ELCheckoutAddressCell"
                               }
                           ],
                       @[
                           @{
                               @"cellClass":@"ELCheckoutOrderCell"
                               },
                           
                           @{
                               @"title":@"配送方式",
                               @"subTitle":@"快递",
                               @"cellClass":@"ELCheckoutBottomCell"
                               },
                           
                           
                           @{
                               
                               
                               @"title":@"备注",
                               
                               @"subTitle":@"",
                               @"cellClass":@"ELRemarkCell"
                               },
                           
                           ],
                       
                       ];
            
            [_tableView reloadData];
            
            

            
            
        }
        else{
            NSDictionary * gouDic=[self.red_id objectAtIndex:0];
            NSString * price=[gouDic objectForKey:@"creditFrom"];
            DDLog(@"代金券的价格%@",price);
            NSUserDefaults * daiMonNSU=[NSUserDefaults standardUserDefaults];
            [daiMonNSU setObject:price forKey:@"daiMon"];
            NSString * showMS=[NSString stringWithFormat:@"使用%@元代金券",price];
            
            _datas = @[@[
                           @{
                               @"cellClass":@"ELCheckoutAddressCell"
                               }
                           ],
                       @[
                           @{
                               @"cellClass":@"ELCheckoutOrderCell"
                               },
                           
                           @{
                               @"title":@"配送方式",
                               @"subTitle":@"快递",
                               @"cellClass":@"ELCheckoutBottomCell"
                               },
                           
                           
                           @{
                               
                               
                               @"title":@"备注",
                               
                               @"subTitle":@"",
                               @"cellClass":@"ELRemarkCell"
                               },
                           @{
                               @"title":showMS,
                               
                               @"subTitle":@"",
                               
                               @"cellClass":@"ELCheckoutBottomCell"
                               },

                           
                           ],
                       
                       
                       ];
            
            [_tableView reloadData];
            
            
            
            
            
            
 
            
            
            
        }
        

   
    }

}

- (void)o_configViews {
    
    self.title = @"结算";
   
  
    /********************这里面有添加了一个view用来展示可以选择的支付方式*******************/
    
    self.view.backgroundColor = EL_BackGroundColor;
   // UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   tableView               = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   
  
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    [tableView registerClasses:@[@"ELCheckoutAddressCell",@"ELCheckoutOrderCell",@"ELCheckoutBottomCell",@"ELRemarkCell",@"ELChooseCell",@"ELSpecificCell",@"ELPromptCell"]];
    
    
//    [tableView registerNib:[UINib nibWithNibName:@"ELSorceCell" bundle:nil] forCellReuseIdentifier:ELSorceCellID];
    

    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-44);
      //  make.bottom.equalTo(ws.view).offset(-144);
       
        
    }];
    
    ELCheckoutBottomView *bottomView = [[ELCheckoutBottomView alloc] init];
/*********************这里面需要改动的地方，如果点击了优惠券，那么金额减5**************************************/
    
    DDLog(@"今天周六%d",i%2);
    if (i%2==0) {
        
        [bottomView setData:@{
                              @"goods":self.goods,
                              /***************这里面有我要改的地方**********************/
                              @"price":@(self.totalMoney),
                              @"post":@(self.postage),
                              @"count":@(self.count),
                              }];

    }
    else{
#warning 这部分数据是直接写死了，后期需要改成
        NSInteger counNIS=[_moneyS integerValue];
        NSUserDefaults *getMonNSU=[NSUserDefaults standardUserDefaults];
        NSString * daiMonSS=[getMonNSU objectForKey:@"daiMon"];
        NSInteger daiMonNI=[daiMonSS integerValue];
        DDLog(@"减了多少钱%ld",(long)daiMonNI);
    [bottomView setData:@{
                    @"goods":self.goods,
                 /***************这里面有我要改的地方**********************/
                    @"price":@(self.totalMoney-daiMonNI),
                    @"post":@(self.postage),
                    @"count":@(self.count),
                    }];
    }
    [bottomView setCheckoutBlock:^{
        [ws p_saveOrder];
    }];
    [self.view addSubview:self.bottomView = bottomView];
    
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.view);
        make.height.equalTo(44);
    }];
}

- (void)o_loadDatas
{
    [ELShopService getCheckoutDetailWithBlock:^(BOOL success, id result) {
        if (success) {
            NSLog(@"%@",[result[@"defAdd"] mj_JSONString]);
        }
    }];
    
  //getVouchersWhetherWithcartIds:(NSArray *)cartIds uid:(NSInteger)uid
    NSInteger tem=(NSInteger)self.goodsDetailModel.goods.goodsId;
    

}

#pragma mark - Private

- (void)p_saveOrder {

    //这里是判断是不是立即购买
    if (self.fromNow) {
        WS(ws);
        DDLog(@"看看是哪个规格%@",self.stardandValue);
        //调用立即购买功能的接口
        [ELCatoryService saveCartForBillWithGoodsId:self.goodsDetailModel.goods.goodsId price:self.price count:self.count storage:[NSString stringWithFormat:@"%@",@(self.postage)] channel:2 standard:self.stardandValue  block:^(BOOL success, id result) {
            if (success) {
             cartId = result[@"cartId"];
            
               cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
               //在立即购买的地方我要添加一个东西
                DDLog(@"快点好吧%@",cartId);
                DDLog(@"我这个数据%@",cid);
                
                DDLog(@"还有一个小时的时间%@",self.price);
                
                
 /***************************这里有改动的地方,有一个保存订单的方法*************************/
                if (temp%2==0) {
                    tem=0;
                }else {
                    tem=1;
                }
                
                [ELShopService makeOrderWithAreaId:cid cartIds:@[[NSString stringWithFormat:@"%@",cartId]] addressId:self.addressModel.addressId getPayment:pay_code channel:2   coupon:tem  description:text.text block:^(BOOL success, id result) {
                    if (success) {
                        
                        NSDictionary *dict = result[@"orders"];
                        NSArray* AllVaules=[dict allValues];
                        NSMutableArray * order_snA=[NSMutableArray array];
                        NSMutableArray * order_amountA=[NSMutableArray array];

                 
                        NSDictionary *sub = dict.allValues.firstObject;
                      
                       _orderInfoModel = [ELOrderInfoModel mj_objectWithKeyValues:sub[@"order_info"]];
                       
                        payment=sub[@"payment"];
                        
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作成功" message:@"订单生成成功，是否马上支付？" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        
                        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSString *string = [NSString stringWithFormat:@"%.2f",_orderInfoModel.order_amount];
                            NSString *amount = DBPRICE(string);
                            
                            NSMutableArray * arraySN=[NSMutableArray array];
                            NSMutableArray * arrayAM=[NSMutableArray array];
                            for (int i=0; i<AllVaules.count; i++) {
                                NSDictionary * suD=[AllVaules objectAtIndex:i];
                                NSDictionary * chD=[suD objectForKey:@"order_info"];
                                NSString * snS=[chD objectForKey:@"order_sn"];
                                NSNumber *  amount=[chD objectForKey:@"order_amount"];
                                [arraySN addObject:snS];
                                [arrayAM addObject:amount];
                                
                            }
                            
                            DDLog(@"这个是我的数据%@",arraySN);
                            DDLog(@"我的数据%@",arrayAM);
                            
                            
                            
                            ELbadSViewController* choose=[[ELbadSViewController alloc]init];
                            choose.turn_sn=arraySN;
                           choose.turn_amount=arrayAM;
//                            NSNumber * nums=@([self.price integerValue]);
//                            
//                          
//                            NSMutableArray * arr=[NSMutableArray array];
//                            [arr addObject:nums];
//                              choose.turn_amount=arr;
                            choose.goodID=self.goodID;
                            
                          //  [self presentViewController:choose  animated:YES completion:nil];
                            [self.navigationController pushViewController:choose animated:YES];
                            
                    }];
                        
                        
                            
                            
                            
                        [alert addAction:cancel];
                        [alert addAction:ok];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                        
                    }else{
                        [self.view el_makeToast:result];
                    }
                }];
            }
        }];
        
    }
//这里是加入购物车
    else{
        /*************************这里面也有个要改动的地方,调用保存订单的接口****************/
        NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
        __block NSMutableArray *ids = [NSMutableArray arrayWithCapacity:0];
        [self.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ids addObject:[NSString stringWithFormat:@"%ld",(long)obj.rec_id]];
        }];
       
        WS(ws);
        
        if (temp%2==0) {
            tem=0;
        }else {
            tem=1;
        }
        
        [ELShopService makeOrderWithAreaId:cid cartIds:ids addressId:self.addressModel.addressId getPayment:pay_code  channel:2 coupon:tem description:text.text block:^(BOOL success, id result) {
            if (success) {
                NSDictionary *dict = result[@"orders"];
                NSDictionary *sub = dict.allValues.firstObject;
                _orderInfoModel = [ELOrderInfoModel mj_objectWithKeyValues:sub[@"order_info"]];
                
                
                NSArray* AllVaules=[dict allValues];
                NSMutableArray * order_snA=[NSMutableArray array];
                NSMutableArray * order_amountA=[NSMutableArray array];
                
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作成功" message:@"订单生成成功，是否马上支付？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   
                    
                    NSString *string = [NSString stringWithFormat:@"%.2f",_orderInfoModel.order_amount];
                    NSString *amount = DBPRICE(string);
                    
                    //这里面是调用支付宝进行支付的代码
            /*************这里有我需要改动的地方，原来的是用payment进行判断，现在用pay_code进行判断*************************************************/
                    //点击确认之后直接跳转页面
                    NSMutableArray * arraySN=[NSMutableArray array];
                    NSMutableArray * arrayAM=[NSMutableArray array];
                    for (int i=0; i<AllVaules.count; i++) {
                        NSDictionary * suD=[AllVaules objectAtIndex:i];
                        NSDictionary * chD=[suD objectForKey:@"order_info"];
                        NSString * snS=[chD objectForKey:@"order_sn"];
                        NSNumber *  amount=[chD objectForKey:@"order_amount"];
                        [arraySN addObject:snS];
                        [arrayAM addObject:amount];
                        
                    }
                    
                    DDLog(@"这个是我的数据%@",arraySN);
                    DDLog(@"我的数据%@",arrayAM);
                    
                    
                    
                    ELbadSViewController* choose=[[ELbadSViewController alloc]init];
                    choose.turn_sn=arraySN;
                    choose.turn_amount=arrayAM;
                    choose.goodID=self.goodID;
                    
                   // [self presentViewController:choose  animated:YES completion:nil];
                    
                      [self.navigationController pushViewController:choose animated:YES];
                    
                    
                }];
                
                [alert addAction:cancel];
                [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
                
                
            }else{
                [self.view el_makeToast:result];
            }
        }];
    }
    
    
    
    
}

//- (void)p_getOrderRsa {
//    WS(ws);
//    [ELShopService getAliPayInfoWithOrderId:_orderInfoModel.order_sn totalFee:_orderInfoModel.order_amount subject:_orderInfoModel.subject block:^(BOOL success, id result) {
//        if (success) {
//            NSString *appScheme = [ws appSchema:@"alipay"];
//            [[AlipaySDK defaultService] payOrder:result fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                NSLog(@"++++++++++++++++reslut = %@",resultDic);
//            }];
//        }
//    }];
//}
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
    NSString * urlString=[NSString stringWithFormat:@"%@order/toWx?orderNo=%@",HTTP_BASE_URL,_orderInfoModel.order_sn];
    
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
       // NSLog(@"dict:%@",dict);
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

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _datas[section];
    return array.count;
    DDLog(@"array.count%@",array);
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDLog(@"6666");
    dict = _datas[indexPath.section][indexPath.row];
    
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:dict[@"cellClass"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (i%2==0) {
            [cell setData:@{
                            @"goods":self.goods,
                            @"price":@(self.totalMoney),
                            @"post":@(self.postage),
                            @"count":@(self.count),
                            }];

        }
        else{
        [cell setData:@{
                       @"goods":self.goods,
                       @"price":@(self.totalMoney),
                       @"post":@(self.postage),
                       @"count":@(self.count),
                       }];
        }
    }else if (indexPath.section == 0 && indexPath.row == 0){
        [cell setData:self.addressModel];
    }
    else if (indexPath.section==1&& indexPath.row==2){
      
        text=[[UITextView alloc]init];
        text.scrollEnabled=YES;
        text.backgroundColor=[UIColor whiteColor];
        text.delegate=self;
        text.font = kFont_System(10.f);
        text.autocorrectionType=UITextAutocorrectionTypeNo;
        text.autocapitalizationType=UITextAutocapitalizationTypeNone;
        text.keyboardAppearance=UIKeyboardAppearanceAlert;
       
        CGFloat textX=cell.frame.origin.x+60;
        CGFloat textY=cell.frame.origin.y+3;
        CGFloat textW=cell.frame.size.width-textX;
        CGFloat textH=cell.frame.size.height;
        text.frame=CGRectMake(textX, textY, textW, textH-6);
      text.text=@"填写备注";
        text.textColor=[UIColor grayColor];
        text.textAlignment=NSTextAlignmentLeft;
        
        [cell addSubview:text];
        [cell setData:dict];
        
    }
    else if (indexPath.section==1 && indexPath.row==3){
        
       imageV=[[UIImageView alloc]init];
        imageV.image=[UIImage imageNamed:@"ic_unchecked"];
        [cell.contentView addSubview:imageV];
        
        
        
      
            [imageV makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-13);
                make.centerY.equalTo(cell.contentView);
            }];
            
            
    [cell setData:dict];

        
        
        
    }
    else{
        [cell setData:dict];        
       }
    
    
    return cell;
}
//这个是我增加的一个方法



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        WS(ws);
        DBGoodsAddressViewController *vc = [[DBGoodsAddressViewController alloc]init];
        [vc setSelectBlock:^(AddressListModel *model) {
            ws.addressModel = model;
            [ws.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
  /*********************在这里添加一个东西来区分支付方式**************************/
    if (indexPath.section==1&& indexPath.row==3) {
        DDLog(@"我点击了代金券");
        i+=1;
        temp=i;
        DDLog(@"点了%d",i);
        if (i%2==0) {
            imageV.image=[UIImage imageNamed:@"ic_unchecked"];
            
        }
        else{
            imageV.image=[UIImage imageNamed:@"ic_checked"];
        }
        
        
        WS(ws);
        [self.bottomView removeFromSuperview];
        ELCheckoutBottomView *bottomView = [[ELCheckoutBottomView alloc] init];
        
        if ( i%2==0 ) {
            [bottomView setData:@{
                                  @"goods":self.goods,
                                  @"price":@(self.totalMoney),
                                  @"post":@(self.postage),
                                  @"count":@(self.count),
                                  }];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
        }
        else{
           // NSInteger counNIS=[_moneyS integerValue];
#warning 这部分数据是直接写死了的，后期需要改变
            NSUserDefaults *getMonNSU=[NSUserDefaults standardUserDefaults];
            NSString * daiMonSS=[getMonNSU objectForKey:@"daiMon"];
            NSInteger daiMonNI=[daiMonSS integerValue];
            
            [bottomView setData:@{
                                  @"goods":self.goods,
                                  @"price":@(self.totalMoney-daiMonNI),
                                  @"post":@(self.postage),
                                  @"count":@(self.count),
                                  }];
        }
        [bottomView setCheckoutBlock:^{
            [ws p_saveOrder];
        }];
        [self.view addSubview:bottomView];
        
        [bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(ws.view);
            make.height.equalTo(44);
        }];
        
        self.bottomView = bottomView;

    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
