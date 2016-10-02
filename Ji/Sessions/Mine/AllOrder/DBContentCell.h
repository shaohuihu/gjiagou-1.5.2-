//
//  DBContentCell.h
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
#import "DBOrder.h"
#import "DBOrderDetialModel.h"
@protocol ContentDelagte <NSObject>

-(void)commentBtnClick:(UIButton*)commentBtn;

@end

//货物内容cell
@interface DBContentCell : ELRootCell
@property(nonatomic,strong)UIImageView *avatarImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subTitleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UIButton *commentBtn;


@property(nonatomic,strong)NSString *vcTitle;
-(void)setCommtnBtn:(DBOrder *)order;
-(void)setShouhouBtn:(Order *)order and:(Goods_List*)good;
@end
