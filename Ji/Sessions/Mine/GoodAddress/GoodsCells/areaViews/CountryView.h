//
//  CountryView.h
//  KeGoal
//
//  Created by sbq on 15/8/28.
//  Copyright (c) 2015年 sbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinView.h"

@interface CountryView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;

//
@property(nonatomic,strong)ProvinView *provinView;



-(id)initWithFrame:(CGRect)frame andArray:(NSArray*)array;
@end
