//
//  ELMainProductModel.h
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELMainGood;
@interface ELMainProductModel : NSObject


@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, assign) NSInteger isHot;

@property (nonatomic, copy) NSString *firstName;

@property (nonatomic, strong) NSArray<ELMainGood *> *goodses;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, assign) CGFloat commoditySplit;

@property (nonatomic, copy) NSString *childList;

@property (nonatomic, copy) NSString *seandName;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger parentId;


@end
@interface ELMainGood : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, assign) BOOL delete;

@property (nonatomic, copy) NSString *collected;

@property (nonatomic, copy) NSString *thirdClassName;

@property (nonatomic, assign) NSInteger postProvinceId;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, assign) NSInteger sumSold;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *classifyId;

@property (nonatomic, copy) NSString *shopIndex;

@property (nonatomic, assign) NSInteger postage;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *agentId;

@property (nonatomic, assign) NSInteger invoices;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *pictures;

@property (nonatomic, assign) double price;

@property (nonatomic, assign) NSInteger secondaryClassfication;

@property (nonatomic, copy) NSString *postCityName;

@property (nonatomic, copy) NSString *name1;

@property (nonatomic, assign) NSInteger postCityId;

@property (nonatomic, assign) NSInteger collectNum;

@property (nonatomic, copy) NSString *navigationName;

@property (nonatomic, assign) NSInteger brandId;

@property (nonatomic, assign) NSInteger firstClassfication;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *postProvinceName;

@property (nonatomic, copy) NSString *navigationId;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, assign) double  originalPrice;

@property (nonatomic, assign) NSInteger countyId;

@property (nonatomic, copy) NSString *firstClassName;

@property (nonatomic, copy) NSString *secondClassName;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *brandClass;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) NSInteger isIndex;

@property (nonatomic, copy) NSString *name2;

@property (nonatomic, assign) NSInteger monthSold;

@property (nonatomic, assign) NSInteger discussCount;

@property (nonatomic, copy) NSString *classifyIds;

@property (nonatomic, assign) NSInteger thirdClassfication;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, assign) NSInteger storage;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, copy) NSString *name3;

@property (nonatomic, copy) NSString *goodsNum;

@end

