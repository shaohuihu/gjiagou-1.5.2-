//
//  DBUserInfo.m
//  Ji
//
//  Created by sbq on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBUserInfo.h"

@implementation DBUserInfo
-(id)initWithDic:(NSDictionary*)dic{
    self = [super init];
    if (self ) {
        [self setValuesForKeysWithDictionary:dic];

    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);

}

@end
@implementation Order_Num

@end


