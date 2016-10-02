//
//  ELMainShopTopModel.h
//  Ji
//
//  Created by evol on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ELShopinfoModel,ELGoodslistModel,ELGoodsslidesModel;
@interface ELMainShopTopModel : NSObject


@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, strong) ELShopinfoModel *shopInfo;

@property (nonatomic, strong) NSArray<ELGoodsslidesModel *> *goodsSlides;

@property (nonatomic, strong) NSArray<ELGoodslistModel *> *goodsList;

@property (nonatomic, assign) NSInteger pageNo;


@end

@interface ELShopinfoModel : NSObject

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, assign) NSInteger classifyId;

@property (nonatomic, copy) NSString *licenseEndDate;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, copy) NSString *bannerPath;

@property (nonatomic, copy) NSString *license;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *licenseAtartDate;

@property (nonatomic, copy) NSString *operatingRange;

@property (nonatomic, copy) NSString *licenseCopy;

@property (nonatomic, copy) NSString *licenseArea;

@property (nonatomic, copy) NSString *socialCredit;

@property (nonatomic, copy) NSString *presales;

@property (nonatomic, copy) NSString *aftersales;

@property (nonatomic, copy) NSString *agentId;

@property (nonatomic, assign) NSInteger sellerId;

@property (nonatomic, assign) NSInteger recommended;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *qrcode;

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

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, strong) NSArray<NSString *> *shopCategory;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, strong) NSArray *goods;

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

@interface ELGoodslistModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, assign) BOOL delete;

@property (nonatomic, copy) NSString *collected;

@property (nonatomic, copy) NSString *thirdClassName;

@property (nonatomic, copy) NSString *postProvinceId;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, assign) NSInteger sumSold;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *classifyId;

@property (nonatomic, assign) NSInteger shopIndex;

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

@property (nonatomic, copy) NSString *postCityId;

@property (nonatomic, assign) NSInteger collectNum;

@property (nonatomic, copy) NSString *navigationName;

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, assign) NSInteger firstClassfication;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *postProvinceName;

@property (nonatomic, copy) NSString *navigationId;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, assign) double originalPrice;

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

@interface ELGoodsslidesModel : NSObject

@property (nonatomic, copy) NSString *imgFileName;

@property (nonatomic, copy) NSString *standardId;

@property (nonatomic, copy) NSString *fullPath;

@property (nonatomic, copy) NSString *goodsImage;

@property (nonatomic, copy) NSString *goodsId;

@property (nonatomic, copy) NSString *imgId;

@end

