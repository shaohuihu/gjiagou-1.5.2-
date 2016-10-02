//
//  DBUserCenter.h
//  Ji
//
//  Created by sbq on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUserCenter : NSObject

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

@property (nonatomic, copy) NSString *order_num;

@property (nonatomic, copy) NSString *collection_num;

@property (nonatomic, copy) NSString *uid;//自定义替换id



+ (DBUserCenter *)shareInstance;

-(void)saveWithDic:(NSDictionary*)dic;
-(void)saveAccount:(NSString*)account andPw:(NSString*)pw andUid:(NSNumber*)uid;

-(NSString*)getAccount;
-(NSString*)getPw;
-(NSString*)getUid;

-(void)logout;
@end
