//
//  UIView+Toast.h
//  Wai
//
//  Created by lwq on 16/5/10.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const NIMKitToastPositionTop;
extern NSString * const NIMKitToastPositionCenter;
extern NSString * const NIMKitToastPositionBottom;

@interface UIView (Toast)

// each makeToast method creates a view and displays it as toast
- (void)el_makeToast:(NSString *)message;
- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position;
- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position image:(UIImage *)image;
- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title;
- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title image:(UIImage *)image;

// displays toast with an activity spinner
- (void)el_makeToastActivity;
- (void)el_makeToastActivity:(id)position;
- (void)el_hideToastActivity;

// the showToast methods display any view as toast
- (void)el_showToast:(UIView *)toast;
- (void)el_showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point;
- (void)el_showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point
             tapCallback:(void(^)(void))tapCallback;

@end
