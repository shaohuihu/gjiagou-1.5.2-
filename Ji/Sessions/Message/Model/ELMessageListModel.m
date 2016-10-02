//
//  ELMessageListModel.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMessageListModel.h"

@implementation ELMessageListModel


+ (NSDictionary *)objectClassInArray{
    return @{@"results" : [ELMessageModel class]};
}
@end
@implementation ELMessageModel

@end


