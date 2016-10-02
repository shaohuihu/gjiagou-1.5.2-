//
//  DBShopSaveModel.h
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBShopSaveModel : NSObject

@property (nonatomic, assign) NSInteger collectionId;

@property (nonatomic, copy) NSString *goodses;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *shopImg;

@property (nonatomic, assign) NSInteger relevanceId;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *storage;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *goodsImg;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *goodsId;

@end
