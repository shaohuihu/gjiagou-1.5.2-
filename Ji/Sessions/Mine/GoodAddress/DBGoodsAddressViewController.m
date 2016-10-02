//
//  DBGoodsAddressViewController.m
//  Ji
//
//  Created by sbq on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBGoodsAddressViewController.h"
#import "DBNodataView.h"
#import "DBAddressCellTableViewCell.h"
#import "DBAddGoodsViewController.h"
#import "DBMineService.h"
#import "AddressListModel.h"
#import "DBEditViewController.h"
#define Icon_Checked  [UIImage imageNamed:@"ic_checked"]
#define Icon_UnChecked  [UIImage imageNamed:@"ic_unchecked"]



@interface DBGoodsAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_table;
    UIButton *_addBtn;
    DBNodataView *_noGoodsView;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation DBGoodsAddressViewController

-(void)o_load{

    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    //[self setHidesBottomBarWhenPushed:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    self.title = @"地址管理";
}
-(void)o_configDatas{
 
}
-(void)o_viewAppear{
    [DBMineService accAddressWithUid:UidStr block:^(BOOL success, id result) {
        if (success) {
            NSArray *array = result[@"addressList"];
            self.dataArray =[AddressListModel mj_objectArrayWithKeyValuesArray:array];
            
            [_table reloadData];
            if (self.dataArray.count==0) {
                [self nodata:YES];
            }else{
                [self nodata:NO];
            }
            
        }else{
            [self nodata:YES];
            [self.view el_makeToast:result];
        }
    }];
}
-(void)nodata:(BOOL)nodata{
    if (nodata) {
        _noGoodsView.hidden = NO;
        _addBtn.hidden = YES;
        _table.hidden = YES;
    }else{
        _noGoodsView.hidden = YES;
        _addBtn.hidden = NO;
        _table.hidden = NO;
    }
}
-(void)o_configViews{

    _noGoodsView = [DBNodataView new];
    [_noGoodsView setImage:@"ic_no_goods" andUpLabel:@"您还没有添加过收货地址！" andDownLabel:@"正确填写常用收货地址方便购物！" andBtn:@"添加新地址"];
    [self.view addSubview:_noGoodsView];
    
    WS(ws);
    _noGoodsView.addClickBlock = ^(UIButton*btn){
        NSLog(@"暂无地址，添加按下");
    
        DBAddGoodsViewController *addvc = [[DBAddGoodsViewController alloc]init];
        [ws.navigationController pushViewController:addvc animated:YES];
    };
    
    [_noGoodsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(1);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_HEIGHT-65);
    }];
    
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kRadioValue(35))style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    [self.view addSubview:_table];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(0, CGRectGetMaxY(_table.frame), SCREEN_WIDTH, kRadioValue(35));
    [_addBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [_addBtn setBackgroundColor:EL_MainColor];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DBAddressCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addresscell"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DBAddressCellTableViewCell" owner:self options:nil]lastObject];
        
        [cell.customView.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.custom2View.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.iconBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];


        
    }
    cell.customView.btn.tag = 1000+indexPath.section;
    cell.custom2View.btn.tag = 2000+indexPath.section;
    cell.iconBtn.tag = 3000+indexPath.section;
    cell.selectBtn.tag = 4000+indexPath.section;
    
    AddressListModel *model = self.dataArray[indexPath.section];
    
    [cell setData:model];
    
    return cell;
}

//触发
-(void)btnClick:(UIButton*)btn{

    if (btn==_addBtn) {
        NSLog(@"添加按下");
        DBAddGoodsViewController *add = [[DBAddGoodsViewController alloc]init];
        [self.navigationController pushViewController:add animated:YES];
        return;
    }

    if (btn.tag>=1000 && btn.tag<2000) {
        NSLog(@"第%ld个编辑按下",(long)(btn.tag-1000));
        AddressListModel *model = self.dataArray[btn.tag-1000];
        //编辑
        
        DBEditViewController *vc = [[DBEditViewController alloc]init];
        vc.aid = model.addressId;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (btn.tag>=2000 && btn.tag<3000) {
        AddressListModel *model = self.dataArray[btn.tag-2000];
        
        NSLog(@"第%ld个删除按下",(long)(btn.tag-2000));
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
   
        }];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [DBMineService deleteAddressWithId:integerToString(model.addressId) block:^(BOOL success, id result) {
                if (success) {
                    [self.view el_makeToast:@"删除成功"];
                    
                    [self.dataArray removeObjectAtIndex:btn.tag-2000];
                    [_table deleteSections:[NSIndexSet indexSetWithIndex:btn.tag-2000] withRowAnimation:UITableViewRowAnimationAutomatic];
                }else{
                    [self.view el_makeToast:result];
                }
                
            }];
            
        }];
        [alert addAction:cancel];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    if (btn.tag>=3000 && btn.tag<4000) {
        NSLog(@"第%ld个选择按下",(long)btn.tag-3000);
        for (NSInteger i = 0; i<self.dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            DBAddressCellTableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
            if (cell.iconBtn==btn) {

                AddressListModel *model = self.dataArray[indexPath.section];
                [DBMineService updateAddressDefaultWithAid:integerToString(model.addressId) block:^(BOOL success, id result) {
                    if (success) {
                        cell.iconImageView.image = Icon_Checked;
                        cell.defaultLabel.hidden = NO;
                    }else{
                        [self.view el_makeToast:result];
                    }
                }];

            }else{
                cell.iconImageView.image = Icon_UnChecked;
                cell.defaultLabel.hidden = YES;
            }
        }
        
        
    }
    
    if (btn.tag>=4000) {
        if (!self.notSelect) {
            AddressListModel *model = self.dataArray[btn.tag-4000];
            if (self.selectBlock) {
                self.selectBlock(model);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

//与设为默认删除的手势冲突
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    AddressListModel *model = self.dataArray[indexPath.section];
//    if (self.selectBlock) {
//        self.selectBlock(model);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
