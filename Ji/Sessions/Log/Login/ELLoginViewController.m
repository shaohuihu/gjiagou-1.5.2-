
//
//  ELLoginViewController.m
//  Ji
//
//  Created by ssgm on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELLoginViewController.h"
#import "ELLoginFooterView.h"
#import "ELLoginCell.h"
#import "ELRegisterViewController.h"
#import "ELForgetOneViewController.h"
#import "DBMsgModel.h"
#import "DBRegService.h"
#import "DBUserCenter.h"
@interface ELLoginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TouchDeleget>

{

    ELLoginFooterView *_footerView;
    ELLoginCell *_oneCell;
    ELLoginCell *_secCell;
}
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation ELLoginViewController
-(void)o_load{
    self.title = @"账户登录";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    
    
    
    NSLog(@"account-%@",[[DBUserCenter shareInstance]getAccount]);
    NSLog(@"pw-%@",[[DBUserCenter shareInstance]getPw]);
}
-(void)el_onLeftNavBarTap{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)o_configDatas{
    self.dataArray = @[@{@"name":@"账户",
                         @"place":@"请输入账户"},
                       @{@"name":@"登录密码",
                         @"place":@"请输入登录密码"}];

}

-(void)o_configViews{

    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = EL_BackGroundColor;
    _footerView = [[ELLoginFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(115))];
    _footerView.delegate = self;
    self.table.tableFooterView = _footerView;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 11)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 11)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logincell"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ELLoginCell" owner:self options:nil]lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];

    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.leftLabel.text = dic[@"name"];
    cell.rightTextField.placeholder = dic[@"place"];
    cell.rightTextField.delegate = self;
    if (indexPath.row==0) {
        _oneCell = cell;
    }else{
        _secCell = cell;
        cell.rightTextField.secureTextEntry = YES;
    }
    return cell;
}




-(void)touchWithBtn:(UIButton *)btn{

    //免费注册
    if (btn==_footerView.registerBtn) {
        ELRegisterViewController *reg = [[ELRegisterViewController alloc]init];
        [self.navigationController pushViewController:reg animated:YES];
    }else if (btn==_footerView.forgetBtn){
    //忘记密码
        ELForgetOneViewController *forget = [[ELForgetOneViewController alloc]init];
        [self.navigationController pushViewController:forget animated:YES];
    
    }else{
    //登录
        if ([self isOkreq]) {
            //req
            [DBRegService loginWithName:_oneCell.rightTextField.text password:_secCell.rightTextField.text block:^(BOOL success, id result) {
                if (success) {
                    [[DBUserCenter shareInstance] saveWithDic:result];
                    //用户名和密码存起来
                    
                    [[DBUserCenter shareInstance]saveAccount:_oneCell.rightTextField.text andPw:_secCell.rightTextField.text andUid:result[@"id"]];
                    //
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    NSLog(@"%@",[DBUserCenter shareInstance]);
                    
                }else{
                    [self showCustomHudSingleLine:result];
                }
            }];
            
            
        }else{
        
            [self showCustomHudSingleLine:@"请输入账户和密码"];
        }
    
    }
}

-(BOOL)isOkreq{

    if (_oneCell.rightTextField.text.length==0 || _secCell.rightTextField.text.length==0) {
        return NO;
    }
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==_oneCell.rightTextField) {
        [_secCell.rightTextField becomeFirstResponder];
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
