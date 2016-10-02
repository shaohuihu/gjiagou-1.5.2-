//
//  ELMessageDetailController.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMessageDetailController.h"
#import "ELMessageService.h"
@interface ELMessageDetailController ()

@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation ELMessageDetailController

- (void)o_configViews
{
    self.title = @"我的消息";
    self.view.backgroundColor = EL_BackGroundColor;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xc0c0c0);
    lineView.layer.shadowOffset = CGSizeMake(0, 0.5);
    lineView.layer.shadowColor = [UIColor blackColor].CGColor;
    lineView.layer.shadowOpacity = 0.3;
    [self.view addSubview:lineView];
    
    UILabel *fixLabel = [ELUtil createLabelFont:15.f color:EL_TextColor_Dark];
    fixLabel.text = @"我的消息";
    [self.view addSubview:fixLabel];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    UILabel *detailLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    detailLabel.numberOfLines = 0;
    [contentView addSubview:self.detailLabel = detailLabel];
    
    WS(ws);
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(16);
        make.height.equalTo(0.5);
    }];
    
    [fixLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(5);
        make.left.equalTo(15);
    }];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fixLabel.bottom).offset(15);
        make.left.right.equalTo(ws.view);
        make.height.equalTo(kRadioXValue(150));
    }];
    
    [detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(15);
        make.right.equalTo(contentView).offset(-15);
    }];
}


- (void)o_loadDatas {
    WS(ws);
    [ELMessageService getMessageDetailWithMessageId:self.messageId id:self.id block:^(BOOL success, id result) {
        if (success) {
            id obj = result[@"message"];
            if ([obj isKindOfClass:[NSDictionary class]]) {
                ws.detailLabel.text = obj[@"detail"];
            }
        }else{
            [self.view el_makeToast:result];
        }
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
