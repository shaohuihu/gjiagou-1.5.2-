//
//  ELGoodsTopCell.m
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodsTopCell.h"
#import "ELGoodsDetailModel.h"
#import "ELMainBannerView.h"

@interface ELGoodsTopCell ()<ELMainBannerViewDelegate>

@property (nonatomic, weak) UIImageView *goodsImage;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *marketLabel;
//这里是用作友盟分享的
@property(nonatomic,weak)UIButton * shareBTN;
@property(nonatomic,weak)UIImageView * imageV;

@property (nonatomic, strong) ELMainBannerView *bannerView;

@end

@implementation ELGoodsTopCell

- (void)o_configViews {
    
    UIView *banView = [UIView new];
    [banView addSubview:self.bannerView];
    [self.contentView addSubview:banView];
    
    UILabel *nameLabel = [ELUtil createLabelFont:15 color:[UIColor blackColor]];
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel = nameLabel];
    
    UILabel * priceLabel = [ELUtil createLabelFont:14.f color:EL_MainColor];
    [self.contentView addSubview:self.priceLabel = priceLabel];
    
    UILabel *fixIcon = [ELUtil createLabelFont:9 color:EL_MainColor];
    fixIcon.text = @"￥";;
    [self.contentView addSubview:fixIcon];
    
    UILabel *marketLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    [self.contentView addSubview:self.marketLabel = marketLabel];
    //设置分享的图片
    UIImageView * imageV=[[UIImageView alloc]init];
//    imageV.image=[UIImage imageNamed:@"share_sprite"];
    imageV.image=[UIImage imageNamed:@"ic_share_icon"];
    [self.contentView addSubview:self.imageV=imageV];

    UIButton * shareBTN=[UIButton buttonWithType:UIButtonTypeCustom];
        [shareBTN setTitle:@"分享" forState:UIControlStateNormal];
        shareBTN.titleLabel.font=[UIFont systemFontOfSize:14.0f];
        [shareBTN setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
        //shareBTN.backgroundColor=[UIColor blueColor];
         shareBTN.titleLabel.textAlignment=NSTextAlignmentLeft;
       [shareBTN addTarget:self action:@selector(doshare) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.shareBTN=shareBTN ];
    
    //设置他们左侧的竖线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    
    WS(ws);
    [banView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.contentView);
        make.height.equalTo(banView.width);
    }];
    
//    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(banView.bottom).offset(10);
//        make.left.equalTo(13);
//        make.right.equalTo(ws.contentView).offset(-13);
//    }];
#pragma mark-改变name的坐标
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banView.bottom).offset(10);
        make.left.equalTo(13);
        make.right.equalTo(ws.contentView).offset(-60);
    }];
    
    [fixIcon makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(12);
        make.bottom.equalTo(priceLabel);
    }];
    
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.bottom).offset(15);
        make.bottom.equalTo(ws.contentView).offset(-15);
        make.left.equalTo(fixIcon.right).offset(2);
    }];
//    
//    [marketLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(ws.contentView).offset(-13);
//        make.centerY.equalTo(priceLabel);
//    }];
#pragma mark-改变坐标
    [marketLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-60);
        make.centerY.equalTo(priceLabel);
    }];
//对于分享的图片进行屏幕适配
    [imageV makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banView.bottom).offset(10);
        make.right.equalTo(ws.contentView).offset(-30);
        //make.centerY.equalTo(priceLabel);
        make.width.equalTo(16);
        make.height.equalTo(20);

    }];
  //对于分享的按钮进行屏幕适配
    [shareBTN makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(imageV.bottom).offset(-10);
        make.top.equalTo(imageV.bottom).offset(-18);
        make.right.equalTo(ws.contentView);
        //make.centerY.equalTo(priceLabel);
        make.width.equalTo(70);
        make.height.equalTo(80);
        
    }];
    

    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banView.bottom).offset(5);
        make.width.equalTo(1);
       make.right.equalTo(ws.contentView).offset(-55);
        make.bottom.equalTo(marketLabel ).offset(-10);
    }];
    
}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[ELGoodsDetailModel class]]) {
        ELGoodsDetailModel *model = self.data;
//        [self.goodsImage sd_setImageWithURL:ELIMAGEURL(model.goods.imgUrl)];
        [self.bannerView setImageViewAry:[model.goods.pictures arrayByAddingObject:model.goods.imgUrl]];
        self.nameLabel.text = model.goods.name;
#pragma mark-让按钮的字体自适应
        self.nameLabel.numberOfLines=0;
        NSString *price = [NSString stringWithFormat:@"%.2f",model.goods.price];
        self.priceLabel.text = DBPRICE(price);
        self.marketLabel.text = [NSString stringWithFormat:@"销量 %ld",(long)model.goods.sumSold];
    }
}


- (ELMainBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[ELMainBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
        _bannerView.delegate = self;
    }
    return _bannerView;
}
//友盟分享的按钮
-(void)doshare{
 
//    [UMSocialData defaultData].extConfig.title = @"分享的title";
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"507fcab25270157b37000010"
//                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
//                                     shareImage:[UIImage imageNamed:@"icon"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
//                                       delegate:self];
    
    if ([self.delegate respondsToSelector:@selector(doshare)]) {
        [self.delegate doshare];
    }
    
    
    

}

@end
