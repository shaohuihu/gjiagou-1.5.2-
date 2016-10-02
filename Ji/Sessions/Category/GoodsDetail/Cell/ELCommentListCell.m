//
//  ELCommentListCell.m
//  Ji
//
//  Created by evol on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCommentListCell.h"
#import "ELGoodsCommentModel.h"
#import "NSDate+Helper.h"

@interface ELCommentListCell ()

@property (nonatomic, weak) UILabel *commentLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIImageView *commentImage;

@end

@implementation ELCommentListCell

- (void)o_configViews {
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = kFont_Bold(15.f);
    titleLabel.textColor = EL_TextColor_Dark;
    [self.contentView addSubview:self.titleLabel = titleLabel];
    
    UILabel *commentLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    commentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.commentLabel = commentLabel];
    
    UIImageView *commentImage = [UIImageView new];
    commentImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.commentImage = commentImage];
    
    UILabel *detailLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel = detailLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(13);
        make.top.equalTo(15.);
    }];
    
    [self.commentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.right.equalTo(ws.contentView).offset(-13);
        make.top.equalTo(ws.titleLabel.bottom).offset(8);
    }];

    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.bottom.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];

    [self.commentImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.width.equalTo(kRadioXValue(100));
        make.top.equalTo(ws.commentLabel.bottom).offset(10);
        make.height.equalTo(self.commentImage.width);
    }];

}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[ELGoodsCommentModel class]]) {
        ELGoodsCommentModel *cmodel = self.data;
        NSString *account = [cmodel.account stringByReplacingCharactersInRange:NSMakeRange(1, cmodel.account.length -2) withString:@"****"];
        self.titleLabel.text = account;
        self.commentLabel.text = cmodel.content;
        self.detailLabel.text = [NSString stringWithFormat:@"%@ %@",[self getFriendTime:cmodel.createDate], cmodel.standard];
        
        WS(ws);
        [self.detailLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.titleLabel);
            make.right.equalTo(ws.contentView).offset(-13);
            if (cmodel.image.length > 0) {
                make.top.equalTo(ws.commentImage.bottom).offset(10);
            }else{
                make.top.equalTo(ws.commentLabel.bottom).offset(10);
            }
            make.bottom.equalTo(ws.contentView).offset(-20);
        }];
        
        if (cmodel.image.length > 0) {
            [self.commentImage sd_setImageWithURL:ELIMAGEURL(cmodel.image) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
            self.commentImage.hidden = NO;
        }else{
            self.commentImage.hidden = YES;
        }

    }
}

- (NSString *)getFriendTime:(long)timestr{
    return [[NSDate dateWithTimeIntervalSince1970:timestr/1000] formate:@"yyyy年MM月dd日"];
}

@end
