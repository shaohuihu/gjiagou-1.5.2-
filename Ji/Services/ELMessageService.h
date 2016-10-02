//
//  ELMessageService.h
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELMessageService : NSObject

+ (NSURLSessionDataTask *)getAllMessageWithPageNum:(NSInteger)page block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)deleteMessages:(NSArray *)msgIds block:(AFCompletionBlock)block;
+ (NSURLSessionDataTask *)getMessageDetailWithMessageId:(NSInteger)msgId id:(NSInteger)id block:(AFCompletionBlock)block;

@end
