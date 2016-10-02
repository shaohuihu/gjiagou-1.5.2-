//
//  ELBasicViewController.h
//  WaiDian
//
//  Created by evol on 16/4/28.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ELSearchTextField.h"
@interface ELBasicViewController : UIViewController<UISearchBarDelegate>


@property (nonatomic, strong) UIBarButtonItem *notiItem;
@property (nonatomic, strong) ELSearchTextField *searchBar;
@property (nonatomic, strong) UIView *bgGrayView;
@property (nonatomic, strong) NSString *searchText;


#pragma mark - Sub implemnt

- (void)o_load;
- (void)o_viewLoad;
- (void)o_viewAppear;
- (void)o_configDatas;
- (void)o_configViews;
- (void)o_loadDatas;
- (void)o_layoutViews;

- (void)o_onNotiTap;

#pragma mark - Search

- (void)o_searchDidTap;
- (void)o_searchFieldDidChange:(NSString *)text;
#pragma mark - NaviSet

- (void)el_setLeftNaviTitle:(NSString *)title;
- (void)el_setLeftNaviImage:(UIImage *)image;
- (void)el_setRightNavTitle:(NSString *)title;
- (void)el_setRightNavImage:(UIImage *)image;

- (void)el_onLeftNavBarTap;
- (void)el_onRightNavBarTap;


#pragma mark - show&hide tabbar
- (void)el_showTarBar:(BOOL)show;
//提示框
-(void)showCustomHudSingleLine:(NSString *)text;


@end
