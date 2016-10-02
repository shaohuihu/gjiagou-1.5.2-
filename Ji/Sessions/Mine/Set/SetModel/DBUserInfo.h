//
//  DBUserInfo.h
//  Ji
//
//  Created by sbq on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order_Num;
@interface DBUserInfo : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *career;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) long long signInDate;

@property (nonatomic, assign) NSInteger freeze;

@property (nonatomic, assign) NSInteger signInStatus;

@property (nonatomic, copy) NSString *avatarUrl;

@property (nonatomic, copy) NSString *lastLoginDate;

@property (nonatomic, copy) NSString *orderString;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *collection_shop_num;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, strong) Order_Num *order_num;

@property (nonatomic, copy) NSString *collection_num;
-(id)initWithDic:(NSDictionary*)dic;

@end

@interface Order_Num : NSObject

@property (nonatomic, copy) NSString *shipped;

@property (nonatomic, copy) NSString *await_pay;

@property (nonatomic, copy) NSString *await_ship;

@property (nonatomic, copy) NSString *finished;

@end

