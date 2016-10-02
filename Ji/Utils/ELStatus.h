//
//  ELStatus.h
//  Ji
//
//  Created by evol on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELStatus : NSObject

@property (nonatomic, assign) NSInteger succeed;

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, copy) NSString *error_desc;

@end
