//
//  ELShopService.h
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELShopService : NSObject
//购物车列表
+ (NSURLSessionDataTask *)getCartListWithBlock:(AFCompletionBlock)block;
//删除
+ (NSURLSessionDataTask *)deleteCartWithCartId:(NSInteger)cartId block:(AFCompletionBlock)block;
//更新
+ (NSURLSessionDataTask *)updateCartCountWithCartId:(NSInteger)cartId newNumber:(NSInteger)newNumber block:(AFCompletionBlock)block;
//结算界面
+ (NSURLSessionDataTask *)getCheckoutDetailWithBlock:(AFCompletionBlock)block;
//保存订单
//+ (NSURLSessionDataTask *)makeOrderWithAreaId:(NSString *)areaId cartIds:(NSArray*)cartIds addressId:(NSInteger)addressId block:(AFCompletionBlock)block;
//保存订单
+ (NSURLSessionDataTask *)makeOrderWithAreaId:(NSString *)areaId cartIds:(NSArray*)cartIds addressId:(NSInteger)addressId getPayment:(NSString *)pay_code channel:(NSInteger)channel coupon:(NSInteger)coupon  description:(NSString * )description   block:(AFCompletionBlock)block;

//获取签名
+ (NSURLSessionDataTask *)getAliPayInfoWithOrderId:(NSString *)orderId totalFee:(NSString *)totalFee subject:(NSString *)subject block:(AFCompletionBlock)block;
//保存订单支付方式
+ (NSURLSessionDataTask *)SaveOrderPayment:(NSInteger)payment orderNo:(NSString *)orderNo block:(AFCompletionBlock)block;
//用来判断是不是可以用捷信分期
+ (NSURLSessionDataTask *)is0JiexinWithOrderNo:(NSString *)orderNo block:(AFCompletionBlock)block;
//得到用户的活动信息
+ (NSURLSessionDataTask *)MessageJiexinWithOrderNo:(NSString *)orderNo block:(AFCompletionBlock)block;
//传递申请信息
+ (NSURLSessionDataTask *)turnJiexinWithOrderNo:(NSString *)orderNo block:(AFCompletionBlock)block;
@end
