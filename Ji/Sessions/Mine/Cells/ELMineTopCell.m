//
//  ELMineTopCell.m
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMineTopCell.h"
#import "DBUserInfo.h"
@interface ELMineTopCell ()

@property (nonatomic, weak) UIImageView *avatar;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *goodCount;//商品收藏
@property (nonatomic, weak) UILabel *shopCount;//商铺收藏
//65 45 185

@end

@implementation ELMineTopCell
-(void)setImageWithUrl:(NSString*)url{
    if (url.length>0) {
        [self.avatar sd_setImageWithURL:ELIMAGEURL(url)];
    }else{
        self.avatar.image = [UIImage imageNamed:@"ic_person"];
    }
}
- (void)o_configViews{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_person_bg"]];
    bgView.userInteractionEnabled = YES;
    [self.contentView addSubview:bgView];
    
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_person"]];
    CGSize imageSize = avatar.el_size;
    [bgView addSubview:self.avatar = avatar];
    avatar.userInteractionEnabled = YES;
    self.avatar = avatar;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarTap:)];
    [avatar addGestureRecognizer:tap];
    
    UILabel *nameLabel = [ELUtil createLabelFont:14 color:[UIColor whiteColor]];
    nameLabel.text = @"";
    [bgView addSubview:self.nameLabel = nameLabel];
    self.nameLabel = nameLabel;
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView addSubview:bottomView];
    
    UILabel *goodLabel = [ELUtil createLabelFont:14.f color:[UIColor whiteColor]];
    goodLabel.text = @"商品收藏";
    goodLabel.tag = 1111;
    goodLabel.userInteractionEnabled = YES;
    [bottomView addSubview:goodLabel];
    
    UILabel *storeLabel = [ELUtil createLabelFont:14.f color:[UIColor whiteColor]];
    storeLabel.text = @"店铺收藏";
    storeLabel.tag = 2222;
    storeLabel.userInteractionEnabled = YES;
    [bottomView addSubview:storeLabel];
    
    UILabel *goodCount = [ELUtil createLabelFont:14.f color:[UIColor whiteColor]];
    goodCount.text = @"0";
    goodCount.tag=3333;
    goodCount.userInteractionEnabled = YES;
    goodCount.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:self.goodCount = goodCount];
    
    UILabel *shopCount = [ELUtil createLabelFont:14.f color:[UIColor whiteColor]];
    shopCount.text = @"0";
    shopCount.tag = 4444;
    shopCount.userInteractionEnabled = YES;
    shopCount.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:self.shopCount  = shopCount];
    
    
    UITapGestureRecognizer *goodTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [goodLabel addGestureRecognizer:goodTap];
    
    
    UITapGestureRecognizer *goodCountTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [goodCount addGestureRecognizer:goodCountTap];
    

    
    UITapGestureRecognizer *shopTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [storeLabel addGestureRecognizer:shopTap];
    
    UITapGestureRecognizer *shopCountTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [shopCount addGestureRecognizer:shopCountTap];
    
    WS(ws);
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(185));
    }];
    
    [avatar makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(64);
        make.size.equalTo(imageSize);
    }];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatar.bottom).offset(5);
        make.centerX.equalTo(bgView);
    }];
    
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.height.equalTo(44);
    }];
    
    [goodLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView).multipliedBy(2.0/3);
        make.top.equalTo(bottomView.centerY).offset(2);
    }];
    
    [storeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView).multipliedBy(3.0/2);
        make.top.equalTo(goodLabel);
    }];
    
    [goodCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(goodLabel);
        make.bottom.equalTo(bottomView.centerY).offset(-2);
        make.width.equalTo(goodLabel);
    }];
    
    [shopCount makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(goodCount);
        make.centerX.equalTo(storeLabel);
        make.width.equalTo(storeLabel);

    }];
    
    
//    UIButton *rightTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightTopBtn setImage:[UIImage imageNamed:@"ic_notice"] forState:UIControlStateNormal];
//    [rightTopBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:rightTopBtn];
//    rightTopBtn.userInteractionEnabled = YES;
//    [rightTopBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-10);
//        make.top.equalTo(60);
//    }];

}
-(void)drawRect:(CGRect)rect{
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.height/2;

}
-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[DBUserInfo class]]) {
       DBUserInfo *userInfoModel = (DBUserInfo*)self.data;
        self.nameLabel.text = userInfoModel.account;
        if (userInfoModel.avatarUrl.length>0) {
            [self.avatar sd_setImageWithURL:ELIMAGEURL(userInfoModel.avatarUrl)];
        }
        self.goodCount.text = userInfoModel.collection_num;
        self.shopCount.text = userInfoModel.collection_shop_num;
    }
}




-(void)tap:(UITapGestureRecognizer*)tap{
    if (tap.view.tag==1111 || tap.view.tag==3333) {
        if ([self.delegate respondsToSelector:@selector(clickGoodsAtIndex:)] ){
            [self.delegate clickGoodsAtIndex:0];

        }
    }else{
        if ([self.delegate respondsToSelector:@selector(clickGoodsAtIndex:)] ){
            [self.delegate clickGoodsAtIndex:1];
            
        }
    }

}


-(void)avatarTap:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(avatarTaps)]) {
        [self.delegate avatarTaps];
    }

}
//-(void)click:(UIButton*)btn{
//    if ([self.delegate respondsToSelector:@selector(messageClick)] ){
//        [self.delegate messageClick];
//        
//    }
//
//}
@end
