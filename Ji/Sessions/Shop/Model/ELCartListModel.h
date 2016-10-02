//
//  ELCartListModel.h
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELCartGoodsModel;
@interface ELCartListModel : NSObject


@property (nonatomic, strong) NSArray<ELCartGoodsModel *> *goodslist;

@property (nonatomic, assign) NSInteger shopId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, strong) NSMutableArray *goods;

@end
@interface ELCartGoodsModel : NSObject

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, assign) NSInteger goods_number;

@property (nonatomic, assign) NSInteger isSelect;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger subtotal;

@property (nonatomic, assign) NSInteger market_price;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, assign) double postage;

@property (nonatomic, assign) double goods_price;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *goods_attr;

@property (nonatomic, assign) NSInteger rec_id;

@end

