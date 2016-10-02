//
//  DBMineService.m
//  Ji
//
//  Created by sbq on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBMineService.h"

@implementation DBMineService
/*
 * 个人信息的接口请求
 */
+(NSURLSessionTask *)getUserInfoWithUid:(NSString *)uid block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/info") parameters:jsonDict(@{@"uid":uid})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"info22222222:%@",responseObject);
                                                 DDLog(@"%@",[responseObject mj_JSONString]);
//获取到所有的个人信息里面的数据
                                                 DDLog(@"##$$$%@",responseObject[@"data"]);
                                              
                                                 
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

#pragma mark---收货地址相关


//user/accAddress
/**
 *  查询收货地址集合
 *
 *  @param uid   用户id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)accAddressWithUid:(NSString*)uid block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/accAddress") parameters:jsonDict(@{@"uid":uid})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"accAddress:%@",responseObject);
                                                 DDLog(@"%@",[responseObject mj_JSONString]);
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
 *  保存收货地址
 *
 *  @param name          收货人姓名
 *  @param phone         手机号
 *  @param zipCode       邮编
 *  @param provinceName  省
 *  @param cityName      市
 *  @param countryName   县
 *  @param addressDetial 详细地址
 *  @param block
 *
 *  @return
 */

//{"address":{"provinceId":370000,"phone":"15954705429","cityId":370800,"cityName":"济宁市","provinceName":"山东省","addressDetail":"山东省济宁邹城市太平镇东纪沟一村","country":"1","telePhone":"15954705437","countyName":"邹城市","isDefault":0,"zipCode":"273500","userId":303,"userName":"","countyId":370883}}

+ (NSURLSessionTask *)saveAddressWithAddressDic:(NSDictionary *)dic block:(AFCompletionBlock)block{
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/saveAddress") parameters:jsonDict(@{@"address":dic})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"saveAddress:%@",responseObject);
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
 *  收货地址--修改页面
 *
 *  @param aid   地址主键值
 *  @param block
 *
 *  @return
 */  //{"session":{"uid":"327","sid":""},"address_id":"69"}
+ (NSURLSessionTask *)eidtAddressWithAid:(NSString*)aid block:(AFCompletionBlock)block{
    
    NSDictionary *session = @{@"uid":UidStr,@"sid":@""};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/eidtAddress") parameters:jsonDict(@{@"address_id":aid,@"session":session})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"eidtAddress:%@",responseObject);
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
 *  收货地址修改
 *
 *  @return
 */ //{"session":{"uid":"327","sid":""},"address":{"telePhone":"15954705437","provinceId":140000,"countyName":"城　区","phone":"15954705437","isDefault":0,"cityId":140300,"zipCode":"273500","cityName":"阳泉市","userName":"汤方朋","provinceName":"山西省","addressDetail":"高新区基地","countyId":140302,"addressId":69}}
+ (NSURLSessionTask *)updateAddressWithDic:(NSDictionary*)dic block:(AFCompletionBlock)block{
    NSDictionary *session = @{@"uid":UidStr,@"sid":@""};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/updateAddress") parameters:jsonDict(@{@"session":session,@"address":dic})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"updateAddress:%@",responseObject);
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
 *  收货地址删除
 *
 *  @param aid   主键值
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)deleteAddressWithId:(NSString*)aid block:(AFCompletionBlock)block{
    NSDictionary *session = @{@"uid":UidStr,@"sid":@""};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/deleteAddress") parameters:jsonDict(@{@"address_id":aid,@"session":session})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"deleteAddress:%@",responseObject);
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
 *  设为默认收货地址
 *  @return
 *///{"session":{"uid":"327","sid":""},"address_id":"69","user_id":"327"}
+ (NSURLSessionTask *)updateAddressDefaultWithAid:(NSString*)aid block:(AFCompletionBlock)block{
    
    NSDictionary *session = @{@"uid":UidStr,@"sid":@""};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/updateAddressDefault") parameters:jsonDict(@{@"session":session,@"address_id":aid,@"user_id":UidStr})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"updateAddressDefault:%@",responseObject);
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

//获取省市区
+(NSURLSessionTask *)regionWithParentId:(NSString *)p_id block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"area/region") parameters:jsonDict(@{@"parent_id":p_id})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"area:%@",responseObject);
                                                 //DDLog(@"%@",[responseObject mj_JSONString]);

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


+ (void )accFaceWithUid:(NSString*)uid imageData:(NSData*)fileData block:(AFCompletionBlock)block{
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:DMURL(@"user/accFace") parameters:@{@"uid":UidStr} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {                                         //  fileMaterial     UUID
        [formData appendPartWithFileData:fileData name:@"avatar" fileName:@"head.jpg" mimeType:@"image/jpeg"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        
        ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
        DDLog(@"accFace:%@",responseObject);
        if (status.succeed == 1) {
            if (block) {
                block(YES,responseObject[@"data"]);
            }
        }else{
            if (block) {
                block(NO,status.error_desc);
            }
        }

    }];
    [uploadTask resume];
}

/**
 *  修改密码
 *
 *  @param uid          用户id
 *  @param passwordOrig 旧密码
 *  @param passwordNew  新密码
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)updatePassWithUid:(NSString*)uid passwordOrig:(NSString*)passwordOrig passwordNew:(NSString*)passwordNew block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/updatePass") parameters:@{@"uid":uid,@"passwordOrig":passwordOrig,@"passwordNew":passwordNew}
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"XGMM:%@",responseObject);
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
 *  修改性别
 *
 *  @param uid   用户id
 *  @param sex   性别代码（0 1 2）男女保密
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)updateSexWithUid:(NSString*)uid sex:(NSString*)sex block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/updateSex") parameters:jsonDict(@{@"uid":uid,@"sex":sex})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"updateSex:%@",responseObject);
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


//获取手机验证码 http://www.gjiagou.com/api/user/bindMobile    json:  {'phone':15954705439}
+ (NSURLSessionTask *)bindMobileWithPhone:(NSString*)phone block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/bindMobile") parameters:jsonDict(@{@"phone":phone})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"bindMobile:%@",responseObject);
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

//修改绑定手机号：   http://www.gjiagou.com/api/user/updateMobile      json：{"phone"：15954705437 "userId":128}
+ (NSURLSessionTask *)updateMobleWithUid:(NSString*)uid phone:(NSString*)phone block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/updateMoble") parameters:jsonDict(@{@"userId":uid,@"phone":phone})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"iphone:%@",responseObject);
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



#pragma mark--扫描二维码
/**
 *  绑定商户
 *
 *  @param uid      用户id
 *  @param sellerId 商户id
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)bindWithUid:(NSString*)uid sellerId:(NSString*)sellerId block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/bind") parameters:@{@"uid":uid,@"sellerId":sellerId}
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"():%@",responseObject);
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



#pragma mark--0yuan


+(NSURLSessionTask *)lotteryWithUid:(NSString *)uid count:(NSInteger)count page:(NSInteger)page block:(AFCompletionBlock)block{
    
    NSDictionary *pagination = @{@"count":integerToString(count),@"page":integerToString(page)};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/lottery") parameters:jsonDict(@{@"uid":uid,@"pagination":pagination})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //DDLog(@"responseObject:%@",responseObject);
                                                // DDLog(@"%@",[responseObject mj_JSONString]);
             DDLog(@"00000%@",responseObject);
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

#pragma mark--商品收藏

//pageNo:分页
//createDate1:
//goodsName:商品名称
//userId:用户id
+(NSURLSessionTask *)accFavoriteWithUid:(NSString *)uid count:(NSInteger)count page:(NSInteger)page block:(AFCompletionBlock)block{
    NSDictionary *pagination = @{@"count":integerToString(count),@"page":integerToString(page)};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/accFavorite") parameters:jsonDict(@{@"user_id":uid,@"pagination":pagination})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //DDLog(@"responseObject:%@",responseObject);
                                                // DDLog(@"%@",[responseObject mj_JSONString]);
DDLog(@"$$$$$%@",responseObject);
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

+(NSURLSessionTask *)delCollectionWithUid:(NSString *)uid recId:(NSString *)recId block:(AFCompletionBlock)block{
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/delCollection") parameters:jsonDict(@{@"user_id":uid,@"rec_id":recId})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                // DDLog(@"responseObject:%@",responseObject);
                                                 //DDLog(@"%@",[responseObject mj_JSONString]);
                                                 
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




#pragma mark--铺收藏
+(NSURLSessionTask *)accFavshopWithUid:(NSString *)uid count:(NSInteger)count page:(NSInteger)page block:(AFCompletionBlock)block{
    NSDictionary *pagination = @{@"count":integerToString(count),@"page":integerToString(page)};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/accFavshop") parameters:jsonDict(@{@"user_id":uid,@"pagination":pagination})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                // DDLog(@"responseObject:%@",responseObject);
                                               //  DDLog(@"%@",[responseObject mj_JSONString]);
                                                 DDLog(@"&&&&&%@",responseObject);
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
//{"user_id":"271","rec_id":"255"}

+(NSURLSessionTask *)delShopWithUid:(NSString *)uid recId:(NSString *)recId block:(AFCompletionBlock)block{

    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/delShop") parameters:jsonDict(@{@"user_id":uid,@"rec_id":recId})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                // DDLog(@"responseObject:%@",responseObject);
                                                 //DDLog(@"%@",[responseObject mj_JSONString]);
                                                 DDLog(@"***%@",responseObject);
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

#pragma mark--订单相关
//我的订单
+ (NSURLSessionTask *)myOrderUid:(NSString*)uid count:(NSInteger)count page:(NSInteger)page type:(NSString*)type  block:(AFCompletionBlock)block{
    
    NSDictionary *pagination = @{@"count":integerToString(count),@"page":integerToString(page)};
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/myOrder") parameters:jsonDict(@{@"pagination":pagination,@"uid":uid,@"type":type})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                // DDLog(@"2222responseObject:%@",responseObject);
                                                 
                                                // DDLog(@"3333%@",[responseObject mj_JSONString]);
                                                 
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


+(NSURLSessionTask *)orderDetailUid:(NSString *)uid orderId:(NSString *)orderId block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/orderDetail") parameters:jsonDict(@{@"orderId":orderId,@"uid":uid})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //DDLog(@"4444responseObject:%@",responseObject);
                                                 //DDLog(@"5555%@",[responseObject mj_JSONString]);
                                                 DDLog(@"|||%@",responseObject);
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

+ (void )commentImgWithUid:(NSString*)uid imageData:(NSData*)fileData block:(AFCompletionBlock)block{

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:DMURL(@"goods/commentImg") parameters:@{@"uid":UidStr} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {                                         //  fileMaterial     UUID
        [formData appendPartWithFileData:fileData name:@"avatar" fileName:@"goods.jpg" mimeType:@"image/jpeg"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
        DDLog(@"[[[%@",responseObject);
        //DDLog(@"responseObject:%@",responseObject);
        if (status.succeed == 1) {
            if (block) {
                block(YES,responseObject[@"data"]);
            }
        }else{
            if (block) {
                block(NO,status.error_desc);
            }
        }
        
    }];
    [uploadTask resume];
}

//goods/saveComment 保存商品评价 {"uid":"156","goodsContent":"很好非常好","goodsId":"15","goodsImage":/imgs/399394ssdcusd.jpg","orderId":"755"}
+ (NSURLSessionTask *)saveCommentWithUid:(NSString*)uid goodsContent:(NSString*)goodContent goodsId:(NSString*)goodsId goodImage:(NSString*)goodsImage orderId:(NSString*)orderId block:(AFCompletionBlock)block{

    if (goodsImage.length==0) {
        goodsImage = @"";
    }
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/saveComment") parameters:jsonDict(@{@"orderId":orderId,@"uid":uid,@"goodsContent":goodContent,@"goodsId":goodsId,@"goodsImage":goodsImage})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //DDLog(@"responseObject:%@",responseObject);
                                                 //DDLog(@"%@",[responseObject mj_JSONString]);
                                                 DDLog(@"\\\%@",responseObject);
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
//user/cancelOrder
//取消订单
+ (NSURLSessionTask *)cancelOrderWithUid:(NSString*)uid orderId:(NSString*)orderId block:(AFCompletionBlock)block{

    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/cancelOrder") parameters:jsonDict(@{@"orderId":orderId,@"uid":uid})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                // DDLog(@"responseObject:%@",responseObject);
                                                // DDLog(@"%@",[responseObject mj_JSONString]);
                                                 DDLog(@"~~~~取消订单%@",responseObject);
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

+ (NSURLSessionTask *)affirmReceivedWithUid:(NSString*)uid orderId:(NSString*)orderId block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/affirmReceived") parameters:jsonDict(@{@"orderId":orderId,@"uid":uid})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                // DDLog(@"responseObject:%@",responseObject);
                                                // DDLog(@"%@",[responseObject mj_JSONString]);
                                                 DDLog(@"&&&&%@",responseObject);
                                                 
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
//退货申请次数
+ (NSURLSessionTask *)calCountWithUid:(NSString*)uid orderId:(NSString*)orderId goodId:(NSString*)goodId block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/calCount") parameters:@{@"orderId":orderId,@"goodId":goodId}
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                // DDLog(@"responseObject:%@",responseObject);
                                                 //DDLog(@"%@",[responseObject mj_JSONString]);
                                                 DDLog(@"!!!!%@",responseObject);
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
//保存捷信支付退款次数
+ (NSURLSessionTask *)JiexincalCountWithUid:(NSString*)uid orderId:(NSString*)orderId  block:(AFCompletionBlock)block{
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/calCountNum") parameters:@{@"orderId":orderId}
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 // DDLog(@"responseObject:%@",responseObject);
                                                 //DDLog(@"%@",[responseObject mj_JSONString]);
                                                 DDLog(@"!!!!%@",responseObject);
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
















#pragma mark-进行退款的方法
//* 退款原因 1:缺货 2：协调一致退款 3:未按时间发货 4:拍错/多拍/不想要 5其他
//Refund( orderId=645, refundNo=1464249829637, refundPrice=86.4, userId=303, applyService=0, reason=2, description=退款, orderGoodsId=618, orderStatus=2）
+ (NSURLSessionTask *)saveRefundWithUid:(NSString*)uid orderId:(NSString*)orderId refundNo:(NSString*)refundNo refundPrice:(NSString*)refundPrice applyService:(NSString*)applyService reason:(NSString*)reason description:(NSString*)description orderGoodsId:(NSString*)orderGoodsId orderStatus:(NSString*)orderStatus block:(AFCompletionBlock)block{
    if (description.length==0) {
        description = @"";
    }
    
//    NSString *url = @"http://192.168.199.103:8080/front/api/order/saveRefund";
    //applyService=1&userId=271&refundPrice=0&description=直接忽略&orderStatus=3&orderId=691&orderGoodsId=668&reason=5
     //userid 271 , orderId =708 ,applyService = 1,reason  =1, orderGoodsId 685, description = 00,orderStatus=3
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"order/saveRefund") parameters:@{@"orderId":orderId,@"refundPrice":refundPrice,@"userId":uid,@"applyService":applyService,@"reason":reason,@"description":description,@"orderGoodsId":orderGoodsId,@"orderStatus":orderStatus}
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 //DDLog(@"responseObject:%@",responseObject);
                                                 DDLog(@"@@@@@@%@",[responseObject mj_JSONString]);
                                                // DDLog(@"@@@@%@",responseObject mj_JSONString);
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
/***********************************************************这里面是我加的微信支付的东西*********************************************************/

//goods/saveComment 保存商品评价 {"uid":"156","goodsContent":"很好非常好","goodsId":"15","goodsImage":/imgs/399394ssdcusd.jpg","orderId":"755"}
+ (NSURLSessionTask *)saveCommentWithUid:(NSString*)orderNo  block:(AFCompletionBlock)block{
    
   
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"goods/saveComment") parameters:jsonDict(@{@"orderNO":orderNo})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"\\\%@",responseObject);
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
