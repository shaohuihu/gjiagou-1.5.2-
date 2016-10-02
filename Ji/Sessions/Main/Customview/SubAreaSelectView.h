//
//  SubAreaSelectView.h
//  shop
//
//  Created by lwq on 16/4/14.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaList.h"

typedef void(^SubAreaSelectViewBlock)(AreaList *model);

@interface SubAreaSelectView : UIView

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, copy) SubAreaSelectViewBlock block;

@property (nonatomic, copy) NSString *locationCityName;

@end
