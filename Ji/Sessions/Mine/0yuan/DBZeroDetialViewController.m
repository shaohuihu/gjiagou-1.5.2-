
//
//  DBZeroDetialViewController.m
//  Ji
//
//  Created by sbq on 16/6/12.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBZeroDetialViewController.h"
#import "DBZeroLabelCell.h"
#import "ELMainService.h"
@interface DBZeroDetialViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_img;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation DBZeroDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"0元购抽奖";
    self.navigationItem.rightBarButtonItem = self.notiItem;
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
}

-(void)o_configDatas{
    [ELMainService getDrawGoodsDetailWithGoodsId:self.goodsId  block:^(BOOL success, id result) {
        if (success) {
            self.dataDic = result;
            if (result[@"goodsPicture"]) {
                [_img sd_setImageWithURL:ELIMAGEURL(result[@"goodsPicture"])];
            }
            [self.tableView reloadData];
        }
    }];

}


-(void)o_configViews{

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor            = EL_BackGroundColor;
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"DBZeroLabelCell"]];
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = [UIColor whiteColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(0);
    }];
    
    UIView *bg = [UIView new];
    bg.backgroundColor = EL_BackGroundColor;
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(76));
    
    UIImageView *img = [UIImageView new];
    img.frame = CGRectMake(5, 5, SCREEN_WIDTH-10, kRadioValue(66));
    [bg addSubview:_img=img];

    
    tableView.tableHeaderView = bg;
    
}
#pragma mark - UITableViewDelegate UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DBZeroLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBZeroLabelCell"];
    if (indexPath.row==0) {
        [cell setData:self.dataDic[@"goodsName"]];
    }else if (indexPath.row==1){
        [cell setData:[NSString stringWithFormat:@"开奖日期：%@",self.dataDic[@"drawGoodsDate"]]];
    }else{
        [cell setData:[NSString stringWithFormat:@"详情：%@",self.dataDic[@"goodsDetail"]]];
    }
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = [UIColor whiteColor];
    return bgView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = [UIColor whiteColor];
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


@end
