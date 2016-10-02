//
//  ELGoodsCommentCell.m
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodsCommentCell.h"
#import "ELGoodsCommentModel.h"
#import "ELGoodsDetailModel.h"
#import "NSDate+Helper.h"
@interface ELGoodsCommentCell ()

@property (nonatomic, weak) UILabel *commentLabel;
@property (nonatomic, weak) UILabel *phoneLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIImageView *commentImage;
@property (nonatomic, weak) UIButton *button;

@end

@implementation ELGoodsCommentCell

- (void)o_configViews {
    UILabel *titleLabel = [ELUtil createLabelFont:15.f color:EL_TextColor_Dark];
    titleLabel.text = @"全部(0)";
    [self.contentView addSubview:self.titleLabel = titleLabel];
    
    UILabel *phoneLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [self.contentView addSubview:self.phoneLabel = phoneLabel];
    
    UILabel *commentLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    commentLabel.numberOfLines= 0;
    [self.contentView addSubview:self.commentLabel = commentLabel];
    
    UIImageView *commentImage = [UIImageView new];
    commentImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.commentImage = commentImage];

    UILabel *detailLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel = detailLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"ic_butn_line_2"] forState:UIControlStateNormal];
    [button setTitle:@"查看全部" forState:UIControlStateNormal];
    [button setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
    button.titleLabel.font = kFont_System(13.f);
    [button addTarget:self action:@selector(onButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button = button];
    
    WS(ws);
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(13);
        make.top.equalTo(12.);
    }];
    
    [phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.bottom).offset(20);
    }];
    
    [commentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.equalTo(ws.contentView).offset(-13);
        make.top.equalTo(phoneLabel.bottom).offset(8);
    }];
    
    [self.commentImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleLabel);
        make.width.equalTo(kRadioXValue(100));
        make.top.equalTo(ws.commentLabel.bottom).offset(10);
        make.height.equalTo(self.commentImage.width);
    }];
    
    
}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        ELGoodsCommentModel *cmodel = self.data[@"comment"];
        NSNumber *count = self.data[@"count"];
        if (count) {
            self.titleLabel.text = [NSString stringWithFormat:@"全部(%@)",count];
        }
        if (cmodel) {
            NSString *account = [cmodel.account stringByReplacingCharactersInRange:NSMakeRange(1, cmodel.account.length -2) withString:@"****"];
            self.phoneLabel.text = account;
            self.commentLabel.text = cmodel.content;
            self.detailLabel.text = [NSString stringWithFormat:@"%@ %@",[self getFriendTime:cmodel.createDate] ,cmodel.standard];
            
            WS(ws);
            [self.detailLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.titleLabel);
                make.right.equalTo(ws.contentView).offset(-13);
                if (cmodel.image.length > 0) {
                    make.top.equalTo(ws.commentImage.bottom).offset(10);
                }else{
                    make.top.equalTo(ws.commentLabel.bottom).offset(10);
                }
            }];
            
            [self.button makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(ws.detailLabel.bottom).offset(15);
                make.centerX.equalTo(ws.contentView);
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
}


- (void)onButtonTap {
    if ([self.delegate respondsToSelector:@selector(commentCellTapToCheckAll)]) {
        [self.delegate commentCellTapToCheckAll];
    }
}

- (NSString *)getFriendTime:(long)timestr{
    time_t current_time = time(NULL);
    
    time_t this_time = timestr/1000;

    time_t seconds = current_time - this_time;
    
    long minutes = seconds/60;
    long hours = minutes/60;
    long days = hours/24;
    
    
    if ( seconds <= 15 )
    {
        return @"刚刚";
    }
    else if ( seconds < 60 )
    {
        return [NSString stringWithFormat:@"%ld秒前",seconds];
    }
    else if ( seconds < 120 )
    {
        return @"1分钟前";
    }
    else if ( minutes < 60 )
    {
        return [NSString stringWithFormat:@"%ld分钟前",minutes];
    }
    else if ( minutes < 120 )
    {
        return @"1小时前";
    }
    else if ( hours < 24 )
    {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    else if ( hours < 24 * 2 )
    {
        return @"1天前";
    }
    else if ( days < 30 )
    {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    else
    {
        return [[NSDate dateWithTimeIntervalSince1970:timestr] formate:@"yyyy年MM月dd日"];
    }
    
}

@end
