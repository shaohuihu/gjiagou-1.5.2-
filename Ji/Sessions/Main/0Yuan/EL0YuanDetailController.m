//
//  EL0YuanDetailController.m
//  Ji
//
//  Created by evol on 16/6/8.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "EL0YuanDetailController.h"
#import "ELMainService.h"

@interface EL0YuanDetailController ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@end

@implementation EL0YuanDetailController


- (void)o_configViews {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView = imageView];
    

    UILabel *nameLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    [self.view addSubview:self.nameLabel = nameLabel];

    UILabel *timeLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    [self.view addSubview:self.timeLabel = timeLabel];

    UILabel *detailLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    [self.view addSubview:self.detailLabel = detailLabel];

    WS(ws);
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        make.height.equalTo(imageView.width).multipliedBy(135.0/320);
    }];

}

- (void)o_loadDatas {
    [ELMainService getDrawDetailWithDrawId:self.drawId block:^(BOOL success, id result) {
        if (success) {
            
        }else{
            
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
