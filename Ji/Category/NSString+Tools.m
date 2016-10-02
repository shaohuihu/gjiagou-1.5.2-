//
//  NSString+Tools.m
//  Wai
//
//  Created by lwq on 16/5/5.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "NSString+Tools.h"

static NSDateFormatter *_formatter = nil;
static dispatch_once_t onceToken;

static char boolKey;

@implementation NSString (Tools)

+ (NSDateFormatter *)formatterWithFormat:(NSString *)format
{
    dispatch_once(&onceToken, ^{
        _formatter = [[NSDateFormatter alloc] init];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [_formatter setTimeZone:timeZone];
        _formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    });
    if (format.length > 0) {
        [_formatter setDateFormat:format];
    }
    return _formatter;
}

/** 文字高度 */
- (CGSize)textSizeWithFont:(UIFont *)font size:(CGSize)size
{
    NSString *str = [NSString stringWithFormat:@"%@",self];
    CGRect rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[self class] formatterWithFormat:format];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [[self class] formatterWithFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSDate *)currentTime
{
    return [[self class] dateFromString:[[self class] currentTimeStr] format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)currentTimeStr
{
    return [[self class] stringFromDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)bindBool:(BOOL)tag{
    objc_setAssociatedObject(self, &boolKey, @(tag), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)getBool{
    NSNumber * boolValue = (NSNumber *)objc_getAssociatedObject(self, &boolKey);
    return boolValue.boolValue;
}

- (NSMutableAttributedString *)strikeStringWithFont:(CGFloat)font color:(UIColor *)color {
    NSMutableAttributedString *attributeString =[[NSMutableAttributedString alloc] initWithString:self];
    [attributeString setAttributes:@{NSForegroundColorAttributeName:color,
                                     NSFontAttributeName:[UIFont systemFontOfSize:font],
                                     NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                     }
                             range:NSMakeRange(0,[self length])];
    return attributeString;
}
@end
