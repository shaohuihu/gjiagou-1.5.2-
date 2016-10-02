//
//  ELBrandModel.h
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELBrandModel : NSObject


@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *classifyName2;

@property (nonatomic, copy) NSString *classifyName3;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *isPermitted;

@property (nonatomic, copy) NSString *brandUrl;

@property (nonatomic, assign) BOOL isDelete;

@property (nonatomic, assign) NSInteger isSupper;

@property (nonatomic, copy) NSString *supperUrl;

@property (nonatomic, copy) NSString *abId;

@property (nonatomic, copy) NSString *classifyName;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, assign) NSInteger isRecommend;

@property (nonatomic, copy) NSString *isRecommenda;

@property (nonatomic, assign) NSInteger classifyId;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *name;


@end
