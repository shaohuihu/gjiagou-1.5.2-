//
//  ELCheckoutController.h
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELBasicViewController.h"
#import "ELDefaultAddressModel.h"
#import "AddressListModel.h"
@class ELGoodsDetailModel;




@interface ELCheckoutController : ELBasicViewController

@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, assign) double totalMoney;
@property (nonatomic, assign) double postage;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) AddressListModel *addressModel;
@property (nonatomic, strong) ELGoodsDetailModel *goodsDetailModel;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *stardandValue;

@property (nonatomic, assign) BOOL fromNow;//立即购买
@property(nonatomic,strong)NSDictionary * turnDic;//用来判断代金券是不是可用的,字典
/****************************这里面有我8月26号，添加的**************************************/
@property(nonatomic,strong)NSMutableArray * red_id;//这个是从购物车页面传进来的一个购物车id
@property(nonatomic,strong)NSString * moneyS;//用来判断要减多少元钱
@property(nonatomic,assign)NSInteger goodID;//这个的作用是用来存放商品详情页进来的goodsID

- (NSString *)jumpToBizPay;
@end
