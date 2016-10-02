//
//  DBModifyPwViewController.m
//  Ji
//
//  Created by sbq on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBModifyPwViewController.h"
#import "ELRegisterCell.h"
#import "ELNextView.h"
#import "DBMineService.h"
@interface DBModifyPwViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    ELRegisterCell *_oneCell;
    ELRegisterCell *_twoCell;
    ELRegisterCell *_thrCell;
    ELNextView *_footerView;
}
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation DBModifyPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码修改";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)el_onLeftNavBarTap{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)o_configDatas{
    self.dataArray = @[
                       @{@"name":@"原密码",
                         @"place":@"请输入原密码",
                         },
                       @{@"name":@"新密码",
                         @"place":@"请输入新密码",
                         },
                       @{@"name":@"确认密码",
                         @"place":@"请确认密码",
                         }
                       ];
    
    
}

-(void)o_configViews{
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = EL_BackGroundColor;
    _footerView = [[ELNextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    [_footerView.okBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView.okBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.table.tableFooterView = _footerView;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 11)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ELRegisterCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"ELRegisterCell" owner:self options:nil]lastObject];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    cell.rightTextField.secureTextEntry = YES;
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.leftLabel.text = dic[@"name"];
    cell.rightTextField.placeholder = dic[@"place"];
    cell.rightTextField.delegate = self;
    if (indexPath.row==0) {
        _oneCell = cell;
        
    }else if (indexPath.row==1){
        _twoCell = cell;
    }else{
        _thrCell = cell;
    }
    return cell;
    
}



-(void)touchWithBtn:(UIButton *)btn{
    if (btn==_footerView.okBtn) {
        NSLog(@"保存按下");
        
        if (_oneCell.rightTextField.text.length==0) {
            [self.view el_makeToast:@"请输入原密码"];
            //[self showCustomHudSingleLine:@"请输入原密码"];
            return;
        }
        if (_twoCell.rightTextField.text.length==0) {
            [self.view el_makeToast:@"请输入新密码"];

           // [self showCustomHudSingleLine:@"请输入新密码"];
            return;
        }
        if (_thrCell.rightTextField.text.length==0) {
            [self.view el_makeToast:@"请输入确认密码"];

           // [self showCustomHudSingleLine:@"请输入确认密码"];
            return;
        }
        
        if (![_oneCell.rightTextField.text isEqualToString:[[DBUserCenter shareInstance]getPw]]) {
            [self.view el_makeToast:@"输入密码错误"];

            //[self showCustomHudSingleLine:@"输入密码错误"];
            return;
        }
        
        if ( _twoCell.rightTextField.text.length<8 || _thrCell.rightTextField.text.length<8) {
            [self.view el_makeToast:@"密码位数不足8位"];

            //[self showCustomHudSingleLine:@"密码位数不足8位"];
            return ;
        }
        
        if ( _twoCell.rightTextField.text.length>16||_twoCell.rightTextField.text.length>16) {
            [self.view el_makeToast:@"密码位数超过16位"];

            //[self showCustomHudSingleLine:@"密码位数超过16位"];
            return ;
        }
        
        
        if (![_twoCell.rightTextField.text isEqualToString:_thrCell.rightTextField.text]) {
            [self.view el_makeToast:@"两次输入不一致"];

            //[self showCustomHudSingleLine:@"两次输入不一致"];
            return;
        }
        
        int countAlp = 0;
        int  countNum = 0 ;
        for (int i = 0; i < _twoCell.rightTextField.text.length; i ++) {
            char c =  [_twoCell.rightTextField.text characterAtIndex:i];
            if ( c >='a' && c <='z') {
                countAlp ++ ;
            }  else if (c >= 'A' && c <= 'Z'){
                countAlp ++ ;
            }else if (  c >= 48 && c  <= 57 ){
                countNum ++ ;
            }
        }
        NSLog(@"%d %d",countAlp,countNum);
        if ( countNum== 0 || countAlp == 0) {
            [self.view el_makeToast:@"请输入数字和字母组合"];

            //[self showCustomHudSingleLine:@"请输入数字和字母组合"];
            return ;
        }
        
        [DBMineService updatePassWithUid:UidStr passwordOrig:_oneCell.rightTextField.text passwordNew:_twoCell.rightTextField.text block:^(BOOL success, id result) {
            if (success) {
                [[NSUserDefaults standardUserDefaults]setObject:_twoCell.rightTextField.text forKey:@"pw"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self showCustomHudSingleLine:@"密码修改成功，下次使用新密码登录"];
                
            }else{
                [self showCustomHudSingleLine:result];
            }
        }];
        
//        [DBRegService saveForgetPasswordWithPhone:self.phone password:_oneCell.rightTextField.text block:^(BOOL success, id result) {
//            if (success) {
//                [[NSUserDefaults standardUserDefaults]setObject:_twoCell.rightTextField.text forKey:@"pw"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                [self.navigationController popToRootViewControllerAnimated:YES];
//                [self showCustomHudSingleLine:@"密码修改成功，使用新密码登录"];
//            }else{
//                [self showCustomHudSingleLine:result];
//            }
//        }];
        
    }
    
}

-(BOOL)isOkreq{
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==_oneCell.rightTextField) {
        [_twoCell.rightTextField becomeFirstResponder];
    }
    if (textField==_twoCell.rightTextField) {
        [_thrCell.rightTextField becomeFirstResponder];
    }
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_oneCell.rightTextField resignFirstResponder];
    
    [_twoCell.rightTextField resignFirstResponder];

    [_thrCell.rightTextField resignFirstResponder];

}
@end