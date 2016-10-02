//
//  ELOrderInfoModel.h
//  Ji
//
//  Created by evol on 16/6/7.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELOrderInfoModel : NSObject

@property (nonatomic, assign) double  order_amount;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *pay_code;

@end

