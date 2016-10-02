//
//  ELMainCategoryCell.m
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMainCategoryCell.h"

@implementation ELMainCategoryCell

- (void)o_configViews {
    NSArray *titles = @[@"热卖",@"分期",@"电器城",@"济佳汇",@"热门店铺",@"本地特产",@"0元购",@"分类"];
    CGFloat margin = 25;
    CGFloat topMargin = 15;
    CGFloat buttonWidth = kRadioXValue(41);
    CGFloat itemHeight = buttonWidth + kRadioValue(35);
    CGFloat space  = (SCREEN_WIDTH - 2*margin - 4*buttonWidth)/3;
    WS(ws);
    UIView *view = [UIView new];
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
    }];
    
    [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"main_index_%ld",(unsigned long)idx]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = idx;
        [view addSubview:button];
        
        UILabel *label = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
        label.text = title;
        [view addSubview:label];
        /*
         * 对于Masonry的初探
            Masonry是以AutoLayout为基础的轻量级布局框架更加简化了整个约束系统
         
         */
        [button makeConstraints:^(MASConstraintMaker *make) {
            //让这个按钮的坐标和
            make.left.equalTo(margin+(idx%4*(buttonWidth +space)));
            make.top.equalTo(idx/4*itemHeight + topMargin);
            make.size.equalTo(CGSizeMake(buttonWidth, buttonWidth));
           
        }];
        
        if(idx == titles.count -1){
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.bottom).offset(10);
                make.centerX.equalTo(button);
                make.bottom.equalTo(view).offset(-margin);
                
            }];
        }else{
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.bottom).offset(10);
                make.centerX.equalTo(button);
            }];
        }
    }];
   
}

#pragma mark - Response

- (void)onButtonTap:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(cell:didSelectedIndex:)]) {
        [self.delegate cell:self didSelectedIndex:button.tag];
    }
}

@end
