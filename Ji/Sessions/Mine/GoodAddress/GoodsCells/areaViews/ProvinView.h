//
//  ProvinView.h
//  KeGoal
//
//  Created by sbq on 15/8/28.
//  Copyright (c) 2015年 sbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityView.h"
@interface ProvinView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)CityView *cityView;
-(id)initWithFrame:(CGRect)frame andArray:(NSArray*)array;

//记录countryID 和 countryName;
@property(nonatomic,strong)NSString *countryName;
@property(nonatomic,strong)NSString *countryId;
@end
