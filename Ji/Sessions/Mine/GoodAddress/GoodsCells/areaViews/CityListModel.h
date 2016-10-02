//
//  CityListModel.h
//  KeGoal
//
//  Created by sbq on 15/8/29.
//  Copyright (c) 2015年 sbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityListModel : NSObject

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *firstLetter;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger clickRate;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, copy) NSString *areaList;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, assign) NSInteger isAgent;

@property (nonatomic, copy) NSString *name;


@end
