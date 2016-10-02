//
//  ELShopService.m
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopService.h"

@implementation ELShopService

//购物车列表
+ (NSURLSessionDataTask *)getCartListWithBlock:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@{@"uid":@(Uid)} forKey:@"session"];
    [dict setObject:@(Uid) forKey:@"uid"];
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"cart/androidList") parameters:jsonDict(dict)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
}

//删除
+ (NSURLSessionDataTask *)deleteCartWithCartId:(NSInteger)cartId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"cart/delete") parameters:jsonDict(@{@"rec_id":@(cartId)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
}

//更新
+ (NSURLSessionDataTask *)updateCartCountWithCartId:(NSInteger)cartId newNumber:(NSInteger)newNumber block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"cart/update") parameters:jsonDict(@{@"rec_id":@(cartId),@"new_number":@(newNumber)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
}

//结算界面
+ (NSURLSessionDataTask *)getCheckoutDetailWithBlock:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/checkout") parameters:jsonDict(@{@"session":@{@"uid":@(Uid)}})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
}

//生成订单
+ (NSURLSessionDataTask *)makeOrderWithAreaId:(NSString *)areaId cartIds:(NSArray*)cartIds addressId:(NSInteger)addressId getPayment:(NSString *)pay_code channel:(NSInteger)channel coupon:(NSInteger)coupon description:(NSString * )description block:(AFCompletionBlock)block
{
    
  
     DDLog(@"0保存订单里面的payment%@",pay_code);
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
   
   
        
    [ dict setObject:pay_code forKey:@"pay_code"];
    
        
    
    [dict setObject:@{@"uid":UidStr} forKey:@"session"];
    [dict setObject:areaId forKey:@"area_id"];
    [dict setObject:cartIds.mj_JSONString forKey:@"cartIds"];
    [dict setObject:integerToString(addressId) forKey:@"addressId"];
    [dict setObject:integerToString(channel) forKey:@"channel"];
    [dict setObject:integerToString(coupon) forKey:@"coupon"];
    [dict setObject:description forKey:@"description"];
    
    
      return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/saveOrder") parameters:jsonDict(dict)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"生成订单responseObject:%@",responseObject);
                              
                                                 
                                                 
                                
                                
                                                 
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                         DDLog(@"woshi%@",responseObject[@"data"]);
                                                        // DDLog(@"woshi1%@",)
                                                         /***************这里数据解析获得payment***********************/
                                                         // NSDictionary * subDic=responseObject[0];
                                                         NSDictionary * subDic1=[responseObject objectForKey:@"data"];
                                                         NSDictionary * subDic2=[subDic1 objectForKey:@"orders"];
                                                         NSDictionary * subDic3=[subDic2 objectForKey:@"304@稻草人专卖@张坤@674"];
                                                         NSString * payment=[subDic3 objectForKey:@"payment"];
                                                         DDLog(@"1111%@",payment);
                                                         
                                                         
                                                         
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
    
    
    
}

//调用支付宝的接口
+ (NSURLSessionDataTask *)getAliPayInfoWithOrderId:(NSString *)orderId totalFee:(NSString *)totalFee subject:(NSString *)subject block:(AFCompletionBlock)block
{
    NSString * requestURI = [NSString stringWithFormat:@"%@order/toAli?orderNo=%@&subject=%@&total_fee=%@",
                             HTTP_BASE_URL,orderId,subject,totalFee];
    requestURI = [requestURI stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager GET:requestURI parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        DDLog(@"&^&^%@",result);
        if (block) {
            block(YES,result);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(NO,Net_Error_Msg);
        }
    }];
}
//保存订单支付方式
+ (NSURLSessionDataTask *)SaveOrderPayment:(NSInteger)payment orderNo:(NSString *)orderNo block:(AFCompletionBlock)block{
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/savePayment") parameters:jsonDict(@{@"payment":@(payment),@"orderNo":orderNo})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"保存支付方式responseObject:%@",responseObject);
                                                 
                                                 
//                                                 NSDictionary *dic=responseObject[@"data"];
//                                                 
//                                                 NSString * amounts=[dic objectForkey:@"amount"];
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                    
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];

    
    
    
    
    
    
}
//判断是不是可以使用捷信分期
+ (NSURLSessionDataTask *)is0JiexinWithOrderNo:(NSString *)orderNo block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/checkCredit") parameters:jsonDict(@{@"orderNo":orderNo})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                         
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];

}
//得到用户的活动信息
+ (NSURLSessionDataTask *)MessageJiexinWithOrderNo:(NSString *)orderNo block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/getCustomerActivity") parameters:jsonDict(@{@"orderNo":orderNo})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
    

}
//传递申请信息
+ (NSURLSessionDataTask *)turnJiexinWithOrderNo:(NSString *)orderNo block:(AFCompletionBlock)block{
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/getDataApply") parameters:jsonDict(@{@"orderNo":orderNo})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,status.error_desc);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
    

    
    
}

@end
