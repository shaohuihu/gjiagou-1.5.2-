//
//  DBRegService.m
//  Ji
//
//  Created by sbq on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBRegService.h"

@implementation DBRegService
+(NSURLSessionTask *)registerWithName:(NSString *)name password:(NSString *)password phone:(NSString *)phone sessionId:(NSString *)sessionId block:(AFCompletionBlock)block{

    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/signup") parameters:jsonDict(@{@"name":name,@"password":password,@"phone":phone,@"sessionId":sessionId})
                                                   progress:nil
                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                        ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                        DDLog(@"responseObject:%@",responseObject);
                                                        if (status.succeed == 1) {
                                                            if (block) {
                                                                block(YES,@"注册成功");
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

+(NSURLSessionTask *)loginWithName:(NSString *)name password:(NSString *)password block:(AFCompletionBlock)block{

    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/signin") parameters:jsonDict(@{@"name":name,@"password":password})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"responseObject:%@",responseObject);
                                                 
                                                 DDLog(@"%@",[responseObject mj_JSONString]);
                                                 if (status.succeed == 1) {
                                                     if (block) {
                                                         block(YES,responseObject[@"data"][@"user"]);
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
//发送手机注册验证码
+(NSURLSessionTask *)sendRegMsgWithPhoneNumber:(NSString *)phone block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/sendRegMsg") parameters:jsonDict(@{@"phone":phone})
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

+(NSURLSessionTask *)signupPhoneWithPhoneNumber:(NSString *)phone block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/signupPhone") parameters:jsonDict(@{@"phone":phone})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"responseObject:%@",responseObject);
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

+(NSURLSessionTask *)sendForgetPasswordMsgWithPhone:(NSString *)phone block:(AFCompletionBlock)block{

    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/sendForgetPasswordMsg") parameters:jsonDict(@{@"phone":phone})
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

+ (NSURLSessionTask *)checkForgetCodeWithPhone:(NSString *)phone sessionId:(NSString *)sessionId captch:(NSString *)captch block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/checkForgetCode") parameters:jsonDict(@{@"phone":phone,@"sessionId":sessionId,@"captch":captch})
                                            progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                 DDLog(@"responseObject:%@",responseObject);
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


+(NSURLSessionTask *)saveForgetPasswordWithPhone:(NSString *)phone password:(NSString *)password block:(AFCompletionBlock)block{
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/saveForgetPassword") parameters:jsonDict(@{@"phone":phone,@"password":password})
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
