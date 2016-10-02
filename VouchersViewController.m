//
//  VouchersViewController.m
//  Ji
//
//  Created by 龙讯科技 on 16/8/16.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "VouchersViewController.h"
#import "VouModel.h"
#import "vouCell.h"
#import "ELMainService.h"
#import "MBProgressHUD+LHP.m"
@interface VouchersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * modelArray;

@end

@implementation VouchersViewController

-(NSArray *)modelArray{
    if (!_modelArray) {
        NSMutableArray * models=[NSMutableArray array];
        for (NSDictionary * dic in _temArray) {
            VouModel *model=[VouModel tgModelWithDic:dic];
            [models addObject:model];
            
        }
        _modelArray=models;
    }
    return _modelArray;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"代金券";
    
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    

    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    UITableView * tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    
    //设置表视图的代理
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=145;
    if (![_temArray isEqual:[NSNull null]]) {
        [self.view addSubview:tableView];
    }
    else if ([_temArray isEqual:[NSNull null]]){
         
  
        
    }

  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   //return self.modelArray.count;
    if (![_temArray isEqual:[NSNull null]]) {
        return self.modelArray.count;
    }
    else{
        return 0;
    }

   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    vouCell *cell=[vouCell cellWithTableView:tableView];
//    VouModel * model=self.modelArray[indexPath.row];
//    cell.model=model;
//    return cell;
    
    if (![_temArray isEqual:[NSNull null]]) {
        vouCell *cell =[vouCell cellWithTableView:tableView];
        VouModel * model=self.modelArray[indexPath.row];
        cell.model=model;
        return cell;
        
    }
    else{
        return nil;
    }

    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
