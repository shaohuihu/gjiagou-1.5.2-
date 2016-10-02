//
//  ELGoodsTopCell.h
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"
@protocol ELGoodsshareDelegate <NSObject>
@optional

- (void)doshare;


@end

@interface ELGoodsTopCell : ELRootCell
@property (nonatomic, copy) void(^checkoutBlock)();
@end
