//
//  DBGoodSaveModel.h
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBGoodSaveModel : NSObject

@property (nonatomic, assign) NSInteger collectionId;

@property (nonatomic, copy) NSString *goodses;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *shopImg;

@property (nonatomic, assign) NSInteger relevanceId;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) double price;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) NSInteger storage;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, copy) NSString *goodsImg;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *goodsId;

@end
