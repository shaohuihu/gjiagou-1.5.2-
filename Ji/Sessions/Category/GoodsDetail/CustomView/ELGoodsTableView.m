//
//  ELGoodsTableView.m
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodsTableView.h"
#import "ELGoodsCommentModel.h"
#import "ELGoodsCommentCell.h"
#import "ELGoodsShopCell.h"
#import "ELGoodsTopCell.h"
@interface ELGoodsTableView ()<UITableViewDelegate,UITableViewDataSource,ELGoodsCommentCellDelegate,ELGoodsShopCellDelegate,ELGoodsshareDelegate>

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ELGoodsTableView

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self p_setUp];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self p_setUp];
    }
    return self;
}


#pragma mark - Setter 

- (void)setGoodsCommentModel:(ELGoodsCommentModel *)goodsCommentModel commentCount:(NSInteger)commentCount {
    _goodsCommentModel = goodsCommentModel;
    _commentCount = commentCount;
    [self reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Private 

- (void)p_setUp {
    _datas = @[@"ELGoodsTopCell",@"ELGoodsStandardCell",@"ELDeliveryCell",@"ELGoodsCommentCell",@"ELGoodsShopCell"];
    [self registerClasses:_datas];
    self.estimatedRowHeight = 44;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.delegate = self;
    self.dataSource = self;
}


#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:_datas[indexPath.section]];
    cell.delegate = self;
    if (indexPath.section == 3) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        if (self.goodsCommentModel) {
            [dict setObject:self.goodsCommentModel forKey:@"comment"];
            [dict setObject:@(self.commentCount) forKey:@"count"];
        }
        [cell setData:dict];
    }else{
        [cell setData:self.goodsDetailModel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if ([self.goodsDelegate respondsToSelector:@selector(goodsViewStandardClick)]) {
            [self.goodsDelegate goodsViewStandardClick];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kRadioValue(15);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


#pragma mark - ELGoodsCommentCellDelegate

- (void)commentCellTapToCheckAll{
    if ([self.goodsDelegate respondsToSelector:@selector(goodsViewClickToCheckAllComments)]) {
        [self.goodsDelegate goodsViewClickToCheckAllComments];
    }
}


#pragma mark - ELGoodsShopCellDelegate

- (void)shopCellOnContactTap
{
    if ([self.goodsDelegate respondsToSelector:@selector(goodsViewOnContactTap)]) {
        [self.goodsDelegate goodsViewOnContactTap];
    }
}
- (void)shopCellOnShopInfoTap
{
    if ([self.goodsDelegate respondsToSelector:@selector(goodsViewOnShopInfoTap)]) {
        [self.goodsDelegate goodsViewOnShopInfoTap];
    }
}
- (void)shopCellOnShopCategoryTap
{
    if ([self.goodsDelegate respondsToSelector:@selector(goodsViewOnShopCategoryTap)]) {
        [self.goodsDelegate goodsViewOnShopCategoryTap];
    }
}
-(void)doshare{
    if ([self.goodsDelegate respondsToSelector:@selector(doshare)]) {
        [self.goodsDelegate doshare];
    }
}

@end
