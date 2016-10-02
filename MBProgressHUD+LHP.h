//
//  MBProgressHUD+LHP.h
//  QQLogin
//
//  Created by LiHeping on 15/11/20.
//  Copyright (c) 2015年 LiHeping. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LHP)


+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;



@end
