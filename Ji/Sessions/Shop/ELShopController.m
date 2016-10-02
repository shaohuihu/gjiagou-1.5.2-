//
//  ELShopController.m
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopController.h"
#import "ELShopService.h"
#import "ELCartListModel.h"
#import "ELShopListHeaderView.h"
#import "ELShopCheckoutView.h"
#import "ELCartListCell.h"
#import "ELCartGoodsModel+bind.h"
#import "ELGoodDetailController.h"
#import "ELCheckoutController.h"
#import "ELDefaultAddressModel.h"
#import "DBNodataView.h"
#import "ELTabBarController.h"
#import "DBGoodsAddressViewController.h"
#import "ELMainService.h"
@interface ELShopController ()<UITableViewDelegate,UITableViewDataSource,ELCartListCellDelegate,ELShopCheckoutViewDelegate,ELShopListHeaderViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ELCartListModel *> *datas;
@property (nonatomic, weak) ELShopCheckoutView *bottomView;
@property (nonatomic, strong) NSMutableDictionary *headerViews;
@property (nonatomic, strong) DBNodataView *noDadaView;
@property (nonatomic, strong) NSMutableDictionary *requests;
@property (nonatomic, weak) UIButton *rightItemButton;

@end

@implementation ELShopController

- (void)o_viewLoad {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateSelected];
    [button setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    [button setTitleColor:EL_MainColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(onRightItemTap:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = kFont_System(16);
    [button sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.rightItemButton = button];
    self.navigationItem.rightBarButtonItem = item;
    
    self.title = @"购物车";
    //[ELShopService updateCartCountWithCartId:good.rec_id newNumber:count block:^(BOOL success, id result) {
    
    
}

- (void)o_configDatas{
    _headerViews = [NSMutableDictionary dictionaryWithCapacity:0];
    _datas       = [NSMutableArray arrayWithCapacity:0];
    _requests    = [NSMutableDictionary dictionaryWithCapacity:0];
}

- (void)o_viewAppear {
    self.rightItemButton.selected = NO;
    self.bottomView.type = CheckoutType_Order;
    [self p_loadDatas];
}

- (void)o_loadDatas {
}

- (void)o_configViews {
    
    [self.view addSubview:self.noDadaView];
    
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    [tableView registerClasses:@[@"ELCartListCell"]];
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    CGFloat bottomMargin = 0;
    CGFloat nodataMargin = 0;
    if (self.tabBarController.tabBar.hidden) {
        bottomMargin = -44;
        nodataMargin = 0;
    }else{
        bottomMargin = -49-44;
        nodataMargin = -49;
    }
    
    [self.noDadaView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(nodataMargin);
    }];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(bottomMargin);
    }];
    
    ELShopCheckoutView *bottomView = [[ELShopCheckoutView alloc] init];
    bottomView.delegate = self;
    [self.view addSubview:self.bottomView = bottomView];
    
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
//        make.top.equalTo(tableView.bottom);
        make.bottom.equalTo(ws.view).offset(nodataMargin);
        make.height.equalTo(44);
    }];
}

#pragma mark - Private 

- (void)p_loadDatas {
    WS(ws);
    [ELShopService getCartListWithBlock:^(BOOL success, id result) {
        if (success) {
            [_datas removeAllObjects];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSArray *array = result[@"goods_list"];
                __block NSInteger totalCount = 0;
                array = [ELCartListModel mj_objectArrayWithKeyValuesArray:array];
                [array enumerateObjectsUsingBlock:^(ELCartListModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                    [model.goods addObjectsFromArray:model.goodslist];
                    [_datas addObject:model];
                    [model.goodslist enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        totalCount += obj.goods_number;
                    }];
                }];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [(ELTabBarController *)self.tabBarController setBadgeValue:totalCount];
                    self.bottomView.hidden = _datas.count == 0;
                    self.noDadaView.hidden = _datas.count != 0;
                    ws.tableView.hidden = !self.noDadaView.hidden;
                    [ws.tableView reloadData];
                    if (self.bottomView.type == CheckoutType_Order) {
                        [ws p_getTotalCountAndPrice];
                    }
                });
            });
        }
    }];

}

- (void)p_getTotalCountAndPrice{
    __block double totalCount = 0;
    __block double totalPrice = 0;
    __block BOOL isAll = YES;
    [_datas enumerateObjectsUsingBlock:^(ELCartListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL tag = [good getBool];
            if (tag == NO) {
                totalCount += good.goods_number;
                totalPrice += good.goods_price*good.goods_number;
            }else{
                isAll = NO;
            }
        }];
    }];
    [self.bottomView setPrice:totalPrice count:totalCount isAll:isAll];
}

- (void)p_getAllDeleTag{
    __block BOOL isAll = YES;
    [_datas enumerateObjectsUsingBlock:^(ELCartListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL tag = [good getDelKey];
            if (tag == NO) {
                isAll = NO;
                *stop = YES;
            }
        }];
    }];
    [self.bottomView setPrice:0 count:0 isAll:isAll];
}


#pragma mark - Response

- (void)onRightItemTap:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        self.bottomView.type = CheckoutType_Delete;
        [self p_getAllDeleTag];
    }else{
        self.bottomView.type = CheckoutType_Order;
        [self p_getTotalCountAndPrice];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ELCartListModel *model = _datas[section];
    return model.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELCartListCell"];
    cell.delegate = self;
    if (self.bottomView.type == CheckoutType_Order) {
        cell.type = 0;
    }else{
        cell.type = 1;
    }
    ELCartListModel *model = _datas[indexPath.section];
    [cell setData:model.goods[indexPath.row] index:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELCartListModel *model = _datas[indexPath.section];
    ELCartGoodsModel *good = model.goods[indexPath.row];
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = good.goods_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ELShopListHeaderView *view = [[ELShopListHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.delegate = self;
    view.section = section;
    ELCartListModel *model = _datas[section];
    view.model = model;
    __block BOOL isAll = YES;
    [model.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.bottomView.type == CheckoutType_Order) {
            if ([good getBool]) {
                isAll = NO;
                *stop = YES;
            }
        }else{
            if ([good getDelKey] == NO) {
                isAll = NO;
                *stop = YES;
            }
        }
    }];
    [view setState:isAll];
    [_headerViews setObject:view forKey:@(section)];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - ELCartListCellDelegate

- (void)listCell:(ELCartListCell *)cell didCheckoutButtonSelectWithIndexPath:(NSIndexPath *)indexPath{
    if (cell.type == 0) {//结算
        [self p_getTotalCountAndPrice];
        ELCartListModel *model = _datas[indexPath.section];
        __block BOOL isAll = YES;
        [model.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([good getBool]) {
                isAll = NO;
                *stop = YES;
            }
        }];
        
        ELShopListHeaderView *view = [_headerViews objectForKey:@(indexPath.section)];
        [view setState:isAll];
    }else{
        [self p_getAllDeleTag];
        ELCartListModel *model = _datas[indexPath.section];
        __block BOOL isAll = YES;
        [model.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([good getDelKey] == NO) {
                isAll = NO;
                *stop = YES;
            }
        }];
        
        ELShopListHeaderView *view = [_headerViews objectForKey:@(indexPath.section)];
        [view setState:isAll];
    }
}

- (void)listCell:(ELCartListCell *)cell didChangeCount:(NSInteger)count{
    ELCartGoodsModel *good = cell.data;
    [ELShopService updateCartCountWithCartId:good.rec_id newNumber:count block:^(BOOL success, id result) {
        if (success) {
            [self p_getTotalCountAndPrice];
        }else{
            [cell onDelTap];
            [self.view el_makeToast:result];
        }
    }];
}


#pragma mark - ELShopCheckoutViewDelegate 

- (void)checkoutViewTagButtonDidTapWithSelected:(BOOL)selected{
    WS(ws);
    [_datas enumerateObjectsUsingBlock:^(ELCartListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel*  _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
            if (ws.bottomView.type == CheckoutType_Order) {
                [good bindBool:!selected];
            }else{
                [good bindDelKey:selected];
            }
        }];
    }];
    [self.tableView reloadData];
}

- (void)checkoutRightTap {
    
    if (self.bottomView.type == CheckoutType_Delete) {
        [_requests removeAllObjects];
        WS(ws);
        [_datas enumerateObjectsUsingBlock:^(ELCartListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx1, BOOL * _Nonnull stop) {
                BOOL tag = [good getDelKey];
                if (tag == YES) {
                    [_requests setObject:@(YES) forKey:@(good.rec_id)];
                    [ELShopService deleteCartWithCartId:good.rec_id block:^(BOOL success, id result) {
                        [_requests removeObjectForKey:@(good.rec_id)];
                        if (_requests.count == 0) {
                            [ws p_loadDatas];
                        }
                        if (success) {
                        }
                    }];
                }
            }];
        }];
    }
    if (self.bottomView.type == CheckoutType_Order) {
        //没有核对
        
        [ELShopService getCheckoutDetailWithBlock:^(BOOL success, id result) {
            if (success) {
                id obj = result[@"defAdd"];
                if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
                    DBGoodsAddressViewController *vc = [[DBGoodsAddressViewController alloc]init];
                    vc.notSelect = YES;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    AddressListModel *model = [AddressListModel mj_objectWithKeyValues:result[@"defAdd"]];

                    //结算
                    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                    __block double totalPrice = 0;
                    __block double totalPost = 0;
                    __block NSInteger totalCount = 0;
               //这里面有我要添加的一个加red_id的东西
                    __block NSString * rec_id=0;
               //用来盛放rec_id的一个数组
                    __block NSMutableArray * rec_array=[NSMutableArray arrayWithCapacity:0];
                    
                    [_datas enumerateObjectsUsingBlock:^(ELCartListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [obj.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
                            BOOL tag = [good getBool];
                            if (tag == NO) {
                                totalCount += good.goods_number;
                                totalPrice += good.goods_price*good.goods_number;
                                totalPost += good.postage;
                                rec_id=[NSString stringWithFormat:@"%ld",(long)good.rec_id];
                                [array addObject:good];
                                
                                [rec_array addObject:rec_id];
                            }else{
                            }
                        }];
                    }];
                    
                    DDLog(@"最后一天了%@",rec_array);
                    //在这里调用一次用的方法
                    
                    [ELMainService getVouchersWhetherWithcartIds:rec_array  uid:Uid  block:^(BOOL success, id result) {
                        if (success) {
                            DDLog(@"今天是周末%@",result);
                            
                            ELCheckoutController *vc = [[ELCheckoutController alloc] init];
                            vc.goods = array;
                            vc.totalMoney = totalPost + totalPrice;
                            vc.postage = totalPost;
                            vc.count = totalCount;
                            vc.addressModel = model;
                            vc.red_id=result;
                           
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }else{
                            ELCheckoutController *vc = [[ELCheckoutController alloc] init];
                            vc.goods = array;
                            vc.totalMoney = totalPost + totalPrice;
                            vc.postage = totalPost;
                            vc.count = totalCount;
                            vc.addressModel = model;
                            vc.red_id=nil;
                            vc.moneyS=nil;
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        
                        }
                    }];

                }
            }
        }];
    }
}


#pragma mark - ELShopListHeaderViewDelegate

- (void)topViewCheckoutButtonDidTapWithSection:(NSInteger)section selected:(BOOL)selected{
    ELCartListModel *model = _datas[section];
    [model.goods enumerateObjectsUsingBlock:^(ELCartGoodsModel*  _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.bottomView.type == CheckoutType_Order) {
            [good bindBool:!selected];
        }else{
            [good bindDelKey:selected];
        }
    }];
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}

#pragma mark - Getters

- (DBNodataView *)noDadaView {
    if (_noDadaView == nil) {
        _noDadaView = [DBNodataView new];
        [_noDadaView setImage:@"ic_shopping_img" andUpLabel:@"购物车还是空的！" andDownLabel:@"去挑一些中意的商品吧" andBtn:nil];
    }
    return _noDadaView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
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
