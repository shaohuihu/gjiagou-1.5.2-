//
//  AreaList.h
//  Ji
//
//  Created by evol on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaList : NSObject

@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *firstLetter;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *clickRate;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, strong) NSArray<AreaList *> *areaList;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, assign) NSInteger isAgent;

@property (nonatomic, copy) NSString *name;

@end

