//
//  AreaLocationModel.h
//  shop
//
//  Created by lwq on 16/4/12.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isValidStr(_ref) ((IsNilOrNull(_ref)==NO) && ([_ref length]>0))

#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isKindOfClass:[NSNull class]]) )

@class AreaList;

@interface AreaLocationModel : NSObject

@property (nonatomic,copy)NSString *areaID;
@property (nonatomic,copy)NSString *parentID;
@property (nonatomic,copy)NSString *areaName;
@property (nonatomic,copy)NSString *areaPY;
@property (nonatomic,copy)NSString *areaType;
@property (nonatomic, assign) BOOL sub;
@property (nonatomic, strong) AreaList *areaModel;
- (id)initWithDic:(NSDictionary *)dict;


@end

@interface NSDictionary (Additional)

- (NSString *)stringForKey:(NSString *)key;

@end