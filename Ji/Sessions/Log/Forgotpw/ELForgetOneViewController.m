//
//  ELForgetOneViewController.m
//  Ji
//
//  Created by ssgm on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELForgetOneViewController.h"
#import "ELForgetTwoViewController.h"
#import "ELNextView.h"
#import "ELCodeCell.h"
#import "ELRegisterCell.h"
#import "DBMsgModel.h"
#import "DBHandel.h"
#import "DBRegService.h"
#define TimeInterval 60
@interface ELForgetOneViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    ELRegisterCell *_oneCell;
    ELCodeCell *_twoCell;
    ELNextView *_footerView;
    DBMsgModel *_msgModel;
    NSTimer *_timer;
    NSInteger _index;
}
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ELForgetOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
}
-(void)el_onLeftNavBarTap{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)o_configDatas{
    self.dataArray = @[
                           @{@"name":@"手机号",
                             @"place":@"请输入手机号",
                             @"xib":@"ELRegisterCell"},
                           @{@"name":@"验证码",
                             @"place":@"请输入验证码",
                             @"xib":@"ELCodeCell"}
                           ];
    
    
}

-(void)o_configViews{
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = EL_BackGroundColor;
    _footerView = [[ELNextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    _footerView.tipLabel.hidden = YES;
    [_footerView.okBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
    if (indexPath.row==1) {
        ELCodeCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ELCodeCell" owner:self options:nil]lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        
        
        NSDictionary *dic = self.dataArray[indexPath.row];
        cell.leftLabel.text = dic[@"name"];
        cell.rightTextField.placeholder = dic[@"place"];
        cell.rightTextField.delegate = self;
        [cell.codeButton addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        _twoCell = cell;
        return cell;
        
    }else{
        ELRegisterCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"ELRegisterCell" owner:self options:nil]lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        
        
        NSDictionary *dic = self.dataArray[indexPath.row];
        cell.leftLabel.text = dic[@"name"];
        cell.rightTextField.placeholder = dic[@"place"];
        cell.rightTextField.delegate = self;
        _oneCell = cell;
        return cell;
        
    }
}



-(void)touchWithBtn:(UIButton *)btn{
    if (btn==_footerView.okBtn) {
        NSLog(@"下一步按下");

        if (_oneCell.rightTextField.text.length==0) {
            [self showCustomHudSingleLine:@"请输入手机号"];
            return;
        }
        if (![DBHandel isValidateMobile:_oneCell.rightTextField.text]) {
            [self showCustomHudSingleLine:@"请输入合法手机号"];
            return;
        }
        if (_twoCell.rightTextField.text.length==0) {
            [self showCustomHudSingleLine:@"请输入验证码"];
            return;
        }
        if (_twoCell.rightTextField.text.length!=0 && ![_twoCell.rightTextField.text isEqualToString:_msgModel.code]) {
            [self showCustomHudSingleLine:@"验证码输入有误"];
            return;
        }
        /*        code = 698763;
         sessionId = DFCA05DEEC6F4B22F3CA25ABA9F2A92D;*/
        [DBRegService checkForgetCodeWithPhone:_oneCell.rightTextField.text sessionId:_msgModel.sessionId captch:_msgModel.code block:^(BOOL success, id result) {
            if (success) {
                ELForgetTwoViewController *two = [[ELForgetTwoViewController alloc]init];
                two.phone = _oneCell.rightTextField.text;
                [self.navigationController pushViewController:two animated:YES];
            }else{
                [self showCustomHudSingleLine:result];
            }
        }];
        


        
        

    }

    if (btn==_twoCell.codeButton) {
        NSLog(@"验证码按下");
        
        if (btn && [DBHandel isValidateMobile:_oneCell.rightTextField.text]) {
            
            if (_timer==nil) {
                _index = TimeInterval;
                
                [DBRegService sendForgetPasswordMsgWithPhone:_oneCell.rightTextField.text block:^(BOOL success, id result) {
                    if (success) {
                        //获取到验证码成功
                        _twoCell.codeButton.userInteractionEnabled  = NO;
                        _oneCell.rightTextField.userInteractionEnabled = NO;
                        [_oneCell.rightTextField resignFirstResponder];
                        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(btnTitleRefresh) userInfo:nil repeats:YES];
                        
                        _twoCell.codeLabel.text = [NSString stringWithFormat:@"%lu秒后重新发送",(long)_index];
                        
                        _msgModel = [DBMsgModel mj_objectWithKeyValues:result];
                        NSLog(@"%@",_msgModel);
                        [self showCustomHudSingleLine:@"短信发送成功"];

                    }else{
                        //获取到验证码失败
                        [self showCustomHudSingleLine:result];
                    }
                }];
                
//                [DBRegService sendRegMsgWithPhoneNumber:_oneCell.rightTextField.text block:^(BOOL success, id result) {
//                    if (success) {
//                        //获取到验证码成功
//                        _twoCell.codeButton.userInteractionEnabled  = NO;
//                        _oneCell.rightTextField.userInteractionEnabled = NO;
//                        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(btnTitleRefresh) userInfo:nil repeats:YES];
//                        
//                        _twoCell.codeLabel.text = [NSString stringWithFormat:@"%lu秒后重新发送",_index];
//                        
//                        _msgModel = [DBMsgModel mj_objectWithKeyValues:result];
//                        NSLog(@"%@",_msgModel);
//                    }else{
//                        //获取到验证码失败
//                        [self showCustomHudSingleLine:result];
//                    }
//                }];
                
                
            }
        }else{
            
            [self showCustomHudSingleLine:@"请输入正确的手机号"];
        }

        
        
        

        
    }
    
}

-(BOOL)isOkreq{
    
    return YES;
}




//定时刷新
-(void)btnTitleRefresh{
    _index--;
    if (_index==0) {
        _twoCell.codeLabel.text = @"点击获取验证码";
        _twoCell.codeButton.userInteractionEnabled = YES;
        _oneCell.rightTextField.userInteractionEnabled = YES;
        [_timer invalidate];
        _index = TimeInterval;
        _timer = nil;
    }else{
        _twoCell.codeLabel.text = [NSString stringWithFormat:@"%lu秒后重新发送",(long)_index];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==_oneCell.rightTextField) {
        [_twoCell.rightTextField becomeFirstResponder];
    }
    
    return YES;
}



@end
