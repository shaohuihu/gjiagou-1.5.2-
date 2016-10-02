//
//  RuleViewController.m
//  Ji
//
//  Created by 龙讯科技 on 16/8/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "RuleViewController.h"
#import "ELMainService.h"
#import "ELMainShopController.h"
#import "ELMessageCenterController.h"
@interface RuleViewController ()<UITextViewDelegate>
{
    NSMutableString * string;
}

@end

@implementation RuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"活动规则";
    //在这里面调用活动规则的接口
    
    //设置导航栏最左侧按钮
    self.navigationItem.leftBarButtonItem= ({
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back_button"]
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(backButton)];
        leftBtn;
    });
    
    
    self.navigationItem.rightBarButtonItem= ({
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_notice_dot"]
                                                                     style:UIBarButtonItemStyleDone target:self action:@selector(turnMessage)];
        rightBtn;
    });
    
    
    
    
    [ELMainService getRulesWithBlock:^(BOOL success, id result) {
        if (success) {
            NSArray * array=result[@"data"];
            NSMutableArray * dataA=[NSMutableArray array];
            NSMutableString * dataS=[NSMutableString string];
            //            NSMutableString * string=[array componentsJoinedByString:@"/n"];
            //            DDLog(@"我的换皇甫%@",string);
            
            for (int i=0; i<array.count; i++) {
                NSDictionary  * subDic=[array objectAtIndex:i];
                NSString * subS=[subDic objectForKey:@"ruleContext"];
                NSString * st1=[NSString stringWithFormat:@"%d",i+1];
                NSString * st2=@" )  ";
                NSString * st3=[st1 stringByAppendingString:st2];
                NSString * ruleS=[st3 stringByAppendingString:subS];
                //dataS=[NSString stringWithString:subS];
                [dataA addObject:ruleS];
                
            }
            DDLog(@"我的数组%@",dataA);
            string=[ dataA componentsJoinedByString:@"\n\n" ];
            DDLog(@"换行符%@",string);
            
            //设置立即使用的代金券的图片
            CGFloat imageVW=[UIScreen mainScreen].bounds.size.width;
            UIImageView * imageV=[[UIImageView alloc]init];
            imageV.frame=CGRectMake(0, 0, imageVW, 237);
            [imageV setImage:[UIImage imageNamed:@"ic_index_active_content_img"]];
            
            //设置立即使用代金券的按钮
            UIButton * turnBTN=[UIButton buttonWithType:UIButtonTypeCustom];
            [turnBTN setTitle:@"立即使用代金券" forState:UIControlStateNormal];
           // turnBTN.frame=CGRectMake(80, 195, 160, 30);
            turnBTN.backgroundColor=[UIColor redColor];
            [turnBTN setTintColor:[UIColor whiteColor]];
            
            
            [turnBTN addTarget:self action:@selector(useVourse) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.view addSubview:imageV];
            [self.view addSubview:turnBTN];
            
            [turnBTN makeConstraints:^(MASConstraintMaker *make) {
                //make.left.equalTo([UIScreen mainScreen].bounds.size.width/2-70);
                make.centerX.equalTo(imageV);
                make.bottom.equalTo(imageV.bottom).offset(-10);
                make.width.equalTo(160);
                make.height.equalTo(30);
            }];
            
            //设置活动规则的显示框
            UILabel * topLabel=[[UILabel alloc]init];
            topLabel.frame=CGRectMake(10, 237, 80, 30);
            topLabel.text=@"活动规则:";
            topLabel.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:topLabel];
            
            
            //设置显示整个活动label
            /*
             CGFloat ScreenH=[UIScreen mainScreen].bounds.size.height;
             CGFloat labelH=(ScreenH-170-10*dataA.count)/dataA.count;
             // CGFloat labelH=(ScreenH -233)/dataA.count;
             CGFloat labelW=[UIScreen mainScreen].bounds.size.width-20;
             //利用循环遍历获取到所有显示的显示框
             for (int b=0; b<dataA.count; b++) {
             
             UILabel * label=[[UILabel alloc]init];
             // CGFloat labelY=233+10*(b+1)+labelH*b;
             CGFloat labelY=170+labelH*b;
             
             label.frame=CGRectMake(10, labelY, labelW, labelH);
             label.text=[dataA objectAtIndex:b];
             // textField.font=[UIFont  systemFontOfSize:22];
             label.font=[UIFont  systemFontOfSize:12];
             label.numberOfLines=0;
             
             [self.view addSubview:label];
             
             
             }
             */
            //在这里设置一个全局的textView
            CGFloat ScreenH=[UIScreen mainScreen].bounds.size.height;
            CGFloat textVH=[UIScreen mainScreen].bounds.size.height-340;
            UITextView * textV=[[UITextView alloc]init];
            
            
            
            textV.text=string;
            textV.delegate=self;
            textV.font=[UIFont systemFontOfSize:20];
            textV.backgroundColor=[UIColor whiteColor];
            textV.editable=NO;
            textV.scrollEnabled=YES;
            textV.scrollsToTop=YES;
            textV.showsVerticalScrollIndicator=NO;
            
            
            [self.view addSubview:textV];
            
            
            [textV   makeConstraints:^(MASConstraintMaker *make) {
                //make.left.equalTo([UIScreen mainScreen].bounds.size.width/2-70);
                make.centerX.equalTo(imageV);
                make.top.equalTo(270);
                make.width.equalTo([UIScreen mainScreen].bounds.size.width);
                make.height.equalTo([UIScreen mainScreen].bounds.size.height-340);
            }];
            
            
        }
        
        
    }];
    


}
//点击使用代金券
-(void)useVourse{
   
    ELMainShopController * mainVC=[[ELMainShopController  alloc]init];
    mainVC.shopId = JiJiaHui;
    [self.navigationController pushViewController:mainVC animated:YES];
    //[self presentViewController:mainVC animated:YES completion:nil];
    
}
//左侧按钮的方法
-(void)backButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//右侧按钮的方法
-(void)turnMessage{
    ELMessageCenterController * message=[[ELMessageCenterController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
    
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
