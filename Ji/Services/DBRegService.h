//
//  DBRegService.h
//  Ji
//
//  Created by sbq on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBRegService : NSObject

/**
 *  注册
 *
 *  @param name      用户名
 *  @param password  密码
 *  @param phone     手机号
 *  @param sessionId 手机验证码
 *
 *  @return
 */
+ (NSURLSessionTask *)registerWithName:(NSString*)name password:(NSString*)password phone:(NSString*)phone sessionId:(NSString*)sessionId block:(AFCompletionBlock)block;

/**
 *  登录
 *
 *  @param name     手机号/邮箱
 *  @param password 密码
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)loginWithName:(NSString*)name password:(NSString*)password  block:(AFCompletionBlock)block;

/**
 *  获取注册验证码
 *
 *  @param phone 手机号
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)sendRegMsgWithPhoneNumber:(NSString*)phone  block:(AFCompletionBlock)block;

/**
 *  验证手机是否存在，,判断手机号是否已注册
 *
 *  @param phone 手机号
 *  @param block 回调
 *
 *  @return
 */
+ (NSURLSessionTask *)signupPhoneWithPhoneNumber:(NSString*)phone  block:(AFCompletionBlock)block;


/**
 *  获取验证码（找回密码）
 *
 *  @param phone 手机号
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)sendForgetPasswordMsgWithPhone:(NSString*)phone block:(AFCompletionBlock)block;

/**
 *  验证码是否有效
 *
 *  @param phone     手机号
 *  @param sessionId sessionid
 *  @param captch    验证码
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)checkForgetCodeWithPhone:(NSString*)phone sessionId:(NSString*)sessionId captch:(NSString*)captch block:(AFCompletionBlock)block;


/**
 *  密码找回修改
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param block
 *
 *  @return
 */
+ (NSURLSessionTask *)saveForgetPasswordWithPhone:(NSString*)phone password:(NSString*)password block:(AFCompletionBlock)block;




@end
