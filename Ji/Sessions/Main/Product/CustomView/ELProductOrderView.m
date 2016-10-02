//
//  ELProductOrderView.m
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELProductOrderView.h"

@interface ELProductOrderView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ELProductOrderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}

#pragma mark - Setter

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}


#pragma mark - Private

- (void)p_setUp {
    
    _selectIndex = -1;
    
    [self addTarget:self action:@selector(onSelfTap) forControlEvents:UIControlEventTouchUpInside];
    _datas = @[@"价格从高到低",@"价格从低到高",@"人气排序"];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.el_width, 3*44)];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
//    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = [UIColor whiteColor];
    [tableView registerClasses:@[@"ELProductTopSelecCell"]];
    [self addSubview:self.tableView = tableView ];
}


#pragma mark - Response 

- (void)onSelfTap{
    [self hide];
}
#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELProductTopSelecCell"];
    [cell setData:_datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    _selectIndex = indexPath.row;
    if (self.selectBlock) {
        self.selectBlock(_selectIndex);
    }
    [self hide];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    return indexPath;
}


#pragma mark - Public
- (void)showInView:(UIView *)view {
    self.tableView.el_top = -3*44;
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.el_top = 0;
    }];
}


- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.el_top = -3*44;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view belowView:(UIView *)belowView {
    self.tableView.el_top = -3*44;
    [view insertSubview:self belowSubview:belowView];
    if (_selectIndex >= 0) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.el_top = 0;
    }];
}

@end
