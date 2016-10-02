//
//  DBModifyPhoneTwoViewController.m
//  Ji
//
//  Created by ssgm on 16/6/16.
//  Copyright © 2016年 evol. All rights reserved.
//


#import "DBModifyPhoneTwoViewController.h"
#import "DBModifyPhoneOneViewController.h"
#import "ELForgetTwoViewController.h"
#import "ELNextView.h"
#import "ELRegisterCell.h"
#import "DBMsgModel.h"
#import "DBHandel.h"
#import "DBRegService.h"
@interface DBModifyPhoneTwoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    ELRegisterCell *_oneCell;
    ELNextView *_footerView;
    DBMsgModel *_msgModel;
    NSInteger _index;
}
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITableView *table;

@end

@implementation DBModifyPhoneTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改手机";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
}
-(void)el_onLeftNavBarTap{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)o_configDatas{
    self.dataArray = @[
                       @{@"name":@"手机号",
                         @"place":@"新手机号",
                         @"xib":@"ELRegisterCell"},
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
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.table addGestureRecognizer:tableViewGesture];
    
    _footerView = [[ELNextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    _footerView.tipLabel.hidden = YES;
    [_footerView.okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_footerView.okBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.table.tableFooterView = _footerView;
    
    
    WS(ws);
    [self.table makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(ws.view);
    }];
    
    
}

- (void)tableViewTouchInSide{
    [_oneCell.rightTextField resignFirstResponder];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    UILabel *tip = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    tip.text = @"请输入新手机号";
    [bgView addSubview:tip];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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



-(void)touchWithBtn:(UIButton *)btn{
    if (btn==_footerView.okBtn) {
        NSLog(@"ok按下");
        
        if (_oneCell.rightTextField.text.length==0) {
            [self showCustomHudSingleLine:@"请输入手机号"];
            return;
        }
        if (![DBHandel isValidateMobile:_oneCell.rightTextField.text]) {
            [self showCustomHudSingleLine:@"请输入合法手机号"];
            return;
        }
        [DBRegService signupPhoneWithPhoneNumber:_oneCell.rightTextField.text block:^(BOOL success, id result) {
            if (success) {
                DBModifyPhoneOneViewController *vc = [[DBModifyPhoneOneViewController alloc]init];
                vc.s_newPhone = _oneCell.rightTextField.text;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该手机号已被其他手机绑定，请选择其他手机号绑定！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

-(BOOL)isOkreq{
    
    return YES;
}






-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
     return YES;
}



@end
