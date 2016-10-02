//
//  DBHandel.m
//  Ji
//
//  Created by sbq on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBHandel.h"

@implementation DBHandel
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15(1-3,5-0)，18  176 177  178   147   145开头，八个 \d 数字字符
    NSString *regex = @"^((13[0-9])|(147)|(145)|(15[^4,\\D])|(18[0-9])|(17[0-8]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:mobile];
}

+(NSString*)deleteLastZero:(NSString*)string{
    if ([string containsString:@"."]) {
        NSString *last =[string substringWithRange:NSMakeRange(string.length-1, 1)];
        if ([last isEqualToString:@"0"]) {
            return [string substringToIndex:string.length-1];
        }
    }
    return string;

}

+(NSString *)getTimeStringWithSecond:(long long)second{
    if (second==0) {
        return @"";
    }
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:second/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    return [dateFormatter stringFromDate:date];

}

+(NSString *)getTimeStringWithSecondStr:(NSString*)second{
    if (second.length==0) {
        return @"";
    }
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:[second longLongValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    return [dateFormatter stringFromDate:date];
    
}

+(NSString*)xxxCodePhone:(NSString *)mobile{
    if (mobile.length==11) {
        NSString *head = [mobile substringToIndex:3];
        NSString *wei = [mobile substringWithRange:NSMakeRange(7, 4)];
        NSString *whole = [NSString stringWithFormat:@"%@****%@",head,wei];
        return whole;
    }
    return @"";
}
+(BOOL)isSamePhone:(NSString *)newPhone{
    NSString *mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([mobile isEqualToString:newPhone] && mobile.length==11) {
        return YES;
    }else{
        return NO;
    }
}
@end
