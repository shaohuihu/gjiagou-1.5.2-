//
//  ELMessageListModel.h
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELMessageModel;
@interface ELMessageListModel : NSObject


@property (nonatomic, copy) NSString *loadMore;

@property (nonatomic, strong) NSArray<ELMessageModel *> *results;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) NSInteger total;


@end
@interface ELMessageModel : NSObject

@property (nonatomic, assign) NSInteger messageId;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *messageTitle;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger readStatus;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *sysUserId;

@property (nonatomic, assign) long long createDate;

@end

