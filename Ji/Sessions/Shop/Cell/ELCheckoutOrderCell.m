//
//  ELCheckoutOrderCell.m
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCheckoutOrderCell.h"
#import "ELCartListModel.h"
#import "ELCheckoutItemView.h"

@interface ELCheckoutOrderCell ()

@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *totalLabel;
@property (nonatomic, weak) UIView *detailView;

@end

@implementation ELCheckoutOrderCell
#pragma mark-一开始生成的订单明细
- (void)o_configViews {
    UILabel *label = [ELUtil createLabelFont:16.f color:EL_TextColor_Dark];
    label.text = @"订单明细";
    [self.contentView addSubview:self.topLabel = label];
    
    UIView *detailView = [[UIView alloc] init];
    [self.contentView addSubview:self.detailView = detailView];
    
    //总计
    UILabel *totalLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.totalLabel = totalLabel];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(13);
    }];
    
}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        NSArray<ELCartGoodsModel *> *goods = self.data[@"goods"];
        __block ELCheckoutItemView *lastView = nil;
        WS(ws);
        [goods enumerateObjectsUsingBlock:^(ELCartGoodsModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
            ELCheckoutItemView *view = [[ELCheckoutItemView alloc] init];
            view.model = good;
            [ws.detailView addSubview:view];
            
            [view makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.top.equalTo(lastView.bottom);
                }else{
                    make.top.equalTo(0);
                }
                make.left.right.equalTo(ws.detailView);
                if (idx == goods.count - 1) {
                    make.bottom.equalTo(ws.detailView);
                }
            }];
            lastView = view;
        }];
        
        NSNumber *count = self.data[@"count"];
        NSNumber *price = self.data[@"price"];
        NSNumber *post = self.data[@"post"];
        self.totalLabel.text = [NSString stringWithFormat:@"共%ld件商品 合计 ￥%.2f (含运费￥%.2f)",(long)count.integerValue,price.doubleValue,post.doubleValue];
    }
}


- (void)updateConstraints{
    [super updateConstraints];
    WS(ws);
    [self.detailView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.topLabel.bottom);
        make.left.right.equalTo(ws.contentView);
    }];
    [self.totalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-13);
        make.top.equalTo(ws.detailView.bottom).offset(15);
        make.bottom.equalTo(ws.contentView).offset(-15);
    }];
}

@end
