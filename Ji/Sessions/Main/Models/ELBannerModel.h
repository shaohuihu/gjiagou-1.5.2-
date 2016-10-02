//
//  ELBannerModel.h
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELBannerModel : NSObject


@property (nonatomic, copy) NSString *_description;

@property (nonatomic, copy) NSString *areaId;

@property (nonatomic, assign) NSInteger bannerType;

@property (nonatomic, copy) NSString *agentId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) NSInteger link;

@property (nonatomic, copy) NSString *countyName;

@property (nonatomic, copy) NSString *countyId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) NSInteger bannerId;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, assign) NSInteger sort;


@end
