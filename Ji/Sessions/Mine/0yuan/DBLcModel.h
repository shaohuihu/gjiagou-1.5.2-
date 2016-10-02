//
//  DBLcModel.h
//  Ji
//
//  Created by ssgm on 16/6/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

//抽奖次数
@interface DBLcModel : NSObject

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger isDraw;

@property (nonatomic, assign) long long updateDate;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) NSInteger lotteryCodeId;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, assign) NSInteger isDelete;

@property (nonatomic, copy) NSString *goodsPicture;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *lotteryCode;

@end
