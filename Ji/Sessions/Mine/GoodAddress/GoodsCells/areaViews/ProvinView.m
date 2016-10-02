//
//  ProvinView.m
//  KeGoal
//
//  Created by sbq on 15/8/28.
//  Copyright (c) 2015年 sbq. All rights reserved.
//

#import "ProvinView.h"
#import "ProvinceCell.h"
#import "CityListModel.h"
#import "DBMineService.h"
@implementation ProvinView

-(id)initWithFrame:(CGRect)frame andArray:(NSArray*)array{
    
    if (self = [super initWithFrame:frame]) {
        self.dataArray = array;
        [self createNav];
        [self createTab];
    }
    return self;
}

-(void)createNav{
    //题目
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.2, 0, self.bounds.size.width*0.8, 44)];
    self.titleLabel.text  =@"选择城市";
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelBtn.frame = CGRectMake(SCREEN_WIDTH-60, 0, 60, 44);
    [self.cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    //返回
    self.backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.backBtn.frame = CGRectMake(self.bounds.size.width*0.2, 0, 60, 44);
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backBtn];
    
    
}
-(void)createTab{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, self.titleLabel.frame.size.height, self.bounds.size.width, self.bounds.size.height-44) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.table];
    
}
-(void)cancelBtnClick:(UIButton*)btn{
    if (btn) {
        
        [self viewDisAppearShowly];
    }
}
-(void)backBtnClick:(UIButton*)backBtn{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)viewDisAppearShowly{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBA(40, 40, 40, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }];
}


#pragma mark---代理区

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProvinceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"procell"];
    if (cell==nil) {
        if (SCREEN_WIDTH==414) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProvinceCell" owner:self options:nil]lastObject];
        }else{
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProvinceCell" owner:self options:nil]firstObject];
        }
    }
    CityListModel *model = self.dataArray[indexPath.row];
    NSString *proString = model.name;
    if (![proString isKindOfClass:[NSNull class]]) {
        cell.nameLabel.text  = proString;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (SCREEN_WIDTH==414) {
        return 50;
        
    }else{
        
        return 44;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //拿到id 去请求数据获得城市
    CityListModel *model = self.dataArray[indexPath.row];

    [DBMineService regionWithParentId:integerToString(model.id) block:^(BOOL success, id result) {
        if (success) {
            NSArray *areaList = [CityListModel mj_objectArrayWithKeyValuesArray:result[@"regions"]];
            self.cityView = [[CityView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, self.table.frame.size.width, self.frame.size.height)andArray:areaList];
            [self addSubview:self.cityView];
            self.cityView.countryName = self.countryName;
            self.cityView.countryId = self.countryId;

            self.cityView.provinceName = model.name;
            self.cityView.provinceId = integerToString(model.id);
            
            //出现
            [UIView animateWithDuration:0.5 animations:^{
                self.cityView.frame = CGRectMake(0, 0, self.table.frame.size.width, self.frame.size.height);
            } completion:^(BOOL finished) {
            }];
            
            
        }
    }];

    
        
}



@end
