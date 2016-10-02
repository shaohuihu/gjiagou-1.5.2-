//
//  ELUtil.m
//  WaiDian
//
//  Created by evol on 16/4/28.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELUtil.h"
#import "AppDelegate.h"
#import "NSDate+Helper.h"

@implementation ELUtil

void DMAlertNoTitle(NSString *message){
    DMAlert(nil,message);
}

void DMAlert(NSString *title ,NSString *message){
#ifdef __IPHONE_8_0
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [[(AppDelegate *)[UIApplication sharedApplication].delegate window].rootViewController presentViewController:alert animated:YES completion:nil];
#else
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"签到", nil];
    [alert show];
#endif
}



UIImage *imageWithColor(UIColor *color,CGFloat width,CGFloat height){
    
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UILabel *)createLabelFont:(CGFloat)font color:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.font = kFont_System(font);
    return label;
}

NSURL *ELIMAGEURL(NSString *imgStr){
    if (imgStr == nil || [imgStr isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return[NSURL URLWithString:[[HTTP_BASE_IMAGE_URL stringByAppendingString:imgStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}
@end
