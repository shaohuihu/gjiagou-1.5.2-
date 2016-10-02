//
//  DBHandel.h
//  Ji
//
//  Created by sbq on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHandel : NSObject
/**
 *  判断是否为正确手机号
 *
 *  @param mobile 手机号
 *
 *  @return Bool
 */
+(BOOL) isValidateMobile:(NSString *)mobile;


/**
 *  剔除字符串的最后一个0
 *
 *  @param string 输入字符串
 *
 *  @return
 */
+(NSString*)deleteLastZero:(NSString*)string;


+(NSString*)getTimeStringWithSecond:(long long)second;
+(NSString *)getTimeStringWithSecondStr:(NSString*)second;
+(NSString*)xxxCodePhone:(NSString*)mobile;

+(BOOL)isSamePhone:(NSString*)newPhone;
@end
