//
//  AppDelegate.m
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//
//

#import "AppDelegate.h"
#import "ELTabBarController.h"
#import "DBUserCenter.h"
#import "DBGoodsAddressViewController.h"
#import "ELGuideController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiManager.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/ASIdentifierManager.h>
//友盟统计
#import "UMMobClick/MobClick.h"
#import "ELMainService.h"
//显示活动规则
#import "RuleViewController.h"
//友盟分享
#import "UMSocial.h"
//微信分享
#import "UMSocialWechatHandler.h"
//QQ分享
#import "UMSocialQQHandler.h"
//分享到易信
#import "UMSocialYixinHandler.h"
//分享新浪微博
#import "UMSocialSinaSSOHandler.h"
//支付宝分享
#import "UMSocialAlipayShareHandler.h"

@interface AppDelegate ()<UITabBarControllerDelegate>{
    UIView * corverV;
    UIView *  active;
    NSMutableArray * pusharray;
    int i;
    int tem;
    NSString * duan;
    NSString * iosShow;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#pragma mark-我新添加的友盟分享
     [UMSocialData setAppKey:@"57a5391d67e58ed7db001b6e"];
    
#pragma mark-由于苹果审核要求将以下平台如果没有安装就不显示
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    
   //设置微信分享
//    [UMSocialWechatHandler setWXAppId:@"wxa6ab495a751f05eb" appSecret:@"192cd62bab407721b6278422afa31be6" url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:@"wxa6ab495a751f05eb" appSecret:@"192cd62bab407721b6278422afa31be6" url:nil];

    
//       [UMSocialWechatHandler setWXAppId:@"wxa6ab495a751f05eb" appSecret:@"192cd62bab407721b6278422afa31be6" url:@"http://www.gjiagou.com"];
    
   //添加QQ分享
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
        [UMSocialQQHandler setQQWithAppId:@"1105423055" appKey:@"9XYAMRuwl1ElmHEy" url:@"http://www.umeng.com/social"];

    
    //添加易信
    [UMSocialYixinHandler setYixinAppKey:@"yxc0614e80c9304c11b0391514d09f13bf" url:@"http://www.umeng.com/social"];
//    [UMSocialYixinHandler setYixinAppKey:@"yx35664bdff4db42c2b7be1e29390c1a06" url:@"http://www.umeng.com/social"];
    
    
    //注册新浪微博
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2697702315"
                                              secret:@"3d2023783816304bb480c1c7e5fa48b7"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

  
 
    
    
    
  //支付宝分享
    // 设置支付宝分享的appId
   // [UMSocialAlipayShareHandler setAlipayShareAppId:@"2088221196500534"];
    
    
    
#pragma mark-这是以前的
   // AppDelegate
    //向微信注册
   [WXApi registerApp:@"wxa6ab495a751f05eb" withDescription:@"minkey"];
    
    
    //通过sharedApplication获取改程序的UIApplication对象，并且设置状态栏的样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BOOL initial = [[NSUserDefaults standardUserDefaults] boolForKey:@"initial"];
 
    //在这里判断应用程序是不是第一次启动，如果是第一次启动就将initial置为YES，selectCityName,置为任城区，selectCityId,置为370811
    if (initial == NO) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"initial"];
        [[NSUserDefaults standardUserDefaults] setObject:@"任城区" forKey:@"selectCityName"];
        [[NSUserDefaults standardUserDefaults] setObject:@"370811" forKey:@"selectCityId"];
        [[NSUserDefaults standardUserDefaults] synchronize];//将数据直接同步到文件里
        self.window.rootViewController = [ELGuideController new];//设置ELGuideController 为这个程序第一次启动时候的视图
    }else{
        [self showMainController];
    }
    //判断实例是不是有以某个名字命名的方法（被封装在一个selector的对象传递）
    if ([UINavigationBar instancesRespondToSelector:@selector(setBackIndicatorImage:)]) {
        //设置导航栏的背景图片
        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"ic_back_button"]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"ic_back_button"]];
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
#pragma mark-这里面是极光推送的东西

    NSString * adbertisingId=[[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    //Required
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
//    
//    [JPUSHService setupWithOption:launchOptions appKey:@"3ac43a07dc85b3e3ffe88666"
//                          channel:nil
//                 apsForProduction:nil
//            advertisingIdentifier:adbertisingId];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"ce2e717355e942c38cf8cab1"
channel:nil
apsForProduction:nil
advertisingIdentifier:adbertisingId];
    /***************这里面有需要设置的清0的操作*************************/
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
 //友盟统计
    UMConfigInstance.appKey=@"57a5391d67e58ed7db001b6e";
    UMConfigInstance.channelId=@"App Store";
    
    [MobClick startWithConfigure:UMConfigInstance];
    
    [MobClick setLogEnabled:YES];
    
    
        return YES;
    
}

/*************************极光推送的******************************/

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    // Required,For systems with less than or equal to iOS6
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService handleRemoteNotification:userInfo];
    [JPUSHService resetBadge];
}
//我在这里面添加了清0的操作
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}






/*
 *  这个方法是用来判断这个在用户点击购物车和我的这两个的时候，有没有登录，如果已经登录了就不用再管了，如果没有登录就直接跳转到登录页面登录
 */

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController.tabBarItem.title isEqualToString:@"购物车"] ||[viewController.tabBarItem.title isEqualToString:@"我的"] ) {
        //如果用户ID存在的话，说明已登陆
        if (Uid) {
            return YES;
        }
        else
        {
            //登录界面
            ELLoginViewController *loginVC = [[ELLoginViewController alloc]init];
            ELNavigationController *nav = [[ELNavigationController alloc] initWithRootViewController:loginVC];
            [((UINavigationController *)tabBarController.selectedViewController) presentViewController:nav animated:YES completion:nil];
            return NO;
        }
    }
    else
        return YES;

}
//这个方法是在这个程序不是第一次运行的时候走这个方法（此时主页面为ELTabBarController）
- (void)showMainController{
    /**********************这里面有我改动的地方通过屏幕适配确定视图的坐标*************************/
    CGFloat margin = 25;
    CGFloat topMargin = 15;
    CGFloat buttonWidth = kRadioXValue(41);
    CGFloat itemHeight = buttonWidth + kRadioValue(35);
    CGFloat space  = (SCREEN_WIDTH - 2*margin - 4*buttonWidth)/3;

    
    
    ELTabBarController *tabbar = [[ELTabBarController alloc] init];
    self.window.rootViewController = tabbar;
    tabbar.delegate = self;
    /************************在这里设置了主页面的那个黑色的背景*******************/
    corverV=[[UIView alloc]init];
    corverV.backgroundColor=[UIColor colorWithRed:38/255.0 green:38/255.0 blue:39/255.0 alpha:0.9];
    corverV.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    // [self.view addSubview:corverV];
    
    /**********************这个是设置的最下面的”知道了“那个button******************/
    UIButton*    button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"知道了" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    /*
     *  对按钮的坐标进行屏幕适配，设置按钮的坐标是 x=屏幕的宽度/2-按钮的宽度/2
     y=屏幕的高度-按钮的高度（40）-按钮下方所留下的空格为60
     width=160
     height=40
     */
    
    button.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-80, [UIScreen mainScreen].bounds.size.height-100, 160, 40);
    //[button setBackgroundImage:[UIImage imageNamed:@"ic_text_butn"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(doView) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    //[self.view addSubview:button];
    [corverV addSubview:button];
    
    
    //这个temv是用来盛放按钮的一个视图
    /*
     *  对按钮的坐标进行屏幕适配，设置按钮的坐标是 x=屏幕的宽度/2-按钮的宽度/2
     y=屏幕的高度-按钮的高度（40）-按钮下方所留下的空格为60
     width=160
     height=42
     */
    UIImageView *   temV=[[UIImageView alloc]init];
    temV.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-80, [UIScreen mainScreen].bounds.size.height-100, 160, 42);
    [temV setImage:[UIImage imageNamed:@"ic_text_butn"]];
    //[self.view addSubview:temV];
    [corverV addSubview:temV];
    //这个view是上面用来“免费抽奖”
    UIImageView*   topIV=[[UIImageView alloc]init];
    //在这里对于topIV的坐标进行一次改动
    //topIV.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-260, 100, 200, 200);
    //topIV.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-260, [UIScreen mainScreen].bounds.size.width/5+30, 200, 200);
   
    //这里有改变的东西，原来为260，240
    CGFloat topIVWith=0.81*self.window.bounds.size.width ;
    CGFloat topIVheight=0.42*self.window.bounds.size.height;
    
    
    [topIV setImage:[UIImage imageNamed:@"ic_text_zezhao"]];
    //[self.view addSubview:topIV];
    [corverV addSubview:topIV];
     //这里对于topIV做一次屏幕适配
    
    [topIV makeConstraints:^(MASConstraintMaker *make) {
        
        
        
        // make.top.equalTo(6/4*itemHeight + topMargin);
        if (self.window.bounds.size.height==480 ) {
            make.top.equalTo(6/4*itemHeight + topMargin+135+64-topIVheight+12);
            make.left.equalTo(margin+(6%4*(buttonWidth +space))-buttonWidth-110);
        }
        else if (self.window.bounds.size.height==568){
            make.top.equalTo(6/4*itemHeight + topMargin+135+64-topIVheight+20);
             make.left.equalTo(margin+(6%4*(buttonWidth +space))-buttonWidth-110);
        }
        else if (self.window.bounds.size.height==667){
            make.top.equalTo(6/4*itemHeight + topMargin+158.203125+64-topIVheight+20);
            make.left.equalTo(margin+(6%4*(buttonWidth +space))-3*buttonWidth-space);
        }
        else{
            make.top.equalTo(6/4*itemHeight + topMargin+174.06625+64-topIVheight+25);
            make.left.equalTo(margin+(6%4*(buttonWidth +space))-buttonWidth-145);
        }
        
        make.size.equalTo(CGSizeMake(topIVWith, topIVheight));
    }];
    

    
    
    //现在要设计需要显示出来的那个济佳购
    UIImageView*   jiImage=[[UIImageView alloc]init];
    //在这里要对需要jiImage的坐标做一次改动
    
    //jiImage.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-160)/2+100, 290, ([UIScreen mainScreen].bounds.size.width-160)/4, 40);
    
   // jiImage.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-160)/2+100, [UIScreen mainScreen].bounds.size.height/5+175, ([UIScreen mainScreen].bounds.size.width-160)/4, 40);
    
    [jiImage setImage:[UIImage imageNamed:@"main_index_6"]];
    
    
    
    [corverV addSubview:jiImage];
    /*****************************这里有我需要改动的地方**********************************/
    [jiImage makeConstraints:^(MASConstraintMaker *make) {
        //让这个按钮的坐标和
       
        make.left.equalTo(margin+(6%4*(buttonWidth +space)));
       // make.top.equalTo(6/4*itemHeight + topMargin);
        if (self.window.bounds.size.height==480 ) {
            make.top.equalTo(6/4*itemHeight + topMargin+135+64);
        }
        else if (self.window.bounds.size.height==568){
            make.top.equalTo(6/4*itemHeight + topMargin+135+64);
        }
        else if (self.window.bounds.size.height==667){
            make.top.equalTo(6/4*itemHeight + topMargin+158.203125+64);
        }
        else{
            make.top.equalTo(6/4*itemHeight + topMargin+174.06625+64);
 
        }
        
        make.size.equalTo(CGSizeMake(buttonWidth, buttonWidth));
    }];
    
    //添加我们需要显示出来的“济佳购”这三个字
    UILabel * titleL=[[UILabel alloc]init];
    
    //titleL.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-160)/2+78, 330, ([UIScreen mainScreen].bounds.size.width-280)/4+80, 40);
    //在这里要对titleL的坐标要进行一次的改动
//    titleL.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-160)/2+78, [UIScreen mainScreen].bounds.size.height/5+215, ([UIScreen mainScreen].bounds.size.width-280)/4+80, 40);
//    
    
    
    titleL.text=@"0元购";
    //titleL.textAlignment=UITextAlignmentCenter;
    //在iOS6.0之后这个方法UITextAlignmentCenter被改成NSTextAlignmentCenter
    titleL.textAlignment=NSTextAlignmentCenter;
    titleL.textColor=[UIColor whiteColor];
    titleL.font = kFont_System(15.f);
    [corverV addSubview:titleL];
    
    [titleL makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiImage.bottom).offset(10);
        make.centerX.equalTo(jiImage);
    }];

    
    [self.window addSubview:corverV];
    
#pragma 添加了活动弹层页面
    
    //把tem从沙盒中取出
    NSUserDefaults *getdataNSU=[NSUserDefaults standardUserDefaults];
    NSString * oldSS=[getdataNSU objectForKey:@"data7"];
    int tINT=[oldSS intValue];
    i=tINT;
    i+=1;
    tem=i;
    //把tem存到沙盒里
    NSString * temS=[NSString stringWithFormat:@"%d",tem];
    NSUserDefaults * dataNSU=[NSUserDefaults standardUserDefaults];
    [dataNSU setObject:temS forKey:@"data7"];
    DDLog(@"我的数据%d",i);
    DDLog(@"需要的数据%d",tem);
    
    //获取到启动的时间
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMdd "];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSString * compareS=[NSString stringWithString:locationString];
    DDLog(@"用来比较的字符串%@",compareS);
    
    //把这个时间存到沙盒里面
    if (tem==1) {
        NSUserDefaults * pushNSU=[NSUserDefaults standardUserDefaults];
        [pushNSU setObject:locationString forKey:@"dataTime3"];
        
    }
    
    
    
    
    //取出沙盒里面的数据
    NSUserDefaults *getNSU=[NSUserDefaults standardUserDefaults];
    NSString * oldS=[getNSU objectForKey:@"dataTime3"];
    DDLog(@"从沙盒里获取的数据%@",oldS);
    DDLog(@"用来判断%d",tem);
    //将先前的数据和这个数据进行判断
    
    
    
#pragma mark-添加活动弹层
    
    NSUserDefaults *jud=[NSUserDefaults standardUserDefaults];
    NSString * juds=[jud objectForKey:@"judgeS"];
    DDLog(@"这个是用来做一个简单的判断%@",juds);
    
    
    //在这里面调用一个活动弹层的方法
    [ELMainService getThicknessWithBlock:^(BOOL success, id result) {
        if (success) {
            NSDictionary * temDic=[NSDictionary dictionary];
            temDic=result[@"data"];
            //这个是显示的规则
            DDLog(@"这个是我的%@",temDic);
            
            
            
            
#pragma 从接口获取完数据之后进行判断
            if (![temDic isEqual:[NSNull null]]) {
                
                if ([juds  isEqualToString:@"1"]) {
                    NSString * ruleS=[temDic objectForKey:@"rule"];
                    NSInteger  ruleI=[ruleS integerValue];
                    DDLog(@"规则%@",ruleS);
                    
                    NSString * imageName=[temDic objectForKey:@"image"];
                    //            [imageView sd_setImageWithURL:ELIMAGEURL(string2)];
                    
                    DDLog(@"图片%@",imageName);
                    DDLog(@"图片网址%@",ELIMAGEURL(imageName));
                    
                    NSUserDefaults *getNSU=[NSUserDefaults standardUserDefaults];
                    NSString * getiosShow=[getNSU objectForKey:@"showiOS"];
                    NSInteger iosShow=[getiosShow integerValue];
                   // DDLog(@"获取到iosShow%ld",(long)iosShow);
                    
                    NSUserDefaults *iosNUS=[NSUserDefaults standardUserDefaults];
                    NSString *iosNU=[iosNUS objectForKey:@"baochun1"];
                    NSInteger iosNI=[iosNU integerValue];
                    DDLog(@"这个是我的%ld",(long)iosNI);
                    
                    
                    if (ruleI==0 && ![compareS isEqualToString:oldS]) {
                        active= [[UIView alloc]init];
                        active.backgroundColor=[UIColor colorWithRed:38/255.0 green:38/255.0 blue:39/255.0 alpha:0.9];
                        active.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                        //添加右上角的取消按钮
                        UIButton * topBTN=[UIButton buttonWithType:UIButtonTypeCustom];
                        [topBTN setBackgroundImage:[UIImage imageNamed:@"ic_index_active_close"] forState:UIControlStateNormal];
                        [topBTN addTarget:self action:@selector(doDisappear) forControlEvents:UIControlEventTouchUpInside];
                        [active addSubview:topBTN];
                        //屏幕适配
                        [topBTN makeConstraints:^(MASConstraintMaker *make){
                            make.top.equalTo(30);
                            make.right.equalTo(-15);
                            make.width.equalTo(29);
                            make.height.equalTo(28);
                            
                        }];

                        
                        
                        
                        //设置视图中间的图片
                        UIImageView * ImageV=[[UIImageView alloc]init];
                    
                        [ImageV sd_setImageWithURL:ELIMAGEURL(imageName)];
                        [active addSubview:ImageV];
                        
                        //屏幕适配
                        [ImageV makeConstraints:^(MASConstraintMaker *make){
                            make.top.equalTo(100);
                            make.left.equalTo(30);
                            make.width.equalTo([UIScreen mainScreen].bounds.size.width-60);
                            make.height.equalTo([UIScreen mainScreen].bounds.size.height-50-40-40-100);
                            
                            
                            
                        }];
                        
                        //设置最下边的查看规则按钮
                        UIButton * ruleBTN=[UIButton buttonWithType:UIButtonTypeCustom];
                      
                        [ruleBTN setTitle:@"查看规则" forState:UIControlStateNormal];
                        [ruleBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        ruleBTN.titleLabel.textAlignment=NSTextAlignmentCenter;
                        [ruleBTN addTarget:self action:@selector(doshowRule) forControlEvents:UIControlEventTouchUpInside];
                        
                        ruleBTN.backgroundColor=[UIColor redColor];
                        [active addSubview:ruleBTN];
                        
                        [ruleBTN makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo([UIScreen mainScreen].bounds.size.width/2-70);
                            make.bottom.equalTo(-50);
                            make.width.equalTo(140);
                            make.height.equalTo(40);
                        }];
                        [self.window addSubview:active];

                        
#pragma mark 显示完从新把数据保存进去
                        NSInteger compareNSI=[compareS integerValue];
                        
                        NSInteger oldNSI=[oldS integerValue];
                        oldNSI=compareNSI;
                        // NSString * newS=[NSString stringWithFormat:@"oldNSI"];
                        NSString * newS=[NSString stringWithFormat:@"%ld",(long)oldNSI];
                        DDLog(@"第二次后去数据%@",compareS);
                        NSUserDefaults * pushNSU=[NSUserDefaults standardUserDefaults];
                        [pushNSU setObject:compareS forKey:@"dataTime3"];
                        
                        
                        
                        
                    }
                    
                    //当rules==0是为每天第一次打开，需要进行两个判断
                    else if (ruleI==1){
                        
                        active= [[UIView alloc]init];
                        active.backgroundColor=[UIColor colorWithRed:38/255.0 green:38/255.0 blue:39/255.0 alpha:0.9];
                        active.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                        //添加右上角的取消按钮
                        UIButton * topBTN=[UIButton buttonWithType:UIButtonTypeCustom];
                        [topBTN setBackgroundImage:[UIImage imageNamed:@"ic_index_active_close"] forState:UIControlStateNormal];
                        [topBTN addTarget:self action:@selector(doDisappear) forControlEvents:UIControlEventTouchUpInside];
                  
                        
                        
                        [active addSubview:topBTN];
                        
                        [topBTN makeConstraints:^(MASConstraintMaker *make){
                            make.top.equalTo(30);
                            make.right.equalTo(-15);
                            make.width.equalTo(29);
                            make.height.equalTo(28);
                            
                        }];
                        
                        
                        //设置视图中间的图片
                        UIImageView * ImageV=[[UIImageView alloc]init];
                       // ImageV.frame=CGRectMake(30, 100, 260, 340);
                        [ImageV sd_setImageWithURL:ELIMAGEURL(imageName)];
                        [active addSubview:ImageV];
                        
                        [ImageV makeConstraints:^(MASConstraintMaker *make){
                            make.top.equalTo(100);
                            make.left.equalTo(30);
                            make.width.equalTo([UIScreen mainScreen].bounds.size.width-60);
                            make.height.equalTo([UIScreen mainScreen].bounds.size.height-50-40-40-100);
                      
                            
                            
                        }];
                        
                        
                        //设置最下边的查看规则按钮
                        UIButton * ruleBTN=[UIButton buttonWithType:UIButtonTypeCustom];
                      //ruleBTN.frame=CGRectMake(100, 500, 140, 40);
                        [ruleBTN setTitle:@"查看规则" forState:UIControlStateNormal];
                        [ruleBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        ruleBTN.titleLabel.textAlignment=NSTextAlignmentCenter;
                        [ruleBTN addTarget:self action:@selector(doshowRule) forControlEvents:UIControlEventTouchUpInside];
                        ruleBTN.backgroundColor=[UIColor redColor];
                        [active addSubview:ruleBTN];
                        
                        [ruleBTN makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo([UIScreen mainScreen].bounds.size.width/2-70);
                        make.bottom.equalTo(-50);
                        make.width.equalTo(140);
                        make.height.equalTo(40);
                        }];

                        [self.window addSubview:active];
                        
                        
                    }
                    //判断新用户打开显示
                    
                    
                    
                    else if (ruleI==2 && iosNI==0 ){
                        
                        
                        active= [[UIView alloc]init];
                        active.backgroundColor=[UIColor colorWithRed:38/255.0 green:38/255.0 blue:39/255.0 alpha:0.9];
                        active.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                        //添加右上角的取消按钮
                        UIButton * topBTN=[UIButton buttonWithType:UIButtonTypeCustom];
                        [topBTN setBackgroundImage:[UIImage imageNamed:@"ic_index_active_close"] forState:UIControlStateNormal];
                        [topBTN addTarget:self action:@selector(doDisappear) forControlEvents:UIControlEventTouchUpInside];
                       // topBTN.frame=CGRectMake(270, 30, 30, 30);
                        
                        
                        [active addSubview:topBTN];
                        [topBTN makeConstraints:^(MASConstraintMaker *make){
                            make.top.equalTo(30);
                            make.right.equalTo(-15);
                            make.width.equalTo(29);
                            make.height.equalTo(28);
                            
                        }];
                        
                        //设置视图中间的图片
                        UIImageView * ImageV=[[UIImageView alloc]init];
                     
                        [ImageV sd_setImageWithURL:ELIMAGEURL(imageName)];
                        [active addSubview:ImageV];
                        
                        [ImageV makeConstraints:^(MASConstraintMaker *make){
                            make.top.equalTo(100);
                            make.left.equalTo(30);
                            make.width.equalTo([UIScreen mainScreen].bounds.size.width-60);
                            make.height.equalTo([UIScreen mainScreen].bounds.size.height-50-40-40-100);
                            
                            
                            
                        }];
                        

                        
                        
                        
                        //设置最下边的查看规则按钮
                        UIButton * ruleBTN=[UIButton buttonWithType:UIButtonTypeCustom];
                       
                        [ruleBTN setTitle:@"查看规则" forState:UIControlStateNormal];
                        [ruleBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        ruleBTN.titleLabel.textAlignment=NSTextAlignmentCenter;
                        [ruleBTN addTarget:self action:@selector(doshowRule) forControlEvents:UIControlEventTouchUpInside];
                        
                        ruleBTN.backgroundColor=[UIColor redColor];
                        [active addSubview:ruleBTN];
                        [ruleBTN makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo([UIScreen mainScreen].bounds.size.width/2-70);
                            make.bottom.equalTo(-50);
                            make.width.equalTo(140);
                            make.height.equalTo(40);
                        }];
                        [self.window addSubview:active];
                        
                        
                        [ELMainService ChangenumberWithUID:Uid iosShow:@"1" block:^(BOOL success, id result) {
                            if (success) {
                                NSString * temiOS=[result objectForKey:@"iosShow"];
                                NSUserDefaults * pushNSU=[NSUserDefaults standardUserDefaults];
                                [pushNSU setObject:temiOS forKey:@"baochun1"];
                                
                                
                                
                            }else{
                                
                                
                            }
                        }];
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
                
                
            }
            
            
            
            
            
        }
    }];

    
    
    
}
-(void)doView {
    corverV.hidden=YES;
    duan=@"1";
    NSUserDefaults * pushNSU=[NSUserDefaults standardUserDefaults];
    [pushNSU setObject:duan forKey:@"judgeS"];
    
}
/*
 * 取消掉活动弹框
 */
-(void)doDisappear{
    active.hidden=YES;
}
/*
 * 进入活动规则页面
 */
-(void)doshowRule{
    RuleViewController *ruleVC = [[RuleViewController alloc]init];
    ELNavigationController *nav = [[ELNavigationController alloc] initWithRootViewController:ruleVC];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    
    
    active.hidden=YES;
    
    
}


//跳转到登录页面
- (void)presentLoginView{
    ELLoginViewController *loginVC = [[ELLoginViewController alloc]init];
    ELNavigationController *nav = [[ELNavigationController alloc] initWithRootViewController:loginVC];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    /****************在这里讲调用支付宝的方法给他隐藏换成微信支付的*****************/

    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
    else{
    //微信回调
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    //return YES;
    //url.host
    DDLog(@"0000>>>%@",url.host);
    }
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    DDLog(@"打印我的%@",url.host);
        if ([url.host isEqualToString:@"pay"]) {
            return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];

    }
        else{
            
            DDLog(@"打印一次%@",url.host);
            BOOL result = [UMSocialSnsService handleOpenURL:url];
            if (result == FALSE) {
                //调用其他SDK，例如支付宝SDK等
            }
            return result;
            
            
        }
    
    
    //return YES;
   
}




// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options

{
    
    /*************************在这里将支付宝的代码隐藏************************/
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString *status = resultDic[@"resultStatus"];
            DDLog(@"status:%@",status);
            //这个是status是不是[NSString class]的实例并且status=9000;
            if ([status isKindOfClass:[NSString class]] && [status isEqualToString:@"9000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:ELNotification_alipayResult object:@(YES)];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:ELNotification_alipayResult object:@(NO)];
            }
        }];
        return YES;
    }
//    else{
//    //微信支付的代码
//    return [WXApi handleOpenURL:url delegate:self];
//    
//    //return YES;
//    }
  //改变了原来的返回的方式
    else if ([url.host isEqualToString:@"pay"]){
         return [WXApi handleOpenURL:url delegate:self];
    }
    else{
        DDLog(@"打印一次%@",url.host);
        BOOL result = [UMSocialSnsService handleOpenURL:url];
        if (result == FALSE) {
            //调用其他SDK，例如支付宝SDK等
        }
        return result;
    }
    
}

#pragma mark-WXApiDelegate 微信支付方式的代码
-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果，实际支付结果需要去微信服务器查询
        NSString * strMsg,*strTitle=[NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
                strMsg=@"支付结果：成功!";
                NSLog(@"支付成功-PaySuccess,retcode=%d",resp.errCode);
                break;
                
            default:
                strMsg=[NSString stringWithFormat:@"支付结果：失败！retcode=%d,retstr=%@",resp.errCode,resp.errStr];
                //如果出现错误，错误码：resp.errocode 错误原因：resp.errCode
                NSLog(@"错误，retcode=%d,retstr=%@",resp.errCode,resp.errStr);
                
                
                
                
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

/*****************************处理角标清0的问题*************************************/
/*
-(void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(nonnull NSDictionary *)userInfo completionHandler:(nonnull void (^)())completionHandler{
    
   // [JPUSHService resetBadge];
   // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(nonnull UILocalNotification *)notification completionHandler:(nonnull void (^)())completionHandler{
    //[JPUSHService resetBadge];
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(nonnull UILocalNotification *)notification withResponseInfo:(nonnull NSDictionary *)responseInfo completionHandler:(nonnull void (^)())completionHandler{
    //[JPUSHService resetBadge];
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(nonnull NSDictionary *)userInfo withResponseInfo:(nonnull NSDictionary *)responseInfo completionHandler:(nonnull void (^)())completionHandler{
   // [JPUSHService resetBadge];
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
*/
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0){
//    [JPUSHService resetBadge];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    
//    
//}

//获得设备型号
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    DDLog(@"发送分享的结果%u",response.responseCode);
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"分享的平台是多少 %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

@end
