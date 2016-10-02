
//
//  ELReshopCell.m
//  Ji
//
//  Created by evol on 16/5/21.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELReshopCell.h"
#import "ELHotShopModel.h"

@implementation ELReshopCell
{
    UIImageView *imageView_;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self p_configView];
    }
    return self;
}


- (void)p_configView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    imageView_ = [UIImageView new];
    imageView_.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView_];
    
    WS(ws);
    [imageView_ makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
    }];
    
}

- (void)setData:(id)data{
    _data = data;
    if([self.data isKindOfClass:[ELHotShopModel class]]){
        ELHotShopModel *model = self.data;
        [imageView_ sd_setImageWithURL:ELIMAGEURL(model.shopLogo)];
    }
}

@end
