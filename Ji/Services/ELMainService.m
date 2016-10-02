//
//  ELMainService.m
//  Ji
//
//  Created by evol on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMainService.h"

@implementation ELMainService

//地区
+ (NSURLSessionDataTask *)getAreasWithBlock:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] GET:DMURL(@"area/area") parameters:nil
                                           progress:nil
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                                DDLog(@"responseObject:%@",responseObject);
                                                if (block) {
                                                    block(YES,responseObject);
                                                }
                                                
                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                if (block) {
                                                    block(NO,Net_Error_Msg);
                                                }
                                            }];
}

//广告
+ (NSURLSessionDataTask *)getBannerWithAreaId:(NSString *)areaId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/index") parameters:jsonDict(@{@"areaId":areaId})
                                           progress:nil
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
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
/**
 *  首页热门商品
 */
+ (NSURLSessionDataTask *)getHotGoods:(NSString *)areaId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/hotGoodsApp") parameters:jsonDict(@{@"areaId":areaId})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"hotGoodsApp_responseObject:%@",responseObject);
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

/**
 *  首页热门楼层商品
 */
+ (NSURLSessionDataTask *)getHotGoodsCategory:(NSString *)areaId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"classify/indexFirst") parameters:jsonDict(@{@"areaId":areaId})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"indexFirst_responseObject:%@",responseObject);
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

/**
 *  热卖功能
 */
+ (NSURLSessionDataTask *)getHomeGoods:(NSString *)areaId page:(NSInteger)page count:(NSInteger)count block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:@{@"count":integerToString(count),@"page":integerToString(page)} forKey:@"pagination"];
    [para setObject:@{@"areaId":areaId} forKey:@"filter"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/searchHomeGoods") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"searchHomeGoods_responseObject:%@",responseObject);
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

/**
 *  热门店铺
 */
+ (NSURLSessionDataTask *)getHotShop:(NSString *)areaId page:(NSInteger)page block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:integerToString(0) forKey:@"shopNum"];
    [para setObject:integerToString(page) forKey:@"pageNo"];
    [para setObject:areaId forKey:@"areaId"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/hotShop") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                 DDLog(@"hotShop_responseObject:%@",responseObject);

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

/**
 *  商铺首页
 */
+ (NSURLSessionDataTask *)getShopHome:(NSInteger)shopId page:(NSInteger)page block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:@"shop" forKey:@"type"];
    [para setObject:integerToString(page) forKey:@"pageNo"];
    [para setObject:@(shopId) forKey:@"shopId"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/home") parameters:jsonDict(para)
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

/**
 *  商铺分类
 */
+ (NSURLSessionDataTask *)getShopCategory:(NSInteger)shopId block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
//    [para setObject:[NSString stringWithFormat:@"%@-%@",integerToString(0),integerToString(level)] forKey:@"type"];
    [para setObject:integerToString(shopId) forKey:@"id"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/category") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                                                                  DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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

+ (NSURLSessionDataTask *)getShopCategory1:(NSInteger)shopId block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    //    [para setObject:[NSString stringWithFormat:@"%@-%@",integerToString(0),integerToString(level)] forKey:@"type"];
    [para setObject:integerToString(shopId) forKey:@"id"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/category") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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


/**
 *  收藏商铺
 */
+ (NSURLSessionDataTask *)addShopFavList:(NSInteger)shopId uId:(NSInteger)uId block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:integerToString(shopId) forKey:@"sellerId"];
    [para setObject:integerToString(uId) forKey:@"uid"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/addfav") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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

/**
 *  是否收藏商铺
 */
+ (NSURLSessionDataTask *)isShopFavList:(NSInteger)shopId uId:(NSInteger)uId block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:integerToString(shopId) forKey:@"sellerId"];
    [para setObject:integerToString(uId) forKey:@"uid"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/isfav") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
                                                 if (status.error_code == 1001) {
                                                     if (block) {
                                                         block(YES,@(YES));
                                                     }
                                                 }else if(status.succeed == 1){
                                                     if (block) {
                                                         block(YES,@(NO));
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

/**
 *  商铺分类下商品
 */
+ (NSURLSessionDataTask *)getShopCategoryGoods:(NSInteger)shopId categoryId:(NSInteger)categoryId level:(NSInteger)level pageNo:(NSInteger)pageNo block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:integerToString(shopId) forKey:@"shopId"];
    [para setObject:[NSString stringWithFormat:@"%ld-%ld",(long)categoryId,(long)level] forKey:@"type"];
    [para setObject:integerToString(pageNo) forKey:@"pageNo"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/categoryGoods") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                                                                  DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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


/**
 *  搜索商铺的商品
 */
+ (NSURLSessionDataTask *)getShopSearchWithShopId:(NSInteger)shopId text:(NSString *)text pageNo:(NSInteger)pageNo block:(AFCompletionBlock)block
{
    text = text?:@"";
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:integerToString(shopId) forKey:@"shopId"];
    [para setObject:text forKey:@"type"];
    [para setObject:integerToString(pageNo) forKey:@"pageNo"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"shop/search") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                                                                  DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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

/**
 *  我的0元
 */
+ (NSURLSessionDataTask *)getMy0YuanGouWithUserId:(NSInteger)uid block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/lottery") parameters:jsonDict(@{@"uid":@(uid)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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

/**
 *  是否签到
 */
+ (NSURLSessionDataTask *)is0SignIn:(NSInteger)uid block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"zero/isSignIn") parameters:jsonDict(@{@"uid":@(uid)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
                                                 if (status.succeed == 1) {
                                                     if(status.succeed == 1){
                                                         if (block) {
                                                             block(YES,@(YES));
                                                         }
                                                     }else{
                                                         if (block) {
                                                             block(YES,@(NO));
                                                         }
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
/**
 *  签到
 */
+ (NSURLSessionDataTask *)signInWithUserId:(NSInteger)uid block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"zero/signIn") parameters:jsonDict(@{@"uid":@(uid)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,status.error_desc);
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

/**
 *  抽奖页面
 */
+ (NSURLSessionDataTask *)getDraw0YuanDataWithAreaId:(NSString *)areaId block:(AFCompletionBlock)block
{
    NSLog(@"%@-%@",DMURL(@"zero/drawData"),jsonDict(@{@"areaId":areaId}));
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"zero/drawData") parameters:jsonDict(@{@"uid":areaId})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
//                                                                                                  DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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
/**
 *  中奖名单
 */
+ (NSURLSessionDataTask *)getWinnerListWithAreaId:(NSString *)areaId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"zero/winningRecord") parameters:jsonDict(@{@"uid":areaId})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                                                                  DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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

/**
 *  中奖商品详情
 */
+ (NSURLSessionDataTask *)getDrawGoodsDetailWithGoodsId:(NSInteger)goodsId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"zero/drawGoodsDetail") parameters:@{@"goodsId":@(goodsId)}
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 
                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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

/**
 *  抽奖商品详情
 */
+ (NSURLSessionDataTask *)getDrawDetailWithDrawId:(NSInteger)drawId block:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"zero/drawDetail") parameters:jsonDict(@{@"drawId":@(drawId)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                                                                  DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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

/**
 *  抽奖功能
 */
+ (NSURLSessionDataTask *)getDrawingWithDrawId:(NSInteger)drawId userId:(NSInteger)uid block:(AFCompletionBlock)block
{
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithCapacity:0];
    [para setObject:@(uid) forKey:@"uid"];
    [para setObject:@(drawId) forKey:@"drawId"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"zero/drawing") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
                                                 if (status.succeed == 1 && status.succeed == 1) {
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

//我的代金券
+ (NSURLSessionDataTask *)getVouchersDetailWithUID:(NSInteger)uid block:(AFCompletionBlock)block{
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/vouchers") parameters:jsonDict(@{@"uid":@(uid)})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                DDLog(@"代金券:%@",responseObject);
                                                 
                                                 if (status.succeed == 1) {                                                    if (block) {
                                                         block(YES,status.error_desc);
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
//判断是不是可以使用代金券
+ (NSURLSessionDataTask *)getVouchersWhetherWithcartIds:(NSArray *)cartIds uid:(NSInteger)uid block:(AFCompletionBlock)block{
     NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@(Uid) forKey:@"uid"];

   [dict setObject:cartIds.mj_JSONString forKey:@"cartIds"];
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/isVoucher") parameters:jsonDict(dict)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"是否可以使用代金券responseObject:%@",responseObject);
                                                 
                                                 
                                                 
                                                 
                                                 
                                                 
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"]);
                                                         DDLog(@"woshi%@",responseObject[@"data"]);
                                                         
                                                         
                                                         
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
//获取活动规则
+ (NSURLSessionDataTask *)getRulesWithBlock:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] GET:DMURL(@"notice/rule") parameters:nil
                                           progress:nil
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                //                                                DDLog(@"responseObject:%@",responseObject);
                                                if (block) {
                                                    block(YES,responseObject);
                                                }
                                                
                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                if (block) {
                                                    block(NO,Net_Error_Msg);
                                                }
                                            }];
}

//获取活动弹层
+ (NSURLSessionDataTask *)getThicknessWithBlock:(AFCompletionBlock)block
{
    return [[AFAppDotNetAPIClient sharedClient] GET:DMURL(@"notice/reminder") parameters:nil
                                           progress:nil
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                //                                                DDLog(@"responseObject:%@",responseObject);
                                                if (block) {
                                                    block(YES,responseObject);
                                                }
                                                
                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                if (block) {
                                                    block(NO,Net_Error_Msg);
                                                }
                                            }];
}


//用来改变iosShow的数目
+ (NSURLSessionDataTask *)ChangenumberWithUID:(NSInteger )uid iosShow:(NSString *)iosShow block:(AFCompletionBlock)block{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:integerToString(uid) forKey:@"uid"];
    [para setObject:iosShow forKey:@"iosShow"];
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"notice/reminderShow") parameters:jsonDict(para)
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"hotShop_responseObject:%@",responseObject);
                                                 
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
