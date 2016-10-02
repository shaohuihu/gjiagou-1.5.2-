//
//  ELgooViewController.m
//  Ji
//
//  Created by 龙讯科技 on 16/9/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELgooViewController.h"

@interface ELgooViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * tableView;
}
//@property(nonatomic,strong)NSArray * dataS;
//@property(nonatomic, strong)NSMutableArray *rowInSectionArray;//section中的cell个数
@end

@implementation ELgooViewController


//-(void)viewWillAppear:(BOOL)animated{
//    
//     _rowInSectionArray = [NSMutableArray arrayWithObjects:@"0",@"2",@"6", nil];//每个分区中cell的个数
//    DDLog(@"数据%@",_turn_sn);
//    DDLog(@"我的数据%@",_turn_amount);
//    NSMutableString * order_snS=[_turn_sn objectAtIndex:0];
//    // NSString * order_snS=@"1473068318847";
//    //NSNumber * order_amountS=[_turn_amount objectAtIndex:0];
//    NSNumber * order_am=[_turn_amount objectAtIndex:0];
//    NSString *order_amountS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];
//    // NSString * order_amountS=@"179";
//    DDLog(@"这是%@",order_snS);
//    DDLog(@"woyaoshu%@",order_amountS);
//    NSString * orderS=@"订单编号";
//    NSString * allOrder=[NSString stringWithFormat:@"%@:%@",orderS,order_snS];
//    NSString * amountS=@"支付金额";
//    NSString * strign1=@"￥";
//    NSString *pricS=[NSString stringWithFormat:@"%@%@",strign1,order_amountS];
//    NSString * string=[NSString stringWithFormat:@"%@:%@",amountS,pricS];
//    DDLog(@"数据持久化%@",allOrder);
//    DDLog(@"价格%@",string);
//    _dataS = @[
//               @[
//                   @{
//                       @"title":@"请选择订单及时付款，以便尽快处理!",
//                       
//                       @"subTitle":@"",
//                       @"cellClass":@"ELPromptCell"
//                       }
//                   ],
//               @[
//                   @{
//                       @"title":@"111111",
//                       
//                       @"subTitle":@"33333",
//                       @"cellClass":@"ELChooseCell"
//                       }
//                   ],
//               @[
//                   
//                   
//                   
//                   @{
//                       @"title":@"支付方式选择",
//                       @"subTitle":@"",
//                       @"cellClass":@"ELChooseCell"
//                       },
//                   @{
//                       @"title":@"支付宝支付",
//                       @"subTitle":@"",
//                       @"cellClass":@"ELSpecificCell"
//                       },
//                   @{
//                       @"title":@"微信支付",
//                       @"subTitle":@"",
//                       @"cellClass":@"ELSpecificCell"
//                       },
//                   @{
//                       @"title":@"农商银行支付",
//                       @"subTitle":@"",
//                       @"cellClass":@"ELSpecificCell"
//                       },
//                   
//                   @{
//                       @"title":@"捷信分期支付",
//                       @"subTitle":@"",
//                       @"cellClass":@"ELSpecificCell"
//                       },
//                   @{
//                       @"title":@"温馨提示：选择分期暂不支持部分退款、退货",
//                       @"subTitle":@"",
//                       @"cellClass":@"ELPromptCell"
//                       },
//                   
//                   
//                   
//                   
//                   
//                   ],
//               
//               ];
//    
//    
//    
//}
//
//

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIView * baView=[[UIView alloc]init];
//    baView.backgroundColor=[UIColor whiteColor];
//    //baView.backgroundColor=EL_BackGroundColor;
//    baView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
//    [self.view addSubview:baView];
//    UIButton * backB=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    backB.frame=CGRectMake(10, 20, 10, 20);
//    [backB setBackgroundImage:[UIImage imageNamed:@"ic_back_button"] forState:UIControlStateNormal];
//    [backB addTarget:self action:@selector(doback) forControlEvents:UIControlEventTouchUpInside];
//    [baView addSubview:backB];
//    
//    UILabel * label=[[UILabel alloc]init];
//    label.frame=CGRectMake(100, 25, 120, 10);
//    label.text=@"支付方式选择";
//    [baView addSubview:label];
//    
//    //设置表视图
//  tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 400) style:UITableViewStyleGrouped];
//    tableView.delegate=self;
//    tableView.dataSource=self;
//    //tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    
//    tableView.estimatedRowHeight=44;
//    [tableView registerClasses:@[@"ELCheckoutBottomCell",@"ELChooseCell",@"ELSpecificCell",@"ELPromptCell"]];
//    //[self.view addSubview:self.tableView=tableView];
//    
//    [self.view addSubview:tableView];
//    
//    
//    
//    NSArray * subViews=[self.view subviews];
//    DDLog(@"这是我最新的%@",subViews);
//    
//    //设置最底部的View
//    UIView * bottomV=[[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, [UIScreen mainScreen].bounds.size.width, 44)];
//    bottomV.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:bottomV];
//    //设置总计的label
//    UILabel * Plabel=[[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-44 , 50, 44)];
//    //self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price.doubleValue];
//    
//    NSString * string1=@"总计:";
//    
//    Plabel.text =string1;
//    NSString * strign2=@"￥";
//    
//    
//    [self.view   addSubview:Plabel];
//    //设置价格
//    UILabel * Mlabel=[[UILabel alloc]initWithFrame:CGRectMake(50,[UIScreen mainScreen].bounds.size.height-44 , 50, 44)];
//    //self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price.doubleValue];
//    ;
//    // NSMutableString* order_amountS=[_turn_amount objectAtIndex:0];
//    
//    Mlabel.textColor=[UIColor redColor];
//    NSNumber * order_am=[_turn_amount objectAtIndex:0];
//    NSString *order_amountS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];
//    NSString *pricS=[NSString stringWithFormat:@"%@%@",strign2,order_amountS];
//    Mlabel.text =pricS;
//    
//    [self.view   addSubview:Mlabel];
//    //设置按钮
//    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height-44 , 100, 44) ;
//    button.backgroundColor=[UIColor redColor];
//    [button setTitle:@"支付" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(doPay) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    
//}
//
//#pragma mark cell的内容
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *identifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//    cell.textLabel.text = _dataS[indexPath.section];
//    return cell;
//}

#pragma mark cell的行数
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
//    if ([_dataS[section] isEqualToString:@"1"]) {
//        return [_rowInSectionArray[section]integerValue];
//    }
//    return 0;
//}
#pragma mark section的个数
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _dataS.count;
//}
//
#pragma cell的高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}

#pragma mark - section内容
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //每个section上面有一个button,给button一个tag值,用于在点击事件中改变_selectedArray[button.tag - 1000]的值
//    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
//    sectionView.backgroundColor = [UIColor cyanColor];
//    UIButton *sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sectionButton.frame = sectionView.frame;
//    [sectionButton setTitle:[_dataS objectAtIndex:section] forState:UIControlStateNormal];
//    [sectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    sectionButton.tag = 1000 + section;
//    [sectionView addSubview:sectionButton];
//    return sectionView;
//}
//#pragma mark button点击方法
//-(void)buttonAction:(UIButton *)button
//{
//    if ([_dataS[button.tag - 1000] isEqualToString:@"0"]) {
//        
//        //                for (NSInteger i = 0; i < _sectionArray.count; i++) {
//        //                    [_selectedArray replaceObjectAtIndex:i withObject:@"0"];
//        //                    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationFade];
//        //                }
//        
//        
//        //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
//       
//    }
//    else
//    {
//        //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
//               [tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
//



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
