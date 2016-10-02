//
//  AddressListModel.h
//  Ji
//
//  Created by ssgm on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressListModel : NSObject

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *countyName;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) NSInteger isDefault;

@property (nonatomic, assign) NSInteger countyId;

@property (nonatomic, assign) NSInteger addressId;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *addressDetail;

@property (nonatomic, copy) NSString *telePhone;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) NSInteger provinceId;

@property (nonatomic, copy) NSString *zipCode;

@property (nonatomic, assign) NSInteger cityId;

@property (nonatomic, assign) long long updateDate;

@end
