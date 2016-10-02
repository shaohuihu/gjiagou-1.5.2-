//
//  ELCheckoutBottomView.h
//  Ji
//
//  Created by evol on 16/6/6.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ELCheckoutBottomView : UIView

@property (nonatomic, copy) void(^checkoutBlock)();

- (void)setData:(NSDictionary *)data;

@end
