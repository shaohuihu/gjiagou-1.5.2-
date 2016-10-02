//
//  VouModel.h
//  Ji
//
//  Created by 龙讯科技 on 16/8/17.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface VouModel : NSObject
@property (nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * priceL;
@property(nonatomic,strong)NSString * use;
@property(nonatomic,strong)NSString * available;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * money;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)tgModelWithDic:(NSDictionary *)dic;



@end
