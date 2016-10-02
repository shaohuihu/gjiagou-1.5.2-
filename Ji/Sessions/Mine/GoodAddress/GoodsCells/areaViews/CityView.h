//
//  CityView.h
//  KeGoal
//
//  Created by sbq on 15/8/29.
//  Copyright (c) 2015年 sbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListModel.h"
@class CityView;
@protocol CityDelegate <NSObject>

-(void)cityView:(CityView*)cityView selectedWith:(CityListModel*)model;

@end

@interface CityView : UIView<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
-(id)initWithFrame:(CGRect)frame andArray:(NSArray*)array;

//记录countryID 和 countryName;
@property(nonatomic,strong)NSString *countryName;
@property(nonatomic,strong)NSString *countryId;

//记录provinceID 和 provinceName;
@property(nonatomic,strong)NSString *provinceName;
@property(nonatomic,strong)NSString *provinceId;

@property(nonatomic,weak)id<CityDelegate>delegate;

@end
