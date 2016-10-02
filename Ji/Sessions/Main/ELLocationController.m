//
//  ELLocationController.m
//  Ji
//
//  Created by evol on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import "ELMainService.h"
#import "AreaSelectView.h"
@interface ELLocationController ()<CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager* locationManager;

@end

@implementation ELLocationController
{
    AreaSelectView *_areaSelectV;
}

- (void)o_viewLoad{
    [self.navigationController.navigationBar setBackgroundImage:imageWithColor(EL_MainColor, 1, 1) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    self.title = @"选择城市";
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 8.0) {
        //使用期间
        [self.locationManager requestWhenInUseAuthorization];
        //始终
        //or [self.locationManage requestAlwaysAuthorization]
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.0f;
    [self.locationManager startUpdatingLocation];

    [self el_setLeftNaviImage:[UIImage imageNamed:@"nav_back"]];
}

- (void)o_configDatas{
    WS(ws);
    [ELMainService getAreasWithBlock:^(BOOL success, id result) {
        if (success) {
            NSArray *arr = result[@"data"][@"area"];
            NSArray *array = [AreaList mj_objectArrayWithKeyValuesArray:arr];
            [ws p_showLocation:array];
        }
    }];
}

- (void)el_onLeftNavBarTap{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillUnload{
    [super viewWillUnload];
    [_locationManager stopUpdatingLocation];
}

#pragma mark - Private

- (void)p_showLocation:(NSArray *)array{
    AreaList *listModel = array.firstObject;
    if (_areaSelectV) {
        [_areaSelectV removeFromSuperview];
    }
    _areaSelectV = [[AreaSelectView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- 64)];
    _areaSelectV.dataArr = listModel.areaList;
    [self.view addSubview:_areaSelectV];
    
    WS(ws);
    [_areaSelectV setSelectedCityBlock:^(AreaList * info) {
        [[NSUserDefaults standardUserDefaults] setObject:info.name forKey:@"selectCityName"];
        [[NSUserDefaults standardUserDefaults] setObject:info.id forKey:@"selectCityId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddressUpdate" object:nil];
        [ws dismissViewControllerAnimated:YES completion:nil];
    }];

}

#pragma mark - CLLocationManagerDelegate
//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [_locationManager stopUpdatingLocation];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *dict = [placemark addressDictionary];
            [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"State"] forKey:@"locationCityName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"无法获取位置信息");
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
