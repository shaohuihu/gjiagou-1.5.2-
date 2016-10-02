//
//  ELGuideContentController.m
//  Ji
//
//  Created by evol on 16/6/12.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGuideContentController.h"

@interface ELGuideContentController ()

@end

@implementation ELGuideContentController

- (void)o_configViews {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageString]];
    [self.view addSubview:imageView];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
