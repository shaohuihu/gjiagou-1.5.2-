//
//  NSString+Tools.h
//  Wai
//
//  Created by lwq on 16/5/5.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)

/** 文字高度 */
- (CGSize)textSizeWithFont:(UIFont *)font size:(CGSize)size;

/** NSDate -> NString
 format:时间格式（例:yyyy-MM-dd HH:mm:ss）
 默认时区:Asia/Beijing */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
/** NString -> NSDate
 format:时间格式（例:yyyy-MM-dd HH:mm:ss）
 默认时区:Asia/Beijing */
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;
- (void)bindBool:(BOOL)tag;
- (BOOL)getBool;

- (NSMutableAttributedString *)strikeStringWithFont:(CGFloat)font color:(UIColor *)color;

@end
