//
//  DBTuikuanViewController.m
//  Ji
//
//  Created by ssgm on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBTuikuanViewController.h"
#import "ELRegisterCell.h"//借用注册的cell
#import "DBTuikuanLabelCellTableViewCell.h"
#import "ELNextView.h"//借用下一步的cell
#import "DBMineService.h"
@interface DBTuikuanViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    ELRegisterCell *_oneCell;
    DBTuikuanLabelCellTableViewCell *_twoCell;
    ELRegisterCell *_thrCell;
    ELRegisterCell *_forCell;
    NSString *_reason;
    ELNextView *_footerView;
    NSString *_btnText;
}
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITableView *table;
@end

@implementation DBTuikuanViewController
/*
 * 这个是点击申请售后进入的提交申请的页面
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款/售后";
    _btnText = @"缺货";
    _reason = @"1";
    
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)el_onLeftNavBarTap{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)o_configDatas{
    self.dataArray = @[
                       @{@"name":@"申请服务",
                         @"place":@"退款",
                         },
                       @{@"name":@"退款原因",
                         @"place":@"缺货",
                         },
                       @{@"name":@"退款金额",
                         @"place":@"输入金额",
                         },
                       @{@"name":@"退款说明",
                         @"place":@"请输入退款说明",
                         }
                       ];

}

-(void)o_configViews{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = EL_BackGroundColor;
    [self.view addSubview:self.table];
    _footerView = [[ELNextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    [_footerView.okBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    _footerView.tipLabel.hidden = YES;
    [_footerView.okBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    self.table.tableFooterView = _footerView;
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.table addGestureRecognizer:tableViewGesture];
    

    
}
- (void)tableViewTouchInSide{
    [_oneCell.rightTextField resignFirstResponder];
    [_forCell.rightTextField resignFirstResponder];
    [_thrCell.rightTextField resignFirstResponder];
}
//设置每个分区有多少行
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
//设置每一行显示的内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==1) {
        DBTuikuanLabelCellTableViewCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"DBTuikuanLabelCellTableViewCell" owner:self options:nil]lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        _twoCell = cell;
        [_twoCell.rightBtn setTitle:_btnText forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        ELRegisterCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"ELRegisterCell" owner:self options:nil]lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        
        
        NSDictionary *dic = self.dataArray[indexPath.row];
        cell.leftLabel.text = dic[@"name"];
        cell.rightTextField.placeholder = dic[@"place"];
        cell.rightTextField.delegate = self;
        if (indexPath.row==0) {
            _oneCell = cell;
            _oneCell.userInteractionEnabled = NO;
        }
        if (indexPath.row==2){
            NSString *priceStr = [NSString stringWithFormat:@"%.2f",self.good.goodsPayPrice];

            cell.rightTextField.text = DBPRICE(priceStr);
            _thrCell = cell;
        }
        if (indexPath.row==3) {
            _forCell = cell;
        }
            return cell;
    }
    
}


-(void)btn:(UIButton*)btn{
    [self alert];
}

-(void)reloadCell{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}
-(void)touchWithBtn:(UIButton *)btn{
    
    
    if (btn==_footerView.okBtn) {
        NSLog(@"退货申请按下");
        NSString *applyService;
        if (self.order.state==3 || self.order.state==4 ) {
            applyService = @"1";
        }
        if (self.order.state==5) {
            applyService = @"2";

        }
        
        
        [DBMineService saveRefundWithUid:UidStr orderId:integerToString(self.order.orderId) refundNo:@"" refundPrice:_thrCell.rightTextField.text applyService:applyService reason:_reason description:_forCell.rightTextField.text orderGoodsId:integerToString(self.good.id) orderStatus:integerToString(self.order.state) block:^(BOOL success, id result) {
            if (success) {
                //退货提交成功
                [self showCustomHudSingleLine:@"申请成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==_thrCell.rightTextField) {
        [_forCell.rightTextField becomeFirstResponder];
    }

    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row!=1) {
        return;
    }
    [self alert];
    
}
-(void)alert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择退货原因" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *a = [UIAlertAction actionWithTitle:@"缺货" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _btnText = @"缺货";
        _reason = @"1";
        
        [self reloadCell];
    }];
    UIAlertAction *b = [UIAlertAction actionWithTitle:@"协调一致退款" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _btnText = @"协调一致退款";
        _reason = @"2";
        
        [self reloadCell];
    }];
    UIAlertAction *c = [UIAlertAction actionWithTitle:@"未按时间发货" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _btnText = @"未按时间发货";
        _reason = @"3";
        
        [self reloadCell];
    }];
    UIAlertAction *d = [UIAlertAction actionWithTitle:@"拍错/多拍/不想要" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _btnText = @"拍错/多拍/不想要";
        _reason = @"4";
        
        [self reloadCell];
    }];
    UIAlertAction *e = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _btnText = @"其他";
        _reason = @"5";
        
        [self reloadCell];
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:a];
    [alertController addAction:b];
    [alertController addAction:c];
    [alertController addAction:d];
    [alertController addAction:e];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_oneCell.rightTextField resignFirstResponder];
    [_forCell.rightTextField resignFirstResponder];
    [_thrCell.rightTextField resignFirstResponder];
    
}


@end
