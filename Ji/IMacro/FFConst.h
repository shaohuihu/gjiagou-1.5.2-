
//
//  FFConst.h
//  Commerce
//
//  Created by evol on 15/1/6.
//  Copyright (c) 2015年 __evol __. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewExt.h"


/**
 *  Color
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(a,b,c)         [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]
#define RGBA(r,g,b,a)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HTTP_BASE_IMAGE_URL     @"http://www.gjiagou.com/"
//#define ELIMAGEURL(__xx__)      [NSURL URLWithString:[[HTTP_BASE_IMAGE_URL stringByAppendingString:__xx__] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]

#define ELPresentLogin  [(AppDelegate *)[UIApplication sharedApplication].delegate presentLoginView]


#define BQ_NaviColor           RGB(251,252,255)
#define BQ_CategoryColor       UIColorFromRGB(0xf5f5f5)
#define EL_MainColor           UIColorFromRGB(0xdd2727)
#define EL_BackGroundColor     UIColorFromRGB(0xecedf0)
//#define EL_BackGroundColor RGB(236,237,239)//注：效果图两个背景颜色，选“消息中心”的那个。
#define EL_ViewBgColor         [UIColor blackColor]
#define EL_TextColor_Dark      UIColorFromRGB(0x021a27)
#define EL_TextColor_Light     UIColorFromRGB(0x999999)

#define EL_Color_Line           RGB(200, 200, 200)

#define EL_Color_Random        (arc4random() % 256)
#define EL_RandomColor         RGB(EL_Color_Random,EL_Color_Random,EL_Color_Random)

#define DDLog(xx, ...)                      NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define WS(__wsSelf__) __weak __typeof(&*self)__wsSelf__ = self

/****UI常量***/
#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT               ([UIScreen mainScreen].bounds.size.height)
#define kRadioX                     ((SCREEN_WIDTH <= 375 ? 320 : SCREEN_WIDTH)/320)
#define kRadioXValue(__xx__)        (kRadioX*(__xx__))

#define kRadio                      (SCREEN_WIDTH/320)
#define kRadioValue(__xx__)         (kRadio*(__xx__))

#define NAV_BAR_HEIGHT              44
#define TAB_BAR_HEIGHT              49
#define CONTENT_HEIGHT              (SCREEN_HEIGHT - NAV_BAR_HEIGHT)
#define kCUREENT_WINDOW [[UIApplication sharedApplication] keyWindow]
#define kAppDelegate  (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define kWindow       [UIApplication sharedApplication].keyWindow

#define kFont_System(__xx__) [UIFont systemFontOfSize:__xx__]
#define kFont_Bold(__xx__) [UIFont boldSystemFontOfSize:__xx__]

//
#define is_ios7  ([[[UIDevice currentDevice]systemVersion]floatValue]>=7)
#define is_ios8  ([[[UIDevice currentDevice]systemVersion]floatValue]>=8)

// Notification

#define ELNotification_alipayResult @"ELNotification_alipayResult"