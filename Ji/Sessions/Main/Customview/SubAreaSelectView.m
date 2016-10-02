//
//  SubAreaSelectView.m
//  shop
//
//  Created by lwq on 16/4/14.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "SubAreaSelectView.h"

@interface SubAreaSelectView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIView *centerV;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UIButton *changeBtn;

@end

@implementation SubAreaSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initBgView];
        [self initCenterV];
        [self initTbView];
        [self initLocationV];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"locationCityName"]) {
            self.locationCityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCityName"];
        }
    }
    return self;
}

- (void)initBgView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap)]];
    [self addSubview:view];
    _bgView = view;
}

- (void)bgTap
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self.tableView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)initCenterV
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, (self.bounds.size.height -250) /2.0, self.bounds.size.width -80, 250)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    _centerV = view;
}

- (void)initTbView
{
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, _centerV.bounds.size.width, _centerV.bounds.size.height -50) style:UITableViewStylePlain];
    tv.delegate = self;
    tv.dataSource = self;
    [_centerV addSubview:tv];
    _tableView = tv;
}

- (void)initLocationV
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, _tableView.bounds.size.height, _centerV.bounds.size.width -30, 1)];
    line.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0];
    [_centerV addSubview:line];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"locationCityName"]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, _tableView.bounds.size.height, _centerV.bounds.size.width -80, 40)];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor darkGrayColor];
        
        label.text = @"当前定位城市 ";
        [_centerV addSubview:label];
        _locationLabel = label;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(label.el_left + label.el_width, label.el_top, _centerV.bounds.size.width -15 -CGRectGetMaxX(label.frame), label.bounds.size.height)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:@"切换" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeToLocatoin) forControlEvents:UIControlEventTouchUpInside];
        [_centerV addSubview:btn];
        _changeBtn = btn;
    }
}

- (void)changeToLocatoin
{
    AreaList *model = [[AreaList alloc] init];
    model.name = self.locationCityName;
    if (self.block) {
        [self bgTap];
        self.block(model);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AreaList *model = _dataArr[indexPath.row];
    if (self.block) {
        [self bgTap];
        self.block(model);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ide = @"ide";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ide];
    }
    AreaList *model = _dataArr[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    [_tableView reloadData];
}

- (void)setLocationCityName:(NSString *)locationCityName
{
    _locationCityName = locationCityName;
    
    _locationLabel.text = [NSString stringWithFormat:@"当前定位城市 %@",locationCityName];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
