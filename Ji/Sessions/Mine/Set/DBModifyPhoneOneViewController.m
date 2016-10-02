//
//  DBModifyPhoneOneViewController.m
//  Ji
//
//  Created by ssgm on 16/6/16.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBModifyPhoneOneViewController.h"
#import "DBModifyPhoneTwoViewController.h"
#import "ELForgetTwoViewController.h"
#import "ELNextView.h"
#import "ELCodeCell.h"
#import "DBModifyPhoneTopCell.h"
#import "DBMsgModel.h"
#import "DBHandel.h"
#import "DBRegService.h"
#import "DBMineService.h"
@interface DBModifyPhoneOneViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    DBModifyPhoneTopCell *_oneCell;
    ELCodeCell *_twoCell;
    ELNextView *_footerView;
    DBMsgModel *_msgModel;
    NSTimer *_timer;
    NSInteger _index;
}
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITableView *table;
@end

@implementation DBModifyPhoneOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全校验";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
}
-(void)el_onLeftNavBarTap{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)o_configDatas{
    self.dataArray = @[
                       @{@"name":@"",
                         @"place":@"",
                         @"xib":@""},
                       @{@"name":@"校验码",
                         @"place":@"请输入校验码",
                         @"xib":@"ELCodeCell"}
                       ];

}

-(void)o_configViews{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = EL_BackGroundColor;
    self.table.estimatedRowHeight = 44;
    self.table.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.table];
    _footerView = [[ELNextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    _footerView.tipLabel.hidden = YES;
    [_footerView.okBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (self.s_newPhone.length>0) {
        [_footerView.okBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    self.table.tableFooterView = _footerView;
    
    WS(ws);
    [self.table makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(ws.view);
    }];
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.table addGestureRecognizer:tableViewGesture];
    
    
    DBModifyPhoneTopCell *onecell =[[DBModifyPhoneTopCell alloc]init];
    onecell.contentView.backgroundColor = [UIColor whiteColor];
    onecell.backgroundColor = [UIColor whiteColor];
    onecell.phoneLabel.text = [self getText];
    _oneCell = onecell;
    
    
    ELCodeCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ELCodeCell" owner:self options:nil]lastObject];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = self.dataArray[1];
    cell.codeLabel.text =  @"点击获取校验码";
    cell.leftLabel.text = dic[@"name"];
    cell.rightTextField.placeholder = dic[@"place"];
    cell.rightTextField.delegate = self;
    [cell.codeButton addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    _twoCell = cell;
    
}



- (void)tableViewTouchInSide{
    [_twoCell.rightTextField resignFirstResponder];
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
    if (indexPath.row==0) {
        return _oneCell;
    }else{
        return _twoCell;
    }
}



-(void)touchWithBtn:(UIButton *)btn{
    if (btn==_footerView.okBtn) {
        NSLog(@"下一步按下");
        if (_twoCell.rightTextField.text.length==0) {
            [self showCustomHudSingleLine:@"请输入校验码"];
            return;
        }
        if (_twoCell.rightTextField.text.length!=0 && ![_twoCell.rightTextField.text isEqualToString:_msgModel.code]) {
            [self showCustomHudSingleLine:@"校验码输入有误"];
            return;
        }
        /*        code = 698763;
         sessionId = DFCA05DEEC6F4B22F3CA25ABA9F2A92D;*/
//        [DBRegService checkForgetCodeWithPhone:_oneCell.rightTextField.text sessionId:_msgModel.sessionId captch:_msgModel.code block:^(BOOL success, id result) {
//            if (success) {
//                ELForgetTwoViewController *two = [[ELForgetTwoViewController alloc]init];
//                two.phone = _oneCell.rightTextField.text;
//                [self.navigationController pushViewController:two animated:YES];
//            }else{
//                [self showCustomHudSingleLine:result];
//            }
//        }];
        if (self.s_newPhone.length==0) {
            //下一步
            DBModifyPhoneTwoViewController *_two = [[DBModifyPhoneTwoViewController alloc]init];
            [self.navigationController pushViewController:_two animated:YES];
        }else{
            //保存修改
            [DBMineService updateMobleWithUid:UidStr phone:self.s_newPhone block:^(BOOL success, id result) {
                if (success) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [self showCustomHudSingleLine:@"新手机号也可以登录"];
                }else{
                    [self showCustomHudSingleLine:result];
                }
            }];
        
        }
    }
    
    if (btn==_twoCell.codeButton) {
        NSLog(@"校验码按下");
        
        if (btn ) {
            if (_timer==nil) {
                _index = TimeInterval;
                [DBMineService bindMobileWithPhone:[self getMobile] block:^(BOOL success, id result) {
                    if (success) {
                            //获取到验证码成功
                            _twoCell.codeButton.userInteractionEnabled  = NO;
                            _oneCell.tipLabel.text = @"已经发送校验码到您手机";
                            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(btnTitleRefresh) userInfo:nil repeats:YES];
    
                            _twoCell.codeLabel.text = [NSString stringWithFormat:@"%lu秒后重新发送",(long)_index];
    
                            _msgModel = [DBMsgModel mj_objectWithKeyValues:result];
                            NSLog(@"%@",_msgModel);
                            [self showCustomHudSingleLine:@"校验码发送成功"];
                            
                        }else{
                            //获取到验证码失败
                            [self showCustomHudSingleLine:result];
                        }

                }];
                
            }
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
        _twoCell.codeLabel.text = @"点击获取校验码";
        _twoCell.codeButton.userInteractionEnabled = YES;
        [_timer invalidate];
        _index = TimeInterval;
        _timer = nil;
    }else{
        _twoCell.codeLabel.text = [NSString stringWithFormat:@"%lu秒后重新发送",(long)_index];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

-(NSString*)getText{
    if (self.s_newPhone.length==11) {
        return  [DBHandel xxxCodePhone:self.s_newPhone];
    }
    if (self.s_newPhone.length==0) {
        NSString *mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return   [DBHandel xxxCodePhone:mobile];
    }
    return @"";
}
-(NSString*)getMobile
{
    if (self.s_newPhone.length==11) {
        return self.s_newPhone;
    }else{
        NSString *mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
        if (mobile.length==11) {
            return mobile;
        }else{
            return @"";
        }
    }

}
@end

