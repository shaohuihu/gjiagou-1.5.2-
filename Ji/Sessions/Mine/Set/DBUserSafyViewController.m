
//
//  DBUserSafyViewController.m
//  Ji
//
//  Created by ssgm on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBUserSafyViewController.h"
#import "DBPersionDownCell.h"
#import "DBModifyPwViewController.h"
#import "DBModifyPhoneOneViewController.h"
#import "DBModifyPhoneTwoViewController.h"
@interface DBUserSafyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation DBUserSafyViewController

-(void)o_load{
    self.title = @"账户安全";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
}
-(void)o_configDatas{
    _datas = @[@"修改密码",@"修改绑定手机号"];
}

-(void)o_configViews{
    self.view.backgroundColor            = EL_BackGroundColor;
    
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"DBPersionDownCell"]];
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-49);
    }];
    
}
#pragma mark - UITableViewDelegate UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [_datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DBPersionDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBPersionDownCell"];
    [cell setTitle:self.datas[indexPath.row]];
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
    if (indexPath.row==0) {
        DBModifyPwViewController *vc = [[DBModifyPwViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
        if ([self getMobile]>0) {
            DBModifyPhoneOneViewController *one = [[DBModifyPhoneOneViewController alloc]init];
            [self.navigationController pushViewController:one animated:YES];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有绑定手机，是否现在去绑定？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DBModifyPhoneTwoViewController *two = [[DBModifyPhoneTwoViewController alloc]init];
                [self.navigationController pushViewController:two animated:YES];
            }];
            
            [alert addAction:cancel];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
}

-(BOOL)getMobile{
    NSString *mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    if (mobile.length==11) {
        return YES;
    }
    return NO;
}
@end
