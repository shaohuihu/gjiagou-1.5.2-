//
//  ELCartListModel.m
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCartListModel.h"

@implementation ELCartListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _goods = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"goodslist" : [ELCartGoodsModel class]};
}
@end
@implementation ELCartGoodsModel

@end


