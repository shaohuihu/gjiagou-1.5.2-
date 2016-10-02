//
//  ELMessageService.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMessageService.h"

@implementation ELMessageService
//消息列表
+ (NSURLSessionDataTask *)getAllMessageWithPageNum:(NSInteger)page block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:UidStr forKey:@"uid"];
    [dict setObject:@(page) forKey:@"pageNo"];
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/myAllMessages") parameters:jsonDict(dict)
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

+ (NSURLSessionDataTask *)getMessageDetailWithMessageId:(NSInteger)msgId id:(NSInteger)mId block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:integerToString(msgId) forKey:@"uid"];
    [dict setObject:integerToString(mId) forKey:@"pageNo"];
    
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/MessageDetail") parameters:jsonDict(dict)
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

+ (NSURLSessionDataTask *)deleteMessages:(NSArray *)msgIds block:(AFCompletionBlock)block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:msgIds forKey:@"messages"];
    return [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/delAppMessage") parameters:jsonDict(dict)
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
