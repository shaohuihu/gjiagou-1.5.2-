//
//  ELHomeGoodsCell.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELHomeGoodsCell.h"
#import "ELHotGoodsHorCell.h"

@interface ELHomeGoodsCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ELHomeGoodsCell
{
    UIImageView *imageView_;
}

- (void)o_configViews{
    
    self.contentView.backgroundColor = [UIColor greenColor];
    
    WS(ws);

    UIView *view = [UIView new];
    [self.contentView addSubview:view];
    
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(kRadioXValue(90));
        make.edges.equalTo(ws.contentView);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kRadioXValue(90), SCREEN_WIDTH)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.center = CGPointMake(SCREEN_WIDTH/2, kRadioXValue(90)/2);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 90;
    [view addSubview:self.tableView = tableView ];
    tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [tableView registerClass:[ELHotGoodsHorCell class] forCellReuseIdentifier:@"horCell"];
}

#pragma mark - UITableViewDelegate UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"horCell"];
    [cell setData:_datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(homeGoodsCellDidClickWithModel:)]) {
        [self.delegate homeGoodsCellDidClickWithModel:_datas[indexPath.row]];
    }
}

- (void)o_dataDidChanged{
    if ([self.data isKindOfClass:[NSArray class]]) {
        self.datas = self.data;
        [self.tableView reloadData];
    }
}


@end
