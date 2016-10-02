//
//  DBOrderDetialModel.h
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order,Order_Info,Shop,Goodslist;
@interface DBOrderDetialModel : NSObject

@property (nonatomic, strong) NSArray<Goodslist *> *goodsList;

@property (nonatomic, strong) Shop *shop;

@property (nonatomic, strong) Order *order;

@end
@interface Order : NSObject

@property (nonatomic, assign) double countMoney;//商品+邮费

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

@property (nonatomic, assign) NSInteger amount;//货物个数

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

@property (nonatomic, copy) NSString *goods_list;

@property (nonatomic, copy) NSString *sendDate;

@property (nonatomic, assign) double payment;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *lockStatus;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, assign) NSInteger countyId;

@property (nonatomic, copy) NSString *shopImage;

@property (nonatomic, assign) double totalPrice;//所有商品价格

@property (nonatomic, copy) NSString *commoditySplit;

@property (nonatomic, assign) NSInteger cityId;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) double shipping;//邮费

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



@interface Shop : NSObject

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, assign) NSInteger classifyId;

@property (nonatomic, assign) long long licenseEndDate;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, copy) NSString *license;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) long long licenseAtartDate;

@property (nonatomic, copy) NSString *operatingRange;

@property (nonatomic, copy) NSString *licenseCopy;

@property (nonatomic, copy) NSString *licenseArea;

@property (nonatomic, copy) NSString *socialCredit;

@property (nonatomic, copy) NSString *presales;

@property (nonatomic, copy) NSString *aftersales;

@property (nonatomic, copy) NSString *agentId;

@property (nonatomic, assign) NSInteger sellerId;

@property (nonatomic, assign) NSInteger recommended;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *classifyName;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *identitycardCopyup;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *openTime;

@property (nonatomic, copy) NSString *proclamation;

@property (nonatomic, copy) NSString *closeReason;

@property (nonatomic, assign) NSInteger auditStatus;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *decorationId;

@property (nonatomic, copy) NSString *auditDate;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *countyName;

@property (nonatomic, copy) NSString *identitycardCopyback;

@property (nonatomic, copy) NSString *sellerName;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, copy) NSString *workingTime;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *shopLogo;

@property (nonatomic, copy) NSString *endDate;

@end

@interface Goodslist : NSObject

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

@property (nonatomic, assign) double goodsPayPrice;

@end

