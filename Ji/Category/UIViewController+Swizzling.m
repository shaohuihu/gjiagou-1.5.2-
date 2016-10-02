//
//  UIViewController+Swizzling.m
//  NIM
//
//  Created by chris on 15/6/15.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "SwizzlingDefine.h"

@implementation UIViewController (Swizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillAppear:), @selector(swizzling_viewWillAppear:));
//        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidAppear:), @selector(swizzling_viewDidAppear:));
//        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillDisappear:), @selector(swizzling_viewWillDisappear:));
//        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidLoad),    @selector(swizzling_viewDidLoad));
//        swizzling_exchangeMethod([UIViewController class], @selector(initWithNibName:bundle:), @selector(swizzling_initWithNibName:bundle:));
    });
}

//#pragma mark - InitWithNibName:bundle:
////如果希望vchidesBottomBarWhenPushed为NO的话，请在vc init方法之后调用vc.hidesBottomBarWhenPushed = NO;
//- (instancetype)swizzling_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    id instance = [self swizzling_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (instance) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    return instance;
//}

#pragma mark - ViewDidLoad
//- (void)swizzling_viewDidLoad{
//    if (self.navigationController) {
//        UIImage *buttonNormal = [[UIImage imageNamed:@"icon_back_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [self.navigationController.navigationBar setBackIndicatorImage:buttonNormal];
//        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:buttonNormal];
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//        self.navigationItem.backBarButtonItem = backItem;
//    }
//    [self swizzling_viewDidLoad];
//}

#pragma mark - ViewWillAppear

- (void)swizzling_viewWillAppear:(BOOL)animated{
    [self swizzling_viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}
//
//#pragma mark - ViewWillDisappear
//
//- (void)swizzling_viewWillDisappear:(BOOL)animated{
//    [self swizzling_viewWillDisappear:animated];
//}
//
//
//#pragma mark - ViewDidAppear
//- (void)swizzling_viewDidAppear:(BOOL)animated{
//    [self swizzling_viewDidAppear:animated];
//    UIView *view = objc_getAssociatedObject(self, &UIFirstResponderViewAddress);
//    [view becomeFirstResponder];
//}
//

@end
