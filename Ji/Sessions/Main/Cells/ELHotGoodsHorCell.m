//
//  ELHotGoodsHorCell.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELHotGoodsHorCell.h"
#import "ELHotGoodsModel.h"
@implementation ELHotGoodsHorCell
{
    UIImageView *imageView_;
}

- (void)o_configViews{
    self.contentView.backgroundColor = [UIColor blackColor];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = EL_BackGroundColor;
    [self.contentView addSubview:view];
    
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.contentView);
        make.height.equalTo(kRadioXValue(90));
    }];
    
    imageView_ = [UIImageView new];
    [view addSubview:imageView_];
    imageView_.contentMode = UIViewContentModeScaleAspectFit;
    self.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    [imageView_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(view);
        make.right.equalTo(view).offset(-10);
    }];
}


- (void)o_dataDidChanged{
    if([self.data isKindOfClass:[ELHotGoodsModel class]]){
        ELHotGoodsModel *model = self.data;
        [imageView_ sd_setImageWithURL:ELIMAGEURL(model.imgUrl)];
    }
}

@end
