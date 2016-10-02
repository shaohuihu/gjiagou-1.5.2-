//
//  EL0YuanModel.m
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "EL0YuanModel.h"

@implementation EL0YuanModel


+ (NSDictionary *)objectClassInArray{
    return @{@"drawTom" : [ELDrawtomModel class], @"drawGoodsList" : [ELDrawtomModel class], @"bannerList" : [ELBannerlistModel class]};
}
@end
@implementation ELDrawtomModel

@end


//@implementation ELDrawgoodslistModel
//
//@end


@implementation ELBannerlistModel

@end


