//
//  VouModel.m
//  Ji
//
//  Created by 龙讯科技 on 16/8/17.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "VouModel.h"

@implementation VouModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    if (self) {
        //属性的赋值
        _name=[NSString stringWithFormat:@"%@ 元代金券",[dic valueForKey:@"creditFrom"]];
        _priceL=[NSString stringWithFormat:@"%@",[dic valueForKey:@"creditFrom"]];
        
       
//        self.contentlabel.text = [NSString stringWithFormat:@"共%ld件商品 合计: ",(long)count.integerValue];
      
        _use=@"可购买济佳购              超市所有商品";
        _available=[NSString stringWithFormat:@"满%@元可用",[dic valueForKey:@"creditTo"]];
        _time=[NSString stringWithFormat:@"%@-%@",[dic valueForKey:@"validFrom"],[dic valueForKey:@"validTo"]];
        _money=@"￥";
        
    }
    
    return self;
    
  
}

+(instancetype)tgModelWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}




@end
