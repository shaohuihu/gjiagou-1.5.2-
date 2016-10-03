
//
//  ELMainShopTopModel.m
//  Ji
//
//  Created by evol on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMainShopTopModel.h"

@implementation ELMainShopTopModel

+ (NSDictionary *)objectClassInArray{
    return @{@"recommendedGoods" : [ELGoodslistModel class], @"goodsSlides" : [ELGoodsslidesModel class],@"shopNavigations":[ELShopNavigationModel class],@"shopBanners":[ELShopBannerModel class]};
}
@end


@implementation ELShopinfoModel

@end


@implementation ELGoodslistModel

//替换制定的映射属性
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"isDelete" : @"delete"};
}

@end


@implementation ELGoodsslidesModel

@end


@implementation ELShopNavigationModel
@end

@implementation ELShopBannerModel

@end


