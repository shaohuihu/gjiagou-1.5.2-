//
//  ELTabBarController.m
//  Wai
//
//  Created by evol on 16/4/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELTabBarController.h"
#import "ELNavigationController.h"
#import "LSNavigationController.h"
#import "JPUSHService.h"
#import "ELMainService.h"

#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"


@interface ELTabBarController ()

@end

@implementation ELTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setUpSubNav];
        

}



#pragma mark - Private

- (NSArray *)p_tabbars {
    NSArray *item = @[
                      @{
                          TabbarVC           : @"ELMainController",
                          TabbarTitle        : @"济佳购",
                          TabbarImage        : @"ic_home",
                          TabbarSelectedImage: @"ic_home_active",
                          },
                      @{
                          TabbarVC           : @"ELCategoryController",
                          TabbarTitle        : @"分类",
                          TabbarImage        : @"ic_category",
                          TabbarSelectedImage: @"ic_category_active",
                          },
                      @{
                          TabbarVC           : @"ELShopController",
                          TabbarTitle        : @"购物车",
                          TabbarImage        : @"ic_shop",
                          TabbarSelectedImage: @"ic_shop_active",
                          },
                      @{
                          TabbarVC           : @"ELMineController",
                          TabbarTitle        : @"我的",
                          TabbarImage        : @"ic_user",
                          TabbarSelectedImage: @"ic_user_active",
                          },
                      ];
    
     
    return item;
}

- (void)p_setUpSubNav{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    [self.p_tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item         = obj;
        NSString * vcName           = item[TabbarVC];
        NSString * title            = item[TabbarTitle];
        NSString * imageName        = item[TabbarImage];
        NSString * imageSelected    = item[TabbarSelectedImage];
        Class clazz                 = NSClassFromString(vcName);
        UIViewController * vc       = [[clazz alloc] initWithNibName:nil bundle:nil];
        vc.title                    = title;
        UINavigationController *nav = nil;
        if (idx == 0 || idx == 3) {
            nav = [[LSNavigationController alloc] initWithRootViewController:vc];
        }else{
            nav = [[ELNavigationController alloc] initWithRootViewController:vc];
        }
        nav.tabBarItem              = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[UIImage imageNamed:imageName]
                                               selectedImage:[UIImage imageNamed:imageSelected]];
        nav.tabBarItem.tag          = idx;
        [array addObject:nav];
    }];
    self.tabBar.tintColor = EL_MainColor;
    self.viewControllers = array;
}

- (void)setBadgeValue:(NSInteger)value{
    
    UINavigationController *nav = self.viewControllers[2];
    if (value > 0) {
        nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)value];
        
    }else{
        nav.tabBarItem.badgeValue = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
