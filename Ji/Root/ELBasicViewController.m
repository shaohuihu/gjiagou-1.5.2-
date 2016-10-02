//
//  ELBasicViewController.m
//  WaiDian
//
//  Created by evol on 16/4/28.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELBasicViewController.h"
#import "ELNavigationController.h"
#import "ELMessageCenterController.h"

@interface ELBasicViewController ()


@end

@implementation ELBasicViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self o_load];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *label = [[UILabel alloc] init];
    label.font = kFont_System(17);
    label.textColor = EL_TextColor_Dark;
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = EL_BackGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];

    
    [self o_viewLoad];
    [self o_configDatas];
    [self o_configViews];
    [self o_loadDatas];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self o_viewAppear];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self o_layoutViews];
}


#pragma mark - Sub Implement
- (void)o_load{}
- (void)o_viewLoad{}
- (void)o_viewAppear{}
- (void)o_configDatas{}
- (void)o_loadDatas{}
- (void)o_configViews{}
- (void)o_layoutViews{}

- (void)o_onNotiTap{
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    ELMessageCenterController *vc = [ELMessageCenterController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - NaviSet

- (void)el_setLeftNaviTitle:(NSString *)title{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(el_onLeftNavBarTap)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)el_setLeftNaviImage:(UIImage *)image{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(el_onLeftNavBarTap)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)el_setRightNavTitle:(NSString *)title{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(el_onRightNavBarTap)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)el_setRightNavImage:(UIImage *)image{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(el_onRightNavBarTap)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)el_onLeftNavBarTap{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)el_onRightNavBarTap{};


#pragma mark - show&hide tabbar
- (void)el_showTarBar:(BOOL)show
{
    UIView *contentView;
    for (UIView *subView in self.tabBarController.view.subviews) {
        if ([subView isKindOfClass:[UITabBar class]]) {
            contentView = subView;
            break;
        }
    }
    contentView.hidden = !show;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




-(void)showCustomHudSingleLine:(NSString *)text
{
    if (text==nil||text.length==0) {
        return;
    }
    
    UIView *customHud = [[UIView alloc] init];
    customHud.tag = 888;
    
    customHud.frame = CGRectMake((SCREEN_WIDTH - 80)/2, 120, (SCREEN_WIDTH - 80), (SCREEN_WIDTH - 80)/3);
    customHud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    customHud.layer.masksToBounds = YES;
    customHud.layer.cornerRadius = 5;
    customHud.backgroundColor = [UIColor blackColor];
    customHud.alpha = 0;
    
    UILabel *contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, customHud.bounds.size.width, customHud.bounds.size.height)];
    contenLabel.textColor = [UIColor whiteColor];
    contenLabel.textAlignment = NSTextAlignmentCenter;
    contenLabel.font = [UIFont systemFontOfSize:14];
    contenLabel.text = text;
    contenLabel.numberOfLines = 0;
    contenLabel.textAlignment = NSTextAlignmentCenter;
    
    [customHud addSubview:contenLabel];
    
    [[[UIApplication sharedApplication].delegate window] addSubview:customHud];
    
    
    
    [UIView animateWithDuration:0.3f animations:^{
        customHud.alpha = 0.6;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2.5f animations:^{
            customHud.alpha = 0;
        } completion:^(BOOL finished) {
            customHud.hidden = YES;
            [customHud removeFromSuperview];
        }];
        
    }];
    
}
-(void)hideCustomHud
{
    UIView *view = [[[UIApplication sharedApplication].delegate window] viewWithTag:888];
    [UIView animateWithDuration:0.3f animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        view.hidden = YES;
        [view removeFromSuperview];
    }];
}


#pragma mark - Response

- (void)onBgViewTap{
    [self.bgGrayView removeFromSuperview];
    [self.navigationItem.titleView endEditing:YES];
}
#pragma mark - Getters 

- (UIBarButtonItem *)notiItem{
    if (_notiItem == nil) {
        UIImage *image  = [[UIImage imageNamed:@"ic_notice_dot"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _notiItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(o_onNotiTap)];
    }
    return _notiItem;
}


- (ELSearchTextField *)searchBar{
    if (_searchBar == nil) {
        WS(ws);
        _searchBar                     = [[ELSearchTextField alloc] initWithFrame:CGRectMake(0, 0, kRadioValue(210), 30)];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.layer.cornerRadius  = 6;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.borderColor   = EL_TextColor_Light.CGColor;
        _searchBar.layer.borderWidth   = 0.5;
        _searchBar.returnKeyType       = UIReturnKeySearch;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, _searchBar.el_height)];
        _searchBar.leftView = leftView;
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_searchBar setCompletion:^(NSString *text) {
            [ws p_searchDidTap:text];
        }];
        
        [_searchBar setTextDidChange:^(NSString *text) {
            [ws o_searchFieldDidChange:text];
        }];
        
        [_searchBar setBeginEditing:^{
            [ws.view addSubview:ws.bgGrayView];
        }];
    }
    return _searchBar;
}


- (UIView *)bgGrayView {
    if (_bgGrayView == nil) {
        _bgGrayView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgGrayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [_bgGrayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBgViewTap)]];
    }
    return _bgGrayView;
}


- (UIBarButtonItem *)messageItem{
    if (_notiItem == nil) {
        UIImage *image  = [[UIImage imageNamed:@"ic_notice_dot"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _notiItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(o_onNotiTap)];
    }
    return _notiItem;
}
#pragma mark - Search

- (void)p_searchDidTap:(NSString *)text{
    [self.bgGrayView removeFromSuperview];
    self.searchText = text;
    [self o_searchDidTap];
}
- (void)o_searchDidTap{
    
}

- (void)o_searchFieldDidChange:(NSString *)text{
    self.searchText = text;
}
@end
