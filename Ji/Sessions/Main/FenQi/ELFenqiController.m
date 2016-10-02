//
//  ELFenqiController.m
//  Ji
//
//  Created by evol on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELFenqiController.h"

@interface ELFenqiController ()

@end

@implementation ELFenqiController

- (void)o_configViews{
    self.title = @"分期";
    self.navigationItem.rightBarButtonItem = self.notiItem;
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0992"]];
    [self.view addSubview:imgView];
    
    UILabel *topLabel = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    topLabel.text = @"温馨提示:";
    [self.view addSubview:topLabel];
    
    UILabel *tip1 = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    tip1.numberOfLines = 0;
    tip1.text = @"1) 此分期付款计算器的计算结果尚未包含保险手续费和灵活还款服务，仅供参考。分期付款产品的具体内容以您签署的消费贷款合同为准。";
    [self.view addSubview:tip1];
    
    UILabel *tip2 = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    tip2.numberOfLines = 0;
    tip2.text = @"2) 如欲查询某一具体商品的分期付款情况，请点击下方的 “贷款费率表” 进行查看，或咨询合作商户的店内销售代表，或者致电客户服务热线了解更多分期付款详情信息。";
    [self.view addSubview:tip2];
    
    WS(ws);
    [imgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH));
    }];
    
    [topLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.bottom).offset(20);
        make.left.equalTo(20);
    }];
    
    [tip1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.bottom).offset(25);
        make.left.equalTo(topLabel);
        make.right.equalTo(ws.view).offset(-20);
    }];
    
    [tip2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tip1.bottom).offset(25);
        make.left.equalTo(topLabel);
        make.right.equalTo(ws.view).offset(-20);
    }];
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
