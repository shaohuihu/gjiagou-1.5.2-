//
//  ELMessageCenterController.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMessageCenterController.h"
#import "ELMessageService.h"
#import "ELMessageListModel.h"
#import "ELMessageDetailController.h"
#import "ELMesssageDeleteView.h"
#import "ELMessageModel+bind.h"
#import "ELMessageListCell.h"
#import "DBNodataView.h"

@interface ELMessageCenterController ()<UITableViewDelegate,UITableViewDataSource,ELMessageListCellDelegate,ELMesssageDeleteViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
//一个用来存放什么的可变的数组
@property (nonatomic, strong) NSMutableArray *datas;
//一个底部的视图
@property (nonatomic, weak) ELMesssageDeleteView *bottomView;

@property (nonatomic, strong) DBNodataView *noDadaView;

@end

@implementation ELMessageCenterController
{
    NSInteger curPage_;//定义一个当前的页码
}

- (void)o_configDatas
{
    curPage_ = 1;
    _datas = [NSMutableArray arrayWithCapacity:0];//将数组进行初始化
}

- (void)o_configViews {
    self.title = @"消息中心";
    
    [self.view addSubview:self.noDadaView];
    
    ELMesssageDeleteView *bottomView = [[ELMesssageDeleteView alloc] init];
    bottomView.delegate = self;
    [self.view addSubview:self.bottomView = bottomView];
    //self.bottomView=bottomView;
    //[self.view addSubview:self.bottomView];
    
    UITableView *tableView               = [[UITableView alloc] init];
    tableView.backgroundColor            = EL_BackGroundColor;
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight         = 44;//ios7之后设置行高的一个方法
    [tableView registerClasses:@[@"ELMessageListCell"]];
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    
    [self.noDadaView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(0);
    }];

    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        curPage_ = 1;
        [ws p_loadDatas];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        curPage_++;
        [ws p_loadDatas];
    }];
    [tableView.mj_header beginRefreshing];
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-44);
    }];

    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.view);
        make.height.equalTo(44);
    }];
}

- (void)p_endRefresh{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}


#pragma mark - Private

- (void)p_loadDatas {
    WS(ws);
    [ELMessageService getAllMessageWithPageNum:curPage_ block:^(BOOL success, id result) {
        [self p_endRefresh];
        if (success) {
            ELMessageListModel *model = [ELMessageListModel mj_objectWithKeyValues:result];
            if (curPage_ == 1) {
                [_datas removeAllObjects];
            }
            [_datas addObjectsFromArray:model.results];
            self.bottomView.hidden = _datas.count == 0;
            self.noDadaView.hidden = _datas.count != 0;
            ws.tableView.hidden = !self.noDadaView.hidden;

            [ws.tableView reloadData];
        }
    }];
}


- (void)p_getState{
    __block BOOL isAll = YES;
    __block BOOL hasAny = NO;
    [_datas enumerateObjectsUsingBlock:^(ELMessageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL tag = [obj getBool];
        if (tag == NO) {
            isAll = NO;
        }else{
            hasAny = YES;
        }
    }];
    [self.bottomView setLeftTag:isAll rightTag:hasAny];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELMessageListCell"];
    [cell setData:_datas[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELMessageModel *model = _datas[indexPath.row];
    model.readStatus = 1;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    ELMessageDetailController *vc = [[ELMessageDetailController alloc] init];
    vc.messageId = model.messageId;
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - ELMessageListCellDelegate

- (void)listCellDidSelect:(ELMessageListCell *)cell{
    [self p_getState];
}

#pragma mark - ELMesssageDeleteViewDelegate
- (void)deleteViewTagButtonDidTapWithSelected:(BOOL)selected
{
    [_datas enumerateObjectsUsingBlock:^(ELMessageModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj bindBool:selected];
    }];
    [self.tableView reloadData];
}
- (void)deleteViewRightTap{
    __block NSMutableArray *messageIds = [NSMutableArray arrayWithCapacity:0];
    [_datas enumerateObjectsUsingBlock:^(ELMessageModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL tag = [obj getBool];
        if (tag == YES) {
            [messageIds addObject:@{@"id":@(obj.id)}];
        }
    }];
    [ELMessageService deleteMessages:messageIds block:^(BOOL success, id result) {
        [self p_loadDatas];
    }];
}


#pragma mark - Getters

- (DBNodataView *)noDadaView {
    if (_noDadaView == nil) {
        _noDadaView = [DBNodataView new];
        [_noDadaView setImage:@"ic_person_product_img" andUpLabel:@"暂无消息" andDownLabel:nil andBtn:nil];
    }
    return _noDadaView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
