//
//  DBAreaModel.h
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAreaModel : NSObject

@property(nonatomic,strong)NSString *countryName;//省
@property(nonatomic,strong)NSString *provinceName;//市
@property(nonatomic,strong)NSString *cityName;//县

@property(nonatomic,strong)NSString *countryId;//省
@property(nonatomic,strong)NSString *provinceId;//市
@property(nonatomic,strong)NSString *cityId;//县 --当时理解错了，字段写错了，讲错就错

@end
