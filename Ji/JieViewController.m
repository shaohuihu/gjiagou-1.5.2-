//
//  JieViewController.m
//  Ji
//
//  Created by 龙讯科技 on 16/9/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "JieViewController.h"

@interface JieViewController ()

@end

@implementation JieViewController

- (void)viewDidLoad {
    
    
    
    UIWebView * webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSURLRequest * requst=[NSURLRequest requestWithURL:[NSURL URLWithString:_urlS]];
    [self.view  addSubview:webView];
    [webView loadRequest:requst];
   
    // Do any additional setup after loading the view from its nib.
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