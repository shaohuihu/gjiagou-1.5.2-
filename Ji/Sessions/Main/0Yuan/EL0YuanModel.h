//
//  EL0YuanModel.h
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELDrawtomModel,ELBannerlistModel;
@interface EL0YuanModel : NSObject


@property (nonatomic, strong) NSArray<ELDrawtomModel *> *drawTom;

@property (nonatomic, strong) NSArray<ELDrawtomModel *> *drawGoodsList;

@property (nonatomic, strong) NSArray<ELBannerlistModel *> *bannerList;


@end
@interface ELDrawtomModel : NSObject

@property (nonatomic, assign) NSInteger areaId;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) NSInteger drawGoodsId;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) NSInteger sellerId;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, copy) NSString *drawGoodsDate;

@property (nonatomic, copy) NSString *goodsDetail;

@property (nonatomic, copy) NSString *goodsPicture;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *lotteryPool;

@end

//@interface ELDrawgoodslistModel : NSObject
//
//@property (nonatomic, assign) NSInteger areaId;
//
//@property (nonatomic, assign) long long updateDate;
//
//@property (nonatomic, copy) NSString *goodsName;
//
//@property (nonatomic, assign) NSInteger drawGoodsId;
//
//@property (nonatomic, assign) NSInteger isDelete;
//
//@property (nonatomic, assign) NSInteger sellerId;
//
//@property (nonatomic, copy) NSString *drawGoodsDate;
//
//@property (nonatomic, copy) NSString *goodsDetail;
//
//@property (nonatomic, copy) NSString *goodsPicture;
//
//@property (nonatomic, assign) long long createDate;
//
//@property (nonatomic, copy) NSString *lotteryPool;
//
//@end

@interface ELBannerlistModel : NSObject

@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *areaId;

@property (nonatomic, assign) NSInteger bannerType;

@property (nonatomic, copy) NSString *agentId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *countyName;

@property (nonatomic, copy) NSString *countyId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) NSInteger bannerId;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, assign) NSInteger sort;

@end

