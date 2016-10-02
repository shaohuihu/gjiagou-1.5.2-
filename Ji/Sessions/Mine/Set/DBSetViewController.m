
//
//  DBSetViewController.m
//  Ji
//
//  Created by sbq on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBSetViewController.h"
#import "ELMineNormalCell.h"
#import "DBPersonalViewController.h"
#import "DBUserSafyViewController.h"
#import "DBAboutViewController.h"
@interface DBSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation DBSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];

    // Do any additional setup after loading the view.
}

- (void)o_configDatas{
    _datas = @[
               @[
                   @{
                       @"title":@"个人信息",
                       @"image":@"ic_user_user",
                       @"cellClass":@"ELMineNormalCell"
                       },
                   @{
                       @"title":@"账户安全",
                       @"image":@"ic_user_safety",
                       @"cellClass":@"ELMineNormalCell"
                       },
                   @{
                       @"title":@"关于我们",
                       @"image":@"Info",
                       @"cellClass":@"ELMineNormalCell"
                       }
                   ]

               ];
    

}

- (void)o_configViews {
    
    self.view.backgroundColor            = EL_BackGroundColor;
    
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"ELMineNormalCell"]];
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logoutBtn setTitle:@"注销" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = kFont_System(14);
    logoutBtn.backgroundColor = [UIColor whiteColor];
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-49);
    }];
    

    [logoutBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.view);
        make.height.equalTo(49);
    }];
    
}
-(void)logout:(UIButton*)btn{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出该账户？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[DBUserCenter shareInstance]logout];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    


}
#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [_datas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = _datas[indexPath.section][indexPath.row];
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:data[@"cellClass"]];
    [cell setData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  //  [self setHidesBottomBarWhenPushed:YES];
    if (indexPath.row==0) {
        DBPersonalViewController *vc = [[DBPersonalViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
        DBUserSafyViewController *vc = [[DBUserSafyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==2) {
        DBAboutViewController *vc = [[DBAboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
