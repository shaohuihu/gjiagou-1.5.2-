

//
//  ELGoodsBottomView.m
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGoodsBottomView.h"
#import "ELCheckoutBottomView.h"
@implementation ELGoodsBottomView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}


- (void)p_setUp {
    self.backgroundColor = EL_BackGroundColor;
    
    CGFloat width = self.el_height - 1;
    CGFloat longWith = (self.el_width - 3*width - 2)/2;
    NSArray *titles = @[@"客服",@"商铺",@"收藏"];
    __block UIButton *lastButton;
    [@[@"ic_contact",@"ic_shoping_supermarkert",@"ic_shoping_collect"] enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[idx] forState:UIControlStateNormal];
        [button setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
        if (idx == 2) {
            [button setImage:[UIImage imageNamed:@"ic_shoping_collected"] forState:UIControlStateSelected];
            self.collectButton = button;
        }
        [button setFrame:CGRectMake((width + 1)*idx, 1, width, width)];
        [button addTarget:self action:@selector(onPreButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = kFont_System(13.f);
        [button setBackgroundColor:[UIColor whiteColor]];
        button.tag = idx+100;
        [button setImageEdgeInsets:UIEdgeInsetsMake(-15, 15, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(10, -10, -15, 0)];
        
        [self addSubview:button];
        lastButton = button;
    }];
    
    UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopButton setBackgroundColor:UIColorFromRGB(0xf08939)];
    [shopButton setFrame:CGRectMake(lastButton.el_right, 0, longWith, self.el_height)];
    //这里面我做了一个改变原来是进行了一个协议
    [shopButton addTarget:self action:@selector(onShopTap) forControlEvents:UIControlEventTouchUpInside];
    //[shopButton addTarget:self action:@selector(onShopTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:shopButton];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyButton setBackgroundColor:UIColorFromRGB(0xcf2b28)];
    [buyButton setFrame:CGRectMake(shopButton.el_right, 0, longWith, self.el_height)];
    [buyButton addTarget:self action:@selector(onBuyTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyButton];

}


- (void)onPreButtonTap:(UIButton *)button {
    switch (button.tag-100) {
        case 0: //客服
        {
            if ([self.delegate respondsToSelector:@selector(bottomViewPersonServiceTap)]) {
                [self.delegate bottomViewPersonServiceTap];
            }
        }
            break;
        case 1:  //商铺
        {
            if ([self.delegate respondsToSelector:@selector(bottomViewOnCheckoutShopTap)]) {
                [self.delegate bottomViewOnCheckoutShopTap];
            }
        }
            break;
        case 2:  //收藏
        {
            if ([self.delegate respondsToSelector:@selector(bottomViewOnAddFavShopTap)]) {
                [self.delegate bottomViewOnAddFavShopTap];
            }
        }
            break;
            
        default:
            break;
    }
}
//这个加入购物车的方法
- (void)onShopTap {
    if ([self.delegate respondsToSelector:@selector(bottomViewOnJoinCartTap)]) {
        [self.delegate bottomViewOnJoinCartTap];
    }
}
//这个是立即购买的方法
- (void)onBuyTap {
    if ([self.delegate respondsToSelector:@selector(bottomViewOnCreateOrderTap)]) {
        [self.delegate bottomViewOnCreateOrderTap];
       
        
        
    }
}

@end
