//
//  EL0YuanController.m
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "EL0YuanController.h"
#import "ELMainService.h"
#import "ELMainBannerView.h"
#import "EL0YuanModel.h"
#import "ELWinnerModel.h"
#import "ELMessageCenterController.h"
#import "ELDrawCell.h"
#import "EL0YuanDetailController.h"
#import "ELMainShopController.h"
#import "ELDrawRuleView.h"

@interface EL0YuanController ()<UITableViewDelegate,UITableViewDataSource,ELDrawCellDelegate>

@property (nonatomic, strong) UIButton         *signButton;
@property (nonatomic, strong) ELMainBannerView *bannerView;
@property (nonatomic, weak  ) UITableView      *tableView;
@property (nonatomic, strong) EL0YuanModel     *model;
@property (nonatomic, strong) NSArray          *datas;
@property (nonatomic, strong) ELDrawRuleView   *ruleView;
@end

@implementation EL0YuanController


- (void)o_viewLoad{
    self.title = @"0元购抽奖";
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:self.signButton];
    self.navigationItem.rightBarButtonItems = @[self.notiItem,signItem];
}

- (void)o_configViews {
    UITableView *tableView               = [[UITableView alloc] init];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    tableView.tableHeaderView            = self.bannerView;
    [self.view addSubview:self.tableView = tableView ];
    
    [tableView registerClasses:@[@"ELDrawCell",@"ELWinnerCell"]];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
}

- (void)o_loadDatas{
    NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityId"];
    if ([cid isKindOfClass:[NSString class]] && cid.length > 0) {
        [ELMainService getDraw0YuanDataWithAreaId:cid block:^(BOOL success, id result) {
            if (success) {
                _model = [EL0YuanModel mj_objectWithKeyValues:result];
                __block NSMutableArray *bannerImages = [NSMutableArray arrayWithCapacity:0];
                [_model.bannerList enumerateObjectsUsingBlock:^(ELBannerlistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [bannerImages addObject:obj.imgUrl];
                }];
                [self.bannerView setImageViewAry:bannerImages];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        [ELMainService getWinnerListWithAreaId:cid block:^(BOOL success, id result) {
            if (success) {
                NSArray *array = result;
                _datas = [ELWinnerModel mj_objectArrayWithKeyValuesArray:array];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        if (Uid) {
            [ELMainService is0SignIn:Uid block:^(BOOL success, id result) {
                if (success) {
                    if ([(NSNumber *)result boolValue] == YES) {
                        [self.signButton setTitle:@"已签到" forState:UIControlStateNormal];
                        [self.signButton sizeToFit];
                        self.signButton.enabled = NO;
                    }
                }else{
                    
                }
            }];
        }
    }
}

#pragma mark - Private

- (NSString *)p_cellClassForIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return @"ELDrawCell";
    }else{
        return @"ELWinnerCell";
    }
}

#pragma mark - Response

- (void)onSignTap{
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    [ELMainService signInWithUserId:Uid block:^(BOOL success, id result) {
        if (success) {
            [self.view el_makeToast:result];
            
            [self.signButton setTitle:@"已签到" forState:UIControlStateNormal];
            [self.signButton sizeToFit];
            self.signButton.enabled = NO;

        }else{
            [self.view el_makeToast:result];
        }
    }];
    
    
    
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:[self p_cellClassForIndexPath:indexPath]];
    cell.delegate = self;
    if (indexPath.row == 0) {
        [cell setData:self.model];
    }else if (indexPath.row == 1){
        [cell setData:_datas];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ELDrawCellDelegate

- (void)drawCellOnDrawRuleTap {
    [self.view.window addSubview:self.ruleView];
}

- (void)drawCellDidTab {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)drawCellActionTapWithModel:(ELDrawtomModel *)model type:(NSInteger)type {
    if (type == 1) {
        ELMainShopController  *vc = [ELMainShopController new];
        vc.shopId =model.shopId;
        [self.navigationController pushViewController:vc animated:YES];
//        EL0YuanDetailController *vc = [[EL0YuanDetailController alloc] init];
//        vc.drawId = model.drawGoodsId;
//        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [ELMainService getDrawingWithDrawId:model.drawGoodsId userId:Uid block:^(BOOL success, id result) {
            if (success) {
                [self.view el_makeToast:@"抽奖成功"];
            }else{
                [self.view el_makeToast:result];
            }
        }];
    }
}

- (void)drawCellImageDidTapWithModel:(ELDrawtomModel *)model {
    ELMainShopController  *vc = [ELMainShopController new];
    vc.shopId =model.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getters
- (ELMainBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[ELMainBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(135))];
    }
    return _bannerView;
}

- (UIButton *)signButton {
    if (_signButton == nil) {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signButton setTitle:@"签到" forState:UIControlStateNormal];
        [_signButton setTitleColor:EL_MainColor forState:UIControlStateNormal];
        _signButton.titleLabel.font = kFont_System(15.f);
        [_signButton addTarget:self action:@selector(onSignTap) forControlEvents:UIControlEventTouchUpInside];
        [_signButton sizeToFit];
    }
    return _signButton;
}

- (ELDrawRuleView *)ruleView {
    if (_ruleView == nil) {
        _ruleView = [[ELDrawRuleView alloc] initWithFrame:self.view.window.bounds];
    }
    return _ruleView;
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
