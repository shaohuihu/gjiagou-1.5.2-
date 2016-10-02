//
//  ELShopSearchModel.h
//  Ji
//
//  Created by evol on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELChildlistModel;
@interface ELShopSearchModel : NSObject


@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *isHot;

@property (nonatomic, copy) NSString *firstName;

@property (nonatomic, copy) NSString *goodses;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *isDelete;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *commoditySplit;

@property (nonatomic, strong) NSArray<ELChildlistModel *> *childList;

@property (nonatomic, copy) NSString *seandName;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;


@end
@interface ELChildlistModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *isHot;

@property (nonatomic, copy) NSString *firstName;

@property (nonatomic, copy) NSString *goodses;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *isDelete;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *commoditySplit;

@property (nonatomic, copy) NSString *childList;

@property (nonatomic, copy) NSString *seandName;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;

@end

