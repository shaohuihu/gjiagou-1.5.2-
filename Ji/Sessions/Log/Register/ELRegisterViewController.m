//
//  ELRegisterViewController.m
//  Ji
//
//  Created by ssgm on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRegisterViewController.h"
#import "ELRegFooterView.h"
#import "ELCodeCell.h"
#import "ELRegisterCell.h"
#import "DBRegService.h"
#import "DBHandel.h"
#import "DBMsgModel.h"
#import "DBXieyiViewController.h"

@interface ELRegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    ELRegisterCell *_oneCell;
    ELCodeCell *_secCell;
    ELRegisterCell *_thrCell;
    ELRegisterCell *_furCell;
    ELRegFooterView *_footerView;
    DBMsgModel *_msgModel;
    NSTimer *_timer;
    NSInteger _index;
    
    

}
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ELRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
}
-(void)el_onLeftNavBarTap{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)o_configDatas{
    self.dataArray = @[
                       @[
                           @{@"name":@"手机号",
                             @"place":@"请输入手机号",
                             @"xib":@"ELRegisterCell"},
                           @{@"name":@"验证码",
                             @"place":@"请输入验证码",
                             @"xib":@"ELCodeCell"}
                         ],
                       @[
                           @{@"name":@"密码",
                             @"place":@"请输入密码",
                             @"xib":@"ELRegisterCell"},
                           @{@"name":@"确认密码",
                             @"place":@"请确认密码",
                             @"xib":@"ELCodeCell"}
                           ],
                       ];
    
}

-(void)o_configViews{
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = EL_BackGroundColor;
    _footerView = [[ELRegFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    [_footerView.okBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView.xieyiBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.table.tableFooterView = _footerView;
    
}

#pragma mark---table代理们

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 11;
    }
    return 0.01;
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
    
    if (indexPath.row==1 && indexPath.section==0) {
        ELCodeCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ELCodeCell" owner:self options:nil]lastObject];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            
        
        NSDictionary *dic = self.dataArray[indexPath.section][indexPath.row];
        cell.leftLabel.text = dic[@"name"];
        cell.rightTextField.placeholder = dic[@"place"];
        DDLog(@"cell.rightTxetField%@",cell.rightTextField.placeholder);
        cell.rightTextField.delegate = self;
        [cell.codeButton addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        _secCell = cell;
        cell.rightTextField.secureTextEntry = NO;

        return cell;

    }else{
        ELRegisterCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"ELRegisterCell" owner:self options:nil]lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        
        
        NSDictionary *dic = self.dataArray[indexPath.section][indexPath.row];
        cell.leftLabel.text = dic[@"name"];
        cell.rightTextField.placeholder = dic[@"place"];
        cell.rightTextField.delegate = self;

        if (indexPath.row==0 && indexPath.section==0) {
            _oneCell = cell;
        }else if (indexPath.row==0 && indexPath.section==1){
            _thrCell = cell;
            cell.rightTextField.secureTextEntry = YES;

        }else{
            _furCell = cell;
            cell.rightTextField.secureTextEntry = YES;

        }
        return cell;

    }
}

#pragma mark---其他
//按钮按下
-(void)touchWithBtn:(UIButton *)btn{
    if (btn==_footerView.okBtn) {
        NSLog(@"注册按下");
        if ([self isOkreq]) {
            [DBRegService registerWithName:_oneCell.rightTextField.text password:_thrCell.rightTextField.text phone:_oneCell.rightTextField.text sessionId:_msgModel.sessionId block:^(BOOL success, id result) {
                if (success) {
                    
                    //直接登录
                    [self login];
                    //[self showCustomHudSingleLine:result];
                    NSLog(@"注册成功");
                }else{
                    [self showCustomHudSingleLine:result];
                    NSLog(@"注册失败抛提示");
                
                }
            }];
        }
    }
    if (btn==_footerView.xieyiBtn) {
        NSLog(@"协议按下");
        DBXieyiViewController *xie = [[DBXieyiViewController alloc]init];
        [self.navigationController pushViewController:xie animated:YES];
    }
    if (btn==_secCell.codeButton) {
        NSLog(@"验证码按下");
        if (btn && [DBHandel isValidateMobile:_oneCell.rightTextField.text]) {
            
            if (_timer==nil) {
                _index = TimeInterval;
                [DBRegService sendRegMsgWithPhoneNumber:_oneCell.rightTextField.text block:^(BOOL success, id result) {
                    if (success) {
                        //获取到验证码成功
                        _secCell.codeButton.userInteractionEnabled  = NO;

                        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(btnTitleRefresh) userInfo:nil repeats:YES];
                        
                        _secCell.codeLabel.text = [NSString stringWithFormat:@"%lu秒后重新发送",(long)_index];
                        
                        _msgModel = [DBMsgModel mj_objectWithKeyValues:result];
                        NSLog(@"%@",_msgModel);
                    }else{
                        //获取到验证码失败
                        [self showCustomHudSingleLine:result];

                    }
                }];
                

            }
        }else{
        
            [self showCustomHudSingleLine:@"请输入正确的手机号"];
        }

    }

}

//注册完毕自动登录上去
-(void)login{

    [DBRegService loginWithName:_oneCell.rightTextField.text password:_thrCell.rightTextField.text block:^(BOOL success, id result) {
        if (success) {
            //登录登录成功
            NSLog(@"登录成功");
            [[DBUserCenter shareInstance] saveWithDic:result];
            //用户名和密码存起来
            [[DBUserCenter shareInstance]saveAccount:_oneCell.rightTextField.text andPw:_secCell.rightTextField.text andUid:result[@"id"]];
            
            [self showCustomHudSingleLine:@"登录成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            //登录失败
            NSLog(@"登录异常抛提示");
            [self showCustomHudSingleLine:result];
        }
    }];

}


//定时刷新
-(void)btnTitleRefresh{
    _index--;
    if (_index==0) {
        _secCell.codeLabel.text = @"点击获取验证码";
        _secCell.codeButton.userInteractionEnabled = YES;
        [_timer invalidate];
        _index = TimeInterval;
        _timer = nil;
    }else{
        _secCell.codeLabel.text = [NSString stringWithFormat:@"%lu秒后重新发送",(long)_index];
    }
}

//判空
-(BOOL)isOkreq{
    if (_oneCell.rightTextField.text.length!=11 || [DBHandel isValidateMobile:_oneCell.rightTextField.text]==NO) {
        [self showCustomHudSingleLine:@"请输入正确的手机号"];
        return NO;
    }
    if (_secCell.rightTextField.text.length==0 || [_secCell.rightTextField.text isEqualToString:_msgModel.code]==NO) {
        [self showCustomHudSingleLine:@"请输入正确的验证码"];
        return NO;
    }
    
    if ( _thrCell.rightTextField.text.length<8 || _furCell.rightTextField.text.length<8) {
        
        [self showCustomHudSingleLine:@"密码位数不足8位"];
        return NO;
    }
    
    if (_thrCell.rightTextField.text.length>16 || _furCell.rightTextField.text.length>16) {
        [self showCustomHudSingleLine:@"密码位数超过16位"];
        return NO;
    }
    if (![_thrCell.rightTextField.text isEqualToString:_furCell.rightTextField.text]) {
        [self showCustomHudSingleLine:@"两次输入密码不一致"];
        return NO;
    }
    
    int countAlp = 0;
    int  countNum = 0 ;
    for (int i = 0; i < _thrCell.rightTextField.text.length; i ++) {
        char c =  [_thrCell.rightTextField.text characterAtIndex:i];
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
        [self showCustomHudSingleLine:@"请输入数字和字母组合"];
        return NO;
    }
    
    return YES;
}


//收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==_oneCell.rightTextField) {
        [_secCell.rightTextField becomeFirstResponder];
    }
    if (textField==_secCell.rightTextField) {
        [_thrCell.rightTextField becomeFirstResponder];
    }
    if (textField==_thrCell.rightTextField) {
        [_furCell.rightTextField becomeFirstResponder];
    }

    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [_oneCell.rightTextField resignFirstResponder];
  
    [_secCell.rightTextField resignFirstResponder];

    [_thrCell.rightTextField resignFirstResponder];

    [_furCell.rightTextField resignFirstResponder];



}
@end
