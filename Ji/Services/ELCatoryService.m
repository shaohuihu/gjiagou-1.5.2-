
//
//  ELCatoryService.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCatoryService.h"

@implementation ELCatoryService
//商品分类
+ (NSURLSessionDataTask *)getCategoriesWithBlock:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"classify/findFirst") parameters:nil
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


+ (NSURLSessionDataTask *)getSubCategoriesWithId:(NSInteger)cId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"classify/findChildClassfication") parameters:jsonDict(@{@"id":integerToString(cId)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"][@"ChildClassifyList"]);
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
+ (NSURLSessionDataTask *)getSubCategories1WithId:(NSInteger)cId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"classify/findChildClassfication") parameters:jsonDict(@{@"id":integerToString(cId)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"][@"ChildClassifyList"]);
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

+ (NSURLSessionDataTask *)getCategoryGoodsWithPage:(NSInteger)page para:(NSDictionary *)para block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@{@"page":@(page),@"count":@(20)} forKey:@"pagination"];
    [dict setObject:para forKey:@"filter"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/searchAndroid") parameters:jsonDict(dict)
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


+ (NSURLSessionDataTask *)getCategoryBrandsWithCategoryId:(NSInteger)categoryId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/findClassBrand") parameters:jsonDict(@{@"classId":@(categoryId)})
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


+ (NSURLSessionDataTask *)getGoodsDetailWithGoodsId:(NSInteger)goodsId block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@(goodsId) forKey:@"goodsId"];
    if (UidStr.length > 0) {
        [dict setObject:UidStr forKey:@"userId"];
    }
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/detail") parameters:jsonDict(dict)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                                                                  DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                     }
                                                 }else{
                                                     if (block) {
                                                         block(NO,nil);
                                                     }
                                                 }
                                                 
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 if (block) {
                                                     block(NO,Net_Error_Msg);
                                                 }
                                             }];
}

+ (NSURLSessionDataTask *)getGoodsCommentsGoodsId:(NSInteger)goodsId page:(NSInteger)page block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSDictionary *pagination = @{@"count":@(20),@"page":@(page)};
    [dict setObject:pagination forKey:@"pagination"];
    [dict setObject:@(goodsId) forKey:@"goodsId"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/comments") parameters:jsonDict(dict)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                                                                  DDLog(@"responseObject:%@",responseObject);
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

//收藏商品
+ (NSURLSessionDataTask *)addGoodsToFav:(NSInteger)goodsId block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@{@"uid":@(Uid)} forKey:@"session"];
    [dict setObject:@(Uid) forKey:@"user_id"];
    [dict setObject:@(goodsId) forKey:@"goods_id"];
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/addCollection") parameters:jsonDict(dict)
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

//加入购物车

+ (NSURLSessionDataTask *)addGoodsToCart:(NSInteger)goodsId price:(NSString *)price count:(NSInteger)count storage:(NSString *)storage spec:(NSString *)spec channel:(NSInteger)channel  block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@(Uid) forKey:@"uid"];
    [dict setObject:@(goodsId) forKey:@"goodsId"];
    [dict setObject:@(count) forKey:@"count"];
    [dict setObject:spec forKey:@"standard"];
    [dict setObject:storage forKey:@"storage"];
    [dict setObject:price forKey:@"goodsPrice"];
/***************************这里面对于购物车加入了已channel的字段***************************************************/
    [dict setObject:@(channel) forKey:@"channel"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"cart/createCar") parameters:jsonDict(dict)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"购物车responseObject:%@",responseObject);
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

//http://www.gjiagou.com/api/goods/calculate
//计算选择规格后商品的库存

+ (NSURLSessionDataTask *)calculatePriceWithGoodId:(NSInteger)goodsId spec:(NSString *)spec block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
//    [dict setObject:@(Uid) forKey:@"uid"];
    [dict setObject:integerToString(goodsId) forKey:@"goodsId"];
    [dict setObject:[spec stringByAppendingString:@","] forKey:@"spec"];
    DDLog(@"spec : %@",jsonDict(dict));
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/calculate") parameters:jsonDict(dict)
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
//立即购买

//+ (NSURLSessionDataTask *)saveCartForBillWithGoodsId:(NSInteger)goodsId price:(NSString *)price count:(NSInteger)count storage:(NSString *)storage channel:(NSInteger)channel block:(AFCompletionBlock)block
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
//        [dict setObject:@(Uid) forKey:@"uid"];
//    [dict setObject:integerToString(goodsId) forKey:@"goodsId"];
//    [dict setObject:price forKey:@"goodsPrice"];
//    [dict setObject:@(count) forKey:@"count"];
//    [dict setObject:storage forKey:@"storage"];
//    [dict setObject:@(channel) forKey:@"channel"];
//    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/saveCartForBill") parameters:jsonDict(dict)
//                                            progress:nil
//                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"responseObject:%@",responseObject);
//                                                 if (status.succeed == 1) {
//                                                     if (block) {
//                                                         block(YES,responseObject[@"data"]);
//                                                         /***************这里数据解析获得payment***********************/
//                                                         // NSDictionary * subDic=responseObject[0];
//                                                         NSDictionary * subDic1=[responseObject objectForKey:@"data"];
//                                                         NSDictionary * subDic2=[subDic1 objectForKey:@"orders"];
//                                                         NSDictionary * subDic3=[subDic2 objectForKey:@"304@稻草人专卖@张坤@674"];
//                                                         NSString * payment=[subDic3 objectForKey:@"payment"];
//                                                         DDLog(@"1111%@",payment);
//                                                     }
//                                                 }else{
//                                                     if (block) {
//                                                         block(NO,status.error_desc);
//                                                     }
//                                                 }
//                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                                 if (block) {
//                                                     block(NO,Net_Error_Msg);
//                                                 }
//                                             }];
//}
//根据1.4版本修改
+ (NSURLSessionDataTask *)saveCartForBillWithGoodsId:(NSInteger)goodsId price:(NSString *)price count:(NSInteger)count storage:(NSString *)storage channel:(NSInteger)channel standard:(NSString*)standard block:(AFCompletionBlock)block
{
    if (standard.length==0) {
        standard = @"";
    }
    NSLog(@"storage:%@",storage);
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@(Uid) forKey:@"uid"];
    [dict setObject:integerToString(goodsId) forKey:@"goodsId"];
    [dict setObject:price forKey:@"goodsPrice"];
    [dict setObject:@(count) forKey:@"count"];
    [dict setObject:storage forKey:@"storage"];
    [dict setObject:@(channel) forKey:@"channel"];
    [dict setObject:standard forKey:@"standard"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/saveCartForBill") parameters:jsonDict(dict)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"responseObject:%@",responseObject);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
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





//理解购买
+ (NSURLSessionDataTask *)bugGoodNowWithCartId:(NSNumber *)cartId block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@{@"uid":UidStr} forKey:@"session"];
    [dict setObject:cartId forKey:@"cartId"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/buyGoodsNow") parameters:jsonDict(dict)
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


+ (NSURLSessionDataTask *)getStandardImageWithGoodsId:(NSInteger)goodsId standard:(NSString *)standard block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@(goodsId) forKey:@"goodsId"];
    [dict setObject:standard forKey:@"userId"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/stdpm") parameters:jsonDict(dict)
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

+ (NSURLSessionDataTask *)getStandardPriceWithGoodsId:(NSInteger)goodsId standard:(NSString *)standard block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:integerToString(goodsId) forKey:@"goodsId"];
    [dict setObject:[standard stringByAppendingString:@","] forKey:@"userId"];
    NSLog(@"dict:%@",dict);
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/stdprice") parameters:jsonDict(dict)
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
@end
