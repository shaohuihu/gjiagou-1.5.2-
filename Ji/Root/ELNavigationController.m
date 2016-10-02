//
//  ELNavigationController.m
//  Wai
//
//  Created by evol on 16/4/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELNavigationController.h"

@interface ELNavigationController ()

@end

@implementation ELNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:imageWithColor(BQ_NaviColor, 1.f, 1.f) forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:EL_TextColor_Dark, NSForegroundColorAttributeName,  nil]];
    [[UINavigationBar appearance] setTintColor:EL_TextColor_Dark];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
