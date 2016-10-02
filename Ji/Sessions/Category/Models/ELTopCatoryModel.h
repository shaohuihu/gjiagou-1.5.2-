//
//  ELTopCatoryModel.h
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELTopCatoryModel : NSObject


@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, assign) NSInteger isHot;

@property (nonatomic, copy) NSString *firstName;

@property (nonatomic, copy) NSString *goodses;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, assign) CGFloat commoditySplit;

@property (nonatomic, copy) NSString *childList;

@property (nonatomic, copy) NSString *seandName;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger parentId;


@end
