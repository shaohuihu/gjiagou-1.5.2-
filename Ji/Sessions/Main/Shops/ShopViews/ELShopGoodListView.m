//
//  ELShopGoodListView.m
//  Ji
//
//  Created by hushaohui on 16/10/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopGoodListView.h"

@interface ELShopGoodListView()

{}
@property (nonatomic, strong)ELMainShopTopModel *model;  ///<模型
@property (nonatomic, weak)UIImageView *imageViewOne;  ///<image 1
@property (nonatomic, weak)UIImageView *imageViewTwo;  ///<

@end
@implementation ELShopGoodListView

- (instancetype)initWithFrame:(CGRect)frame model:(ELMainShopTopModel *)model
{
    if(self = [super initWithFrame:frame]){
        self.model = model;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    //label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.text = @"  超值单品";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = EL_TextColor_Light;
    [self addSubview:label];
    
   
    ELShopBannerModel *bannerModel = [self.model.shopBanners objectAtIndex:0];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), SCREEN_WIDTH, 100)];
    imageView.userInteractionEnabled = YES;
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:imageView];
    [self.imageViewOne sd_setImageWithURL:ELIMAGEURL(bannerModel.imgUrl)];
    self.imageViewOne = imageView;
    //下面两个image
    if(self.model.shopBanners.count == 1){
        [self setEl_height:154];
        return;
    }
    
    bannerModel = [self.model.shopBanners lastObject];
    //下面两个image
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, SCREEN_WIDTH, 100)];
    imageView.userInteractionEnabled = YES;
    [imageView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:imageView];
    [imageView sd_setImageWithURL:ELIMAGEURL(bannerModel.imgUrl)];
    self.imageViewTwo = imageView;
    [self setEl_height:264];
    
}

- (void)setupData:(ELMainShopTopModel *)model
{
//    //重置数据后肯定要计算下他的frame  因为肯定都不存在
//    if(model.shopBanners.count == 0){
//        //没有数据
//        [self setEl_height:0];
//    }else if (model.shopBanners.count == 1){
//        ELShopBannerModel *bannerModel = [model.shopBanners objectAtIndex:0];
//        [self.imageViewOne sd_setImageWithURL:ELIMAGEURL(bannerModel.imgUrl)];
//        [self setEl_height:154];
//    }else if (model.shopBanners.count >=2){
//        ELShopBannerModel *bannerModel = [model.shopBanners objectAtIndex:0];
//        [self.imageViewOne sd_setImageWithURL:ELIMAGEURL(bannerModel.imgUrl)];
//        
//        bannerModel = [model.shopBanners lastObject];
//        [self.imageViewTwo sd_setImageWithURL:ELIMAGEURL(bannerModel.imgUrl)];
//        
//        [self setEl_height:264];
//    }
}

@end
