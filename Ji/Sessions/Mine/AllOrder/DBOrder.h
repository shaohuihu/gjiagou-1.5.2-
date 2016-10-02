//
//  DBOrder.h
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order_Info,Goods_List;

@interface DBOrder : NSObject

@property (nonatomic, assign) float countMoney;

@property (nonatomic, copy) NSString *appCreateDate;

@property (nonatomic, assign) NSInteger goodsCount;

@property (nonatomic, copy) NSString *customerMessage;

@property (nonatomic, copy) NSString *trackingCompany;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, copy) NSString *sellerId;

@property (nonatomic, copy) NSString *payTime;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger delayStatus;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, assign) NSInteger provinceId;

@property (nonatomic, copy) NSString *agentId;

@property (nonatomic, copy) NSString *descriptions;

@property (nonatomic, copy) NSString *addressDetail;

@property (nonatomic, copy) NSString *orderGoodsList;

@property (nonatomic, assign) NSInteger bank;

@property (nonatomic, copy) NSString *isDelayTime;

@property (nonatomic, assign) double goodsPrice;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger orderString;

@property (nonatomic, copy) NSString *goodsImage;

@property (nonatomic, strong) Order_Info *order_info;

@property (nonatomic, strong) NSArray<Goods_List *> *goods_list;

@property (nonatomic, copy) NSString *sendDate;

@property (nonatomic, assign) NSInteger payment;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *lockStatus;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, assign) NSInteger countyId;

@property (nonatomic, copy) NSString *shopImage;

@property (nonatomic, assign) double totalPrice;

@property (nonatomic, copy) NSString *commoditySplit;

@property (nonatomic, assign) NSInteger cityId;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) double shipping;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, assign) NSInteger orderId;

@property (nonatomic, copy) NSString *trackingNo;

@property (nonatomic, copy) NSString *successDate;

@property (nonatomic, copy) NSString *delayTime;

@property (nonatomic, copy) NSString *payNo;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *isDis;

@property (nonatomic, assign) NSInteger addressId;

@property (nonatomic, copy) NSString *serialNo;

@property (nonatomic, copy) NSString *account;

@end
@interface Order_Info : NSObject

@property (nonatomic, copy) NSString *order_amount;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *pay_code;

@end

@interface Goods_List : NSObject

@property (nonatomic, copy) NSString *account;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *appCreateDate;

@property (nonatomic, copy) NSString *updatedTime;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) double goodsPrice;

@property (nonatomic, copy) NSString *goodsImage;

@property (nonatomic, copy) NSString *isPaid;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, copy) NSString *paidDate;

@property (nonatomic, copy) NSString *createdTime;

@property (nonatomic, copy) NSString *storeId;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger isDel;

@property (nonatomic, copy) NSString *standard;

@property (nonatomic, assign) NSInteger goodsNum;

@property (nonatomic, copy) NSString *buyerId;

@property (nonatomic, copy) NSString *goodsType;

@property (nonatomic, assign) double price;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, assign) double  goodsPayPrice;

@end

