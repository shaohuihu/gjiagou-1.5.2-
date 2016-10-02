//
//  ELCartGoodsModel+bind.m
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCartGoodsModel+bind.h"

static char boolKey;
static char delKey;
@implementation ELCartGoodsModel (bind)

- (void)bindBool:(BOOL)tag{
    objc_setAssociatedObject(self, &boolKey, @(tag), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)getBool{
    NSNumber * boolValue = (NSNumber *)objc_getAssociatedObject(self, &boolKey);
    return boolValue.boolValue;
}

- (void)bindDelKey:(BOOL)tag{
    objc_setAssociatedObject(self, &delKey, @(tag), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)getDelKey{
    NSNumber * boolValue = (NSNumber *)objc_getAssociatedObject(self, &delKey);
    return boolValue.boolValue;
}

@end
