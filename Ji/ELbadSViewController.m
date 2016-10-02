//
//  ELbadSViewController.m
//  Ji
//
//  Created by 龙讯科技 on 16/9/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELbadSViewController.h"
#import "ELShopService.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiManager.h"
#import "WXApiManager.h"
#import "AFNetworking.h"
#import "JieViewController.h"
#import "ELGoodDetailController.h"
#import "ELCheckoutBottomView.h"
#import "ChoosePayBottomView.h"
#import "DBAllOrderViewController.h"
@interface ELbadSViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSDictionary * dict;
    UIButton * showBTNZ;
    UIButton * showBTNW;
    UIButton * showBTNN;
    UIButton * showBTNJ;
    int iZ;
    int iW;
    int iN;
    int iJ;
    
    int temZ;
    int temW;
    int temN;
    int temJ;
    int number;
    
    int iztag;
    int iwtag;
    int intag;
    int ijtag;
    int one;
    int buttonclick;
    
    CGFloat cellX;
    CGFloat cellY;
    CGFloat cellW;
    CGFloat cellH;
    CGPoint cellC;
    UITableView * tableView;
    UIView * Bview;
    UIButton * leftBTN;
    UIButton * rightBTN;
    UIImageView * zhiImageV;
    UIImageView * weImageV;
    UIImageView * jieImageV;
    UIImageView * nonImageV;
    NSString *order_amountS;//商品的价格
    ChoosePayBottomView  *bottomView;//全局的底部的view
    NSMutableString * order_snS;
    NSNumber * order_am;
    NSString * priceS;//最总价格
    UIView * bacV;
    UIView * backV;
    NSMutableArray * titleA;
    NSMutableArray * infoA;
    
 
}

@property(nonatomic,strong)NSArray * dataS;
//底部视图
@property (nonatomic, weak) ELCheckoutBottomView *bottomView;



@end

@implementation ELbadSViewController
static iZ=0;
static iW=0;
static iN=0;
static iJ=0;
static number=0;
static iztag=0;
static iwtag=0;
static intag=0;
static ijtag=0;
static one=0;
static buttonclick=0;
- (void)o_viewAppear{
  
        DDLog(@"支付方式选择goodID%ld",(long)self.goodID);
    UIImage* img=[UIImage imageNamed:@"ic_back_button"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame =CGRectMake(0, 0,11, 20);
    
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(doback) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=item;
    
order_snS=[_turn_sn objectAtIndex:0];
    
    order_am=[_turn_amount objectAtIndex:0];
    NSString *order_amountS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];
    // NSString * order_amountS=@"179";
    DDLog(@"这是%@",order_snS);
   // DDLog(@"woyaoshu%@",order_amountS);
    NSString * orderS=@"订单编号";
    NSString * allOrder=[NSString stringWithFormat:@"%@:%@",orderS,order_snS];
    NSString * amountS=@"支付金额";
    NSString * strign1=@"￥";
    NSString *pricS=[NSString stringWithFormat:@"%@%@",strign1,order_amountS];
    NSString * string=[NSString stringWithFormat:@"%@:%@",amountS,pricS];
    DDLog(@"数据持久化%@",allOrder);
    DDLog(@"价格%@",string);
//    _dataS = @[
//               @[
//                   
//                   
//                   @{
//                       @"title":@"请选择订单及时付款，以便尽快处理!",
//                       
//                       @"subTitle":@"",
//                       @"cellClass":@"ELPromptCell"
//                       },
//                   
//                   
//                   
//                   @{
//                       @"title":allOrder,
//                       
//                       @"subTitle":string,
//                       @"cellClass":@"ELChooseCell"
//                       },
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
    
    
    
    
    
    
    
  
    
#pragma mark-第一个分区
     NSMutableDictionary *mutableDic1=[NSMutableDictionary dictionaryWithObjects:@[@"请选择订单及时付款，以便尽快处理!",@"",@"ELPromptCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
    NSMutableArray * oneSection=[NSMutableArray array];
    [oneSection addObject:mutableDic1];
#pragma mark-第二个分区
    


         NSMutableDictionary *mutableDic2=[NSMutableDictionary dictionaryWithObjects:@[allOrder,string,@"ELChooseCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
        
        [oneSection addObject:mutableDic2];
  
#pragma mark-第二个分区
    NSMutableDictionary *mutableDic30=[NSMutableDictionary dictionaryWithObjects:@[@"支付方式选择",@"",@"ELChooseCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
    NSMutableDictionary *mutableDic31=[NSMutableDictionary dictionaryWithObjects:@[@"支付宝支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
     NSMutableDictionary *mutableDic32=[NSMutableDictionary dictionaryWithObjects:@[@"微信支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
    NSMutableDictionary *mutableDic33=[NSMutableDictionary dictionaryWithObjects:@[@"农商银行支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];

     NSMutableDictionary *mutableDic34=[NSMutableDictionary dictionaryWithObjects:@[@"捷信分期支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
     NSMutableDictionary *mutableDic35=[NSMutableDictionary dictionaryWithObjects:@[@"温馨提示：选择分期暂不支持部分退款、退货",@"",@"ELPromptCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
    
   
    [oneSection addObject:mutableDic30];
    [oneSection addObject:mutableDic31];
    [oneSection addObject:mutableDic32];
    [oneSection addObject:mutableDic33];
    [oneSection addObject:mutableDic34];
    [oneSection addObject:mutableDic35];
    
  
    _dataS=[NSMutableArray arrayWithObject:oneSection];
    DDLog(@"这个是我改之后的数据%@",_dataS);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



- (void)o_configViews{
//iOS重定向
    NSURL *url = [NSURL URLWithString:@"https://api-uat.homecredit.cn/morest/auth?z={0}"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!connection) {
        NSLog(@"FAIL");
    }

    
    
    self.title = @"支付方式选择";

    

    
    //设置表视图
    
  tableView   = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    

       //tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400) style:UITableViewStyleGrouped];
       tableView.delegate=self;
        tableView.dataSource=self;
        //tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
        tableView.estimatedRowHeight=44;
        [tableView registerClasses:@[@"ELCheckoutBottomCell",@"ELChooseCell",@"ELSpecificCell",@"ELPromptCell"]];
        //[self.view addSubview:self.tableView=tableView];
  
    [self.view addSubview:tableView];

    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-44);
        //  make.bottom.equalTo(ws.view).offset(-144);
        
        
    }];
    

    
    
    NSArray * subViews=[self.view subviews];
    DDLog(@"这是我最新的%@",subViews);
#pragma mark-这里设置下面的按钮
    NSNumber * order_am=[_turn_amount objectAtIndex:0];
    NSString * priS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];

   bottomView = [[ChoosePayBottomView  alloc] init];
    [bottomView setData:@{
                         
                          /***************这里面有我要改的地方**********************/
                          @"price":priS,
                        
                         
                          }];
    [bottomView setCheckoutBlock:^{
        [ws doPay];
    }];
    self.bottomView.tag=200;
    bottomView.tag=200;
    [self.view addSubview:self.bottomView = bottomView];
    
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.view);
        make.height.equalTo(44);
    }];
    self.bottomView.tag=200;
    
    
   
    
    
    

    
    
    
    
    
    
    
}
#pragma mark-UITableViewDelegate UITableViewDataSource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    DDLog(@"%lu",(unsigned long)_dataS.count);
//    return _dataS.count;
//    
//}
#pragma mark-这部分东西是
//每个有多少个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return _dataS.count;
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

//每个分区有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//注释的部分是原来的
    NSArray * array=_dataS[section];
    
    return  array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray * array=_dataS[0];
    dict=array[indexPath.row];
    
    
   
    
        ELRootCell *cell=[tableView dequeueReusableCellWithIdentifier:dict[@"cellClass"]];
        cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    //这个是支付方式
    if (indexPath.section==0 && indexPath.row==2){
        cell.backgroundColor=EL_BackGroundColor;
        
    }
    //这个是支付宝的方式
    if (indexPath.section==0 && indexPath.row==3) {
       
       cell.imageView.image=[UIImage imageNamed:@"ic_zhifubao"];
        
        zhiImageV=[[UIImageView alloc]init];
     
        zhiImageV.image=[UIImage imageNamed:@"ic_checked"];
        [cell.contentView addSubview:zhiImageV];

        [zhiImageV makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-13);
            make.centerY.equalTo(cell.contentView);
        }];
        
        
        
     

        
    }
    //这个是微信的支付方式
    else if (indexPath.section==0 && indexPath.row==4){
       cell.imageView.image=[UIImage imageNamed:@"ic_weixin-0"];
        weImageV=[[UIImageView alloc]init];
        weImageV.image=[UIImage imageNamed:@"ic_unchecked"];
        [cell.contentView addSubview:weImageV];

        [weImageV makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-13);
            make.centerY.equalTo(cell.contentView);
        }];
        
        
        
    }
    
    //这个是农商银行的支付方式
    else if (indexPath.section==0 && indexPath.row==5){

       cell.imageView.image=[UIImage imageNamed:@"ic_nongshang"];

        
        nonImageV=[[UIImageView alloc]init];
       nonImageV.image=[UIImage imageNamed:@"ic_unchecked"];
        [cell.contentView addSubview:nonImageV];

        [nonImageV makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-13);
            make.centerY.equalTo(cell.contentView);
        }];
        
    }//这个是捷信分期的
    else if (indexPath.section==0 &&indexPath.row==6)  {

        cell.imageView.image=[UIImage imageNamed:@"ic_jiexin"];
        jieImageV=[[UIImageView alloc]init];
        jieImageV.image=[UIImage imageNamed:@"ic_unchecked"];
        [cell.contentView addSubview:jieImageV];
        
        [jieImageV makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-13);
            make.centerY.equalTo(cell.contentView);
        }];


    }
    else if (indexPath.section==0 &&indexPath.row==1)  {

        cellX=cell.frame.origin.x;
        cellY=cell.frame.origin.y;
        cellW=cell.frame.size.width;
        cellH=cell.frame.size.height;
        cellC =cell.center;
        backV=[[UIView alloc]initWithFrame:CGRectMake(cellX, cellY+cellH*2+2, cellW, cellH*_turn_sn.count)];

        NSUserDefaults *getcishu=[NSUserDefaults standardUserDefaults];
        NSString * cishu=[getcishu objectForKey:@"cishu"];
        NSInteger cishuNI=[cishu integerValue];
        
        NSUserDefaults *getbuttonclick=[NSUserDefaults standardUserDefaults];
        NSString * getbutton=[getbuttonclick objectForKey:@"buttonClick"];
        NSInteger getbuttonNI=[getbutton integerValue];
        if (getbuttonNI==1) {
            backV=[[UIView alloc]initWithFrame:CGRectMake(cellX, cellY+cellH+2, cellW, cellH*_turn_sn.count)];
        }
//        if (cishuNI>1 || getbuttonNI==1) {
//            backV=[[UIView alloc]initWithFrame:CGRectMake(cellX, cellY+cellH+2, cellW, cellH*_turn_sn.count)];
//        else   {
//        
//        backV=[[UIView alloc]initWithFrame:CGRectMake(cellX, cellY+cellH*2+2, cellW, cellH*_turn_sn.count)];
//    
//        
//            
//        }
       // backV.backgroundColor=EL_BackGroundColor;
       // backV.backgroundColor=[UIColor whiteColor];
        backV.backgroundColor=EL_BackGroundColor;
          [self.view addSubview:backV];
        
       titleA=[NSMutableArray array];
    infoA=[NSMutableArray array];
        
        
        for (int i=0; i<_turn_sn.count; i++) {
            
     NSMutableArray * sns=[_turn_sn objectAtIndex:i];
            
    NSMutableArray * am=[_turn_amount objectAtIndex:i];
            NSString *order_amountS=[[[NSNumberFormatter alloc]init]stringFromNumber:am];
            // NSString * order_amountS=@"179";
           
            NSString * orderS=@"订单编号";
            NSString * allOrder=[NSString stringWithFormat:@"%@:%@",orderS,sns];
            NSString * amountS=@"支付金额";
            NSString * strign1=@"￥";
            NSString *pricS=[NSString stringWithFormat:@"%@%@",strign1,order_amountS];
            NSString * string=[NSString stringWithFormat:@"%@:%@",amountS,pricS];
            DDLog(@"数据持久化%@",allOrder);
            DDLog(@"价格%@",string);


           // UIButton * titleLabel=[ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
            UIButton * titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
           // titleButton=[ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
            [titleButton addTarget:self action:@selector(choseOeder:) forControlEvents:UIControlEventTouchUpInside];
            [titleButton setTitleColor:EL_TextColor_Dark  forState:UIControlStateNormal];
            titleButton .titleLabel.font=[UIFont systemFontOfSize:14.f];
            titleButton.tag=100+i;
            NSString* titleTag=[NSString stringWithFormat:@"%ld" ,(long)titleButton.tag ];
            [titleA addObject:titleTag];
            titleButton.frame=CGRectMake(-10, cellX+cellH*i, cellW*2/3, cellH);
            [titleButton setTitle:allOrder forState:UIControlStateNormal];
           
            [backV  addSubview:titleButton];
           // UILabel *infoLabel=[ELUtil createLabelFont:13.f color:EL_TextColor_Light];
            UIButton * infoLabel=[UIButton buttonWithType:UIButtonTypeCustom];
            infoLabel.titleLabel.font=[UIFont systemFontOfSize:13.f];
            [infoLabel setTitleColor: EL_TextColor_Light forState:UIControlStateNormal];
          [infoLabel setTitle:string forState:UIControlStateNormal];
            infoLabel.tag=200+i;
            NSString * infoT=[NSString stringWithFormat:@"%ld",infoLabel.tag];
            [infoA addObject:infoT];
            [infoLabel addTarget:self action:@selector(choseOeder:) forControlEvents:UIControlEventTouchUpInside];
            infoLabel.frame=CGRectMake(10+cellW*2/3, cellX+cellH*i, cellW*1/3, cellH);
            [backV addSubview:infoLabel];
            UIView * lineView=[UIView new];
            lineView.frame=CGRectMake(0, cellX+cellH*(i+1), cellW, 0.5);
            lineView.backgroundColor=EL_Color_Line;
            [backV addSubview:lineView];
            
          
            
  
            
            
        }

        backV.hidden=YES;
        DDLog(@"有多少个titletag:%@",titleA);
        DDLog(@"有多少个infotag:%@",infoA);
        
        
    }

   
    
    
      [cell setData:dict];
    return cell;

#pragma mark-这个是新的
   
    
}




//设置cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0 && indexPath.row==1) {
      
        NSUserDefaults *getbuttonclick=[NSUserDefaults standardUserDefaults];
        NSString * getbutton=[getbuttonclick objectForKey:@"buttonClick"];
        NSInteger getbuttonNI=[getbutton integerValue];
        if (getbuttonNI==1) {
            one=0;
            
        }
        one+=1;
        
        
        if (one %2==1) {
            backV.hidden=NO;
            
        }
        else {
             backV.hidden=YES;
        }
        DDLog(@"马上就要结束了%d",one);
        NSString * oneS=[NSString stringWithFormat:@"%d",one];
        
        NSUserDefaults * cishuNSU=[NSUserDefaults standardUserDefaults];
        [cishuNSU setObject:oneS forKey:@"cishu"];
        DDLog(@"我点击的订单编号");
       
    }
    //这个是支付宝的方法
     if (indexPath.section==0 && indexPath.row==3) {
         DDLog(@"我点击的是支付宝");
         if (iwtag || intag ||ijtag==1) {
             iZ=0;
         }
         iZ+=1;
       
         if (iZ%2==1) {
             zhiImageV.image=[UIImage imageNamed:@"ic_checked"];
             weImageV.image=[UIImage imageNamed:@"ic_unchecked"];
             nonImageV.image=[UIImage imageNamed:@"ic_unchecked"];
             jieImageV.image=[UIImage imageNamed:@"ic_unchecked"];
             iztag=1;
             iwtag=0;
             intag=0;
             ijtag=0;
             
             
         }
         else{
             zhiImageV.image=[UIImage imageNamed:@"ic_unchecked"];
             iztag=0;

         }
       
          DDLog(@"sssss是否使用支付宝%d",iztag);
          DDLog(@"sssss是否使用微信支付%d",iwtag);
          DDLog(@"sssss是否使用农商银行支付%d",intag);
          DDLog(@"sssss是否使用捷信支付%d",ijtag);
         
     }
    //点击了微信支付
    if (indexPath.section==0 && indexPath.row==4) {
        DDLog(@"我点击的是微信支付");
        if (iztag || intag ||ijtag==1) {
            iW=0;
        }
       iW+=1;
       
  
        if (iW%2==1) {
            weImageV.image=[UIImage imageNamed:@"ic_checked"];
            zhiImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            nonImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            jieImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            iwtag=1;
            iztag=0;
            iztag=0;
            ijtag=0;
     
//            NSNumber * order_am=[_turn_amount objectAtIndex:0];
//            NSMutableString * order_snS=[_turn_sn objectAtIndex:0];
//            NSString * priS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];


        }
    
        else{
            weImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            iwtag=0;
            
        }
      
        
        DDLog(@"sssss是否使用支付宝%d",iztag);
        DDLog(@"sssss是否使用微信支付%d",iwtag);
        DDLog(@"sssss是否使用农商银行支付%d",intag);
        DDLog(@"sssss是否使用捷信支付%d",ijtag);
    }
   //点击了农商银行支付方
    if (indexPath.section==0 && indexPath.row==5) {
        if (iztag || iwtag ||ijtag==1) {
            iN=0;
        }
       iN+=1;
        [self showCustomHudSingleLine:@"暂无农商银行支付方式，请选择其他的支付方式"];

        if (iN%2==1) {
            nonImageV.image=[UIImage imageNamed:@"ic_checked"];
            zhiImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            weImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            jieImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            intag=1;
            iztag=0;
            iwtag=0;
            ijtag=0;
   
            NSNumber * order_am=[_turn_amount objectAtIndex:0];
             NSMutableString * order_snS=[_turn_sn objectAtIndex:0];
            NSString * priS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];
            
        }
        else{
            nonImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            intag=0;
            
        }

        DDLog(@"sssss是否使用支付宝%d",iztag);
        DDLog(@"sssss是否使用微信支付%d",iwtag);
        DDLog(@"sssss是否使用农商银行支付%d",intag);
        DDLog(@"sssss是否使用捷信支付%d",ijtag);
   
        
    }
//点击捷信分期支付
    if (indexPath.section==0 && indexPath.row==6) {
        if (iztag || iwtag ||intag==1) {
            iJ=0;
        }
        
            iJ+=1;
       
  
        if (iJ%2==1) {
            jieImageV.image=[UIImage imageNamed:@"ic_checked"];
            zhiImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            weImageV.image=[UIImage imageNamed:@"ic_unchecked"];
           nonImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            ijtag=1;
            iztag=0;
            intag=0;
            iwtag=0;

        }
        
        else{
            jieImageV.image=[UIImage imageNamed:@"ic_unchecked"];
            ijtag=0;
            
        }
        
      
        DDLog(@"sssss是否使用支付宝%d",iztag);
        DDLog(@"sssss是否使用微信支付%d",iwtag);
        DDLog(@"sssss是否使用农商银行支付%d",intag);
        DDLog(@"sssss是否使用捷信支付%d",ijtag);
    }
    
    
    
    
    
}




//返回的按钮

//- (IBAction)doback {
//  
//    self.tabBarController.tabBar.hidden=YES;
//    self.hidesBottomBarWhenPushed=YES;
//      [self dismissViewControllerAnimated:YES completion:nil];
//    self.hidesBottomBarWhenPushed=YES;
//    
//    
//}
//点击了按钮所执行的时间
//-(void)doCheck{
//    
//}

-(void)doback{
    DDLog(@"走了我自定制的按钮");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"您确定要放弃本次交易？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        ELGoodDetailController * goods=[[ELGoodDetailController alloc]init];
//        goods.goodId=self.goodID;
//     
//       [self.navigationController pushViewController:goods animated:YES];
       // [self presentViewController:goods animated:YES completion:nil];
               //这里面是调用支付宝进行支付的代码
        /*************这里有我需要改动的地方，原来的是用payment进行判断，现在用pay_code进行判断*************************************************/
        //点击确认之后直接跳转页面
        DBAllOrderViewController *vc = [[DBAllOrderViewController alloc]init];
        vc.vcTitle   = @"待付款订单";
        vc.orderType = @"await_pay";
        vc.tag=1;
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    

}




//拦截重定向
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    if (response) {
        NSLog(@"我要挑战页面");
    }
        return request;
    
}
//弹层按钮的点击事件
-(void)choseOeder:(UIButton * )button{
    DDLog(@"我点击了弹层的按钮");
    buttonclick=1;
    NSString * clickS=[NSString stringWithFormat:@"%d",buttonclick];
    NSUserDefaults * buttonNSU=[NSUserDefaults standardUserDefaults];
    [buttonNSU setObject:clickS forKey:@"buttonClick"];
    
    for (int i=0; i<titleA.count; i++) {
        NSString * subS=[titleA objectAtIndex:i];
        NSInteger subIN=[subS integerValue];
        if (button.tag==subIN) {
            
            

            order_snS=[_turn_sn objectAtIndex:i];
            
            order_am=[_turn_amount objectAtIndex:i];
//      NSMutableArray*    order_aM=[_turn_amount objectAtIndex:i];
            NSString *order_amountS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];
            // NSString * order_amountS=@"179";
            
            NSString * orderS=@"订单编号";
            NSString * allOrder=[NSString stringWithFormat:@"%@:%@",orderS,order_snS];
            NSString * amountS=@"支付金额";
            NSString * strign1=@"￥";
            
            NSString *pricS=[NSString stringWithFormat:@"%@%@",strign1,order_amountS];
            NSString * string=[NSString stringWithFormat:@"%@:%@",amountS,pricS];
            
            NSMutableDictionary *mutableDic1=[NSMutableDictionary dictionaryWithObjects:@[@"请选择订单及时付款，以便尽快处理!",@"",@"ELPromptCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            NSMutableArray * oneSection=[NSMutableArray array];
            [oneSection addObject:mutableDic1];
#pragma mark-第二个分区
            
            
            
            NSMutableDictionary *mutableDic2=[NSMutableDictionary dictionaryWithObjects:@[allOrder,string,@"ELChooseCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            
            [oneSection addObject:mutableDic2];
            
#pragma mark-第二个分区
            NSMutableDictionary *mutableDic30=[NSMutableDictionary dictionaryWithObjects:@[@"支付方式选择",@"",@"ELChooseCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            NSMutableDictionary *mutableDic31=[NSMutableDictionary dictionaryWithObjects:@[@"支付宝支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            NSMutableDictionary *mutableDic32=[NSMutableDictionary dictionaryWithObjects:@[@"微信支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            NSMutableDictionary *mutableDic33=[NSMutableDictionary dictionaryWithObjects:@[@"农商银行支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            
            NSMutableDictionary *mutableDic34=[NSMutableDictionary dictionaryWithObjects:@[@"捷信分期支付",@"",@"ELSpecificCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            NSMutableDictionary *mutableDic35=[NSMutableDictionary dictionaryWithObjects:@[@"温馨提示：选择分期暂不支持部分退款、退货",@"",@"ELPromptCell"] forKeys:@[@"title",@"subTitle",@"cellClass"]];
            
            
            [oneSection addObject:mutableDic30];
            [oneSection addObject:mutableDic31];
            [oneSection addObject:mutableDic32];
            [oneSection addObject:mutableDic33];
            [oneSection addObject:mutableDic34];
            [oneSection addObject:mutableDic35];
            
            // _dataS=[NSMutableArray arrayWithObjects:oneSection,twoSection,theSection, nil];
            _dataS=[NSMutableArray arrayWithObject:oneSection];

            //[self   o_viewAppear];
            //将商品的订单号存起来，用来在支付宝时结算
            NSUserDefaults * payONSU=[NSUserDefaults standardUserDefaults];
            [payONSU setObject:order_snS forKey:@"payOrder1"];
           //把商品价格存起来，用来选择支付方式
            NSUserDefaults * payPNSU=[NSUserDefaults standardUserDefaults];
            [payPNSU setObject:order_amountS forKey:@"payPrice1"];

            [bottomView setData:@{
                                  
                                  /***************这里面有我要改的地方**********************/
                                  @"price":order_amountS,
                                  
                                  
                                  }];
            [zhiImageV removeFromSuperview];
            [weImageV removeFromSuperview];
            [nonImageV removeFromSuperview];
            [jieImageV removeFromSuperview];
            [tableView reloadData];
            backV.hidden=YES;
        }
    }
    
    
   
    
    
    
    
    
}


- (void)onRightButtonTap{
    if ([self.delegate respondsToSelector:@selector(doPay)]) {
       // [self.delegate deleteViewRightTap];
    }
}


//这个是点击了支付宝的方法

//这个是微信支付的方法
//这个是农商银行的支付方法
//这个是捷信分期的支付方法
//这个
//这个是选择完支付方式之后执行的方法
-(void)doPay{
    
    DDLog(@"走了支付的方法");
#pragma mark-利用支付宝进行支付
//    NSUserDefaults *getoederNSU=[NSUserDefaults standardUserDefaults];
//    NSString * orderS=[getoederNSU objectForKey:@"orderH"];
//    
//    NSUserDefaults *getpriceNSU=[NSUserDefaults standardUserDefaults];
//    NSString * priceS=[getpriceNSU objectForKey:@"priceH"];
//    DDLog(@"商品的订单号:%@",orderS);
//    DDLog(@"商品的价格:%@",priceS);
    NSUserDefaults *getbuttonclick=[NSUserDefaults standardUserDefaults];
    NSString * getbutton=[getbuttonclick objectForKey:@"buttonClick"];
    NSInteger getbuttonNI=[getbutton integerValue];

    DDLog(@"用来打印的订单号%@",order_snS);
    DDLog(@"用来打印的金钱%@",order_am);

    if (iztag==1 ) {
        
        
        
        NSUserDefaults *getoederNSU=[NSUserDefaults standardUserDefaults];
        NSString * orderS=[getoederNSU objectForKey:@"payOrder1"];
        
        NSUserDefaults *getpriceNSU=[NSUserDefaults standardUserDefaults];
        NSString * priceS=[getpriceNSU objectForKey:@"payPrice1"];

        //调用支付包的方法
        WS(ws);
//        NSString * order_snS=[_turn_sn objectAtIndex:0];
//       
//        NSNumber * order_am=[_turn_amount objectAtIndex:0];
//        NSString *order_amountS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];
        
        [ELShopService   SaveOrderPayment:0 orderNo:order_snS block:^(BOOL success,id result){
            if (success) {
                DDLog(@"保存支付方式%@",result);
                NSString * amous=[result objectForKey:@"amount"];
                DDLog(@"商品的数量%@",amous);
                //把商品的支付方式存到沙盒里
                NSUserDefaults * paymentNSU=[NSUserDefaults standardUserDefaults];
                [paymentNSU setObject:@"0" forKey:@"payment"];
                //把商品的数量存到沙盒里
                NSUserDefaults * amousNSU=[NSUserDefaults standardUserDefaults];
                [amousNSU setObject:amous forKey:@"amous"];
                
                [ELShopService getAliPayInfoWithOrderId:order_snS totalFee:priceS  subject:nil block:^(BOOL success, id result) {
                    if (success) {
                        NSString *appScheme = [ws appSchema:@"alipay"];
                        NSLog(@"%@",result);
                        [[AlipaySDK defaultService] payOrder:result fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            NSLog(@"++++++++++++++++reslut = %@",resultDic);
                        }];
                    }
                }];
                

                
                
            }
            
        }];

        
        
        
        
        
    }
    else if (iztag==0 && iwtag==0 &&intag==0 &&ijtag==0){
        
        NSUserDefaults *getoederNSU=[NSUserDefaults standardUserDefaults];
        NSString * orderS=[getoederNSU objectForKey:@"payOrder1"];
        
        NSUserDefaults *getpriceNSU=[NSUserDefaults standardUserDefaults];
        NSString * priceS=[getpriceNSU objectForKey:@"payPrice1"];
        
        //调用支付包的方法
        WS(ws);
        //        NSString * order_snS=[_turn_sn objectAtIndex:0];
        //
        //        NSNumber * order_am=[_turn_amount objectAtIndex:0];
        //        NSString *order_amountS=[[[NSNumberFormatter alloc]init]stringFromNumber:order_am];
        
        [ELShopService   SaveOrderPayment:0 orderNo:order_snS block:^(BOOL success,id result){
            if (success) {
                NSUserDefaults * paymentNSU=[NSUserDefaults standardUserDefaults];
                [paymentNSU setObject:@"0" forKey:@"payment"];

                
                [ELShopService getAliPayInfoWithOrderId:orderS totalFee:priceS  subject:nil block:^(BOOL success, id result) {
                    if (success) {
                        NSString *appScheme = [ws appSchema:@"alipay"];
                        NSLog(@"%@",result);
                        [[AlipaySDK defaultService] payOrder:result fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            NSLog(@"++++++++++++++++reslut = %@",resultDic);
                        }];
                    }
                }];
                
                
                
                
            }
            
        }];
        

        
    }
    
#pragma mark-利用微信支付进行支付
  else if  (iwtag==1) {
      NSUserDefaults *getoederNSU=[NSUserDefaults standardUserDefaults];
      NSString * orderS=[getoederNSU objectForKey:@"payOrder1"];
      
      NSUserDefaults *getpriceNSU=[NSUserDefaults standardUserDefaults];
      NSString * priceS=[getpriceNSU objectForKey:@"payPrice1"];
      
        NSString * res=[self jumpToBizPay];
       // NSMutableString * order_snS=[_turn_sn objectAtIndex:0];
        [ELShopService   SaveOrderPayment:1 orderNo:order_snS block:^(BOOL success,id result){
            if (success) {
                NSUserDefaults * paymentNSU=[NSUserDefaults standardUserDefaults];
                [paymentNSU setObject:@"1" forKey:@"payment"];

                
                if (![@"" isEqual:res]) {
                    UIAlertView * alter=[[UIAlertView alloc]initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alter show];
                }
            }
            
        }];

    }
#pragma mark-利用农商银行进行支付
 else if  (intag==1) {
     
     NSUserDefaults * paymentNSU=[NSUserDefaults standardUserDefaults];
     [paymentNSU setObject:@"4" forKey:@"payment"];

         [self showCustomHudSingleLine:@"暂无农商银行支付方式，请选择其他的支付方式"];
        
        
    }
#pragma mark-使用捷信分期完成支付
    else {
             // NSMutableString * order_snS=[_turn_sn objectAtIndex:0];
   
        NSUserDefaults *getoederNSU=[NSUserDefaults standardUserDefaults];
        NSString * orderS=[getoederNSU objectForKey:@"payOrder1"];
        
        NSUserDefaults *getpriceNSU=[NSUserDefaults standardUserDefaults];
        NSString * priceS=[getpriceNSU objectForKey:@"payPrice1"];
        
        [ELShopService   SaveOrderPayment:3 orderNo:order_snS block:^(BOOL success,id result){
            if (success) {
                //先调用接口判断是不是可以使用捷信分期
                NSUserDefaults * paymentNSU=[NSUserDefaults standardUserDefaults];
                [paymentNSU setObject:@"3" forKey:@"payment"];

                
                [ELShopService  is0JiexinWithOrderNo:order_snS block:^(BOOL success,id result){
                    if (success) {
                        DDLog(@"是否可以使用捷信分期%@",result);
                        
                    //然后调用接口获得用户的活动信息
                   [ELShopService     MessageJiexinWithOrderNo:order_snS block:^(BOOL success,id result){
                       if (success) {
                           DDLog(@"获取用户的活动信息%@",result);
                           //NSArray * array=result[@"orderHistory"];
                           //利用post请求，将数据传递过去
                           //接口地址
                      // NSString * url=@"https://api-uat.homecredit.cn/morest/api/customer/activities";
                         NSString * url=@"https://app.homecredit.cn/hccgateway/api/customer/activities";
                          //NSString * url1=@" https://app.homecredit.cn/hccgateway/api/customer/activities";
//                          // https://app.homecredit.cn/hccgateway/api/customer/activities
//                           NSString * resultS=result;

                           
                           
                           AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                           manager.requestSerializer = [AFJSONRequestSerializer serializer];
                           [manager POST:url parameters:result progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                               if (success) {
                                   DDLog(@"post请求成功");
                                   DDLog(@"成功后返回的数据%@",responseObject);
                                   
                               }
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                               DDLog(@"post请求失败");
                               DDLog(@"失败原因%@",error);
                               
                               
                    }];

                           
                           
                }
                       else{
                           DDLog(@"用户活动信息获取失败");
                           
                       }
                        
                       
                   }];
                // 传递申请信息
                [ELShopService    turnJiexinWithOrderNo:order_snS block:^(BOOL success,id result){
                    if (success) {
                        DDLog(@"传递申请信息%@",result);
                        
                    //在这里面我要重定向的方式将数据传递到客户的接口
                     

                       //NSString * url=@"https://api-uat.homecredit.cn/morest/auth?z={0}";
                      //NSString * url=@"https://api-uat.homecredit.cn/morest/auth";
                       
                     NSString * url=@"https://app.homecredit.cn/hccgateway/auth";
                        NSString * string=[NSString stringWithFormat:@"%@?z=%@",url,result];
                        
                       // http://test.cangjiaquan.com/demo/settlement_info.php?id=-6664321037758168297
                        

                        DDLog(@"我最后的数据%@",string
                              );
                        //这个是我增加的代码
//                        AFSecurityPolicy * secutityPolicy=[[AFSecurityPolicy alloc]init];
//                        [secutityPolicy setAllowInvalidCertificates:YES];
                    
                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                        [manager setSecurityPolicy:secutityPolicy];
                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
                        
                        [manager GET:string parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                            DDLog(@"申请成功: %@", responseObject);
                            
                            
                            JieViewController * jieVC=[[JieViewController alloc]init];
                            
                            //[self presentViewController:jieVC animated:YES completion:nil];
                            jieVC.urlS=string;
//                            [self.navigationController pushViewController:jieVC animated:YES];
                            [self presentViewController:jieVC animated:YES completion:nil];
                            
                            
                        } failure:^(NSURLSessionTask *operation, NSError *error) {
                            
                            DDLog(@"申请失败Error: %@", error);
                            
                        }];

                        
                        
                        
                        
                        
                        
                    }
                    else{
                        
                    }
                       
                }];
                       
                    
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    else{
                        
                        [self showCustomHudSingleLine:@"您不满足使用捷信分期的条件，暂时不可使用捷信分期"];
                    }
                
                    
                }];
            }
            
        }];
        
        
    }
    
    
    
    
}





- (NSString *)appSchema:(NSString *)name
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    NSArray * array = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    for ( NSDictionary * dict in array )
    {
        if ( name )
        {
            NSString * URLName = [dict objectForKey:@"CFBundleURLName"];
            if ( nil == URLName )
            {
                continue;
            }
            
            if ( NO == [URLName isEqualToString:name] )
            {
                continue;
            }
        }
        
        NSArray * URLSchemes = [dict objectForKey:@"CFBundleURLSchemes"];
        if ( nil == URLSchemes || 0 == URLSchemes.count )
        {
            continue;
        }
        
        NSString * schema = [URLSchemes objectAtIndex:0];
        if ( schema && schema.length )
        {
            return schema;
        }
    }
    
    return nil;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}


#pragma mark - Response

- (void)onAliPayResponse:(NSNotification *)notification {
    NSNumber *result = notification.object;
    if (result.boolValue == YES) {
        [self.view el_makeToast:@"支付成功"];
        
    }else{
        [self.view el_makeToast:@"支付失败"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}


//微信支付
- (NSString *)jumpToBizPay {
    
    
    NSUserDefaults *getoederNSU=[NSUserDefaults standardUserDefaults];
    NSString * orderS=[getoederNSU objectForKey:@"payOrder1"];
    
    NSUserDefaults *getpriceNSU=[NSUserDefaults standardUserDefaults];
    NSString * priceS=[getpriceNSU objectForKey:@"payPrice1"];
    DDLog(@"商品的订单号:%@",orderS);
    DDLog(@"商品的价格:%@",priceS);

    // static NSString * orderId=@"1464247251134";
    //根据查询微信api文档，我们需要添加两个需要的判断
    // 判断是否安装了微信
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"没有安装微信");
    }else if (![WXApi isWXAppSupportApi]){
        NSLog(@"不支持微信支付");
    }
    
    
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    
    NSString * urlString=[NSString stringWithFormat:@"%@order/toWx?orderNo=%@",HTTP_BASE_URL,order_snS];
    
    //NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        
        NSDictionary  * dic=[dict objectForKey:@"data"];
        NSLog(@"url:%@",urlString);
        // NSLog(@"dict:%@",dict);
        if(dic != nil){
            NSMutableString *retcode = [dic objectForKey:@"retcode"];
            
            
            NSLog(@"retcode%@",retcode);
            
            //这里有改动的地方，原来的是retcode.intvalue==0
            if (retcode.intValue==0){
                NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dic objectForKey:@"partnerid"];
                NSLog(@"req.partnerId%@",req.partnerId);
                req.prepayId            = [dic objectForKey:@"prepayid"];
                NSLog(@"req.prepayId%@",req.prepayId);
                req.nonceStr            = [dic objectForKey:@"noncestr"];
                NSLog(@"req.nonceStr%@",req.nonceStr);
                req.timeStamp           = stamp.intValue;
                NSLog(@"req.timeStamp%u",(unsigned int)req.timeStamp);
                req.package             = [dic objectForKey:@"package"];
                NSLog(@"req.package%@",req.package);
                req.sign                = [dic objectForKey:@"sign"];
                NSLog(@"req.sign%@",req.sign);
                //发送请求到微信，等待微信返回响应的
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dic objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
    
}







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
