//
//  ELShopMainHeaderView.m
//  Ji
//
//  Created by hushaohui on 16/10/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopMainHeaderView.h"
#import "ELMainBannerView.h"
#import "ELMainShopTopModel.h"
#import "ELGoodDetailController.h"
#import "ELMainService.h"
#import "ELShopSelectTypeView.h"
#import "ELShopGoodListView.h"
@interface ELShopMainHeaderView()<ELMainBannerViewDelegate,ELShopSelectTypeViewDelegate>
@property (nonatomic, strong)ELMainShopTopModel *model;  ///<模型
@property (nonatomic, weak)UIImageView *topView;  ///<顶部view
@property (nonatomic, weak)ELMainBannerView *bannerView ;  ///<轮播图
@property (nonatomic, weak)ELShopSelectTypeView *selectView;  ///<selectView
@property (nonatomic, strong)ELShopGoodListView *goodList;  ///<超值单品

@end
@implementation ELShopMainHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor clearColor]];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(100))];
    topView.userInteractionEnabled = YES;
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectButton setBackgroundImage:[UIImage imageNamed:@"ic_butn_shop_collect"] forState:UIControlStateNormal];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitle:@"已收藏" forState:UIControlStateSelected];
    collectButton.titleLabel.font = kFont_System(14.f);
    [collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(onFavTap:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:collectButton];
    [self addSubview:topView];
    self.topView = topView;
    
    [collectButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(-10);
        make.bottom.equalTo(topView).offset(-20);
    }];
    
    
    //轮播图
    ELMainBannerView *bannerView = [[ELMainBannerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+10, SCREEN_WIDTH, kRadioValue(135))];
    bannerView.delegate = self;
    [bannerView shouldAutoShow:YES];
    [self addSubview:bannerView];
    self.bannerView = bannerView;
    
    //添加选择view
    ELShopSelectTypeView *selectView = [[ELShopSelectTypeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame), SCREEN_WIDTH, 64)];
    selectView.delegate = self;
    [self addSubview:selectView];
    self.selectView = selectView;
    
//    //超值单品 可能没有数据
//    ELShopGoodListView *goodList = [[ELShopGoodListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(selectView.frame), SCREEN_WIDTH, 240)];
//    [self addSubview:goodList];
//    self.goodList = goodList;
}

- (CGFloat)getHeaderHeight
{
    return self.frame.size.height;
}

- (void)setupData:(ELMainShopTopModel *)model
{
    self.model = model;
    NSMutableArray *bannerImages = [NSMutableArray array];
    [model.goodsSlides enumerateObjectsUsingBlock:^(ELGoodsslidesModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [bannerImages addObject:model.goodsImage];
    }];
    [self.bannerView setImageViewAry:bannerImages];
    [self.topView sd_setImageWithURL:ELIMAGEURL(model.shopInfo.bannerPath)];
    
    //通过数据创建超值单品
    if(self.model.shopBanners.count >= 1){
        if(!self.goodList){
            self.goodList = [[ELShopGoodListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectView.frame), SCREEN_WIDTH, 0) model:model];
            [self setEl_height:CGRectGetMaxY(self.goodList.frame)];
            [self addSubview:self.goodList];
        }
        
    }else{
        [self setEl_height:CGRectGetMaxY(self.selectView.frame)];
    }
   
    
}

//点击轮播图
- (void)didClickPage:(ELMainBannerView *)view atIndex:(NSInteger)index {
    ELGoodsslidesModel *model = self.model.goodsSlides[index];
    if (model.fullPath == nil || model.fullPath.length < 1) {
        return;
    }
    ELGoodDetailController *vc = [[ELGoodDetailController alloc] init];
    vc.goodId = [model.fullPath componentsSeparatedByString:@"="].lastObject.integerValue;
    [self.controlelr.navigationController pushViewController:vc animated:YES];
}


- (void)selectShopTypeView:(ELShopSelectTypeView *)typeView typeIndex:(NSInteger)index
{
    NSLog(@"类型点击---%ld",(long)index);
}

//收藏按钮点击
- (void)onFavTap:(UIButton *)button{
    if (!Uid) {
        ELPresentLogin;
        return;
    }
    if (button.selected == NO) {
        [ELMainService addShopFavList:self.model.shopInfo.shopId uId:Uid block:^(BOOL success, id result) {
            if (success) {
                [self el_makeToast:@"收藏成功!"];
                button.selected = YES;
            }
        }];
    }
}

@end
