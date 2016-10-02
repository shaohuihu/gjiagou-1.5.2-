//
//  ELGoodsTableView.h
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELGoodsDetailModel;
@class ELGoodsCommentModel;
@class ELGoodsTableView;

@protocol ELGoodsTableViewDelegate <NSObject>

@optional
- (void)goodsViewClickToCheckAllComments;
- (void)goodsViewStandardClick;

//shop
- (void)goodsViewOnContactTap;
- (void)goodsViewOnShopInfoTap;
- (void)goodsViewOnShopCategoryTap;

//分享
-(void)doshare;

@end

@interface ELGoodsTableView : UITableView

@property (nonatomic, weak  ) ELGoodsDetailModel *goodsDetailModel;
@property (nonatomic, strong) ELGoodsCommentModel *goodsCommentModel;
@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, weak) id<ELGoodsTableViewDelegate> goodsDelegate;

- (void)setGoodsCommentModel:(ELGoodsCommentModel *)goodsCommentModel commentCount:(NSInteger)commentCount;
@end
