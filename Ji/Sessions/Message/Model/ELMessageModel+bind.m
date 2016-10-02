//
//  ELMessageModel+bind.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMessageModel+bind.h"

@implementation ELMessageModel (bind)

static char boolKey;

- (void)bindBool:(BOOL)tag{
    objc_setAssociatedObject(self, &boolKey, @(tag), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)getBool{
    NSNumber * boolValue = (NSNumber *)objc_getAssociatedObject(self, &boolKey);
    return boolValue.boolValue;
}

@end
