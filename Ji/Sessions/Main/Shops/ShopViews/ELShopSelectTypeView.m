//
//  ELShopSelectTypeView.m
//  Ji
//
//  Created by hushaohui on 16/10/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELShopSelectTypeView.h"

@interface ELShopSelectTypeView()
@property (nonatomic, weak)UIView *scrollLine;  ///<滑动线条
@property (nonatomic, weak)UIView *tempView;  ///<temViwe

@end
@implementation ELShopSelectTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)setupUI
{
   //视图1
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, self.frame.size.height)];
    view.tag = 100;
    [self addGesture:view];
    [self addSubview:view];
    
    UIImageView *imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width - 10)/2, 10, 10, 17)];
    [imageIcon setBackgroundColor:[UIColor redColor]];
    [view addSubview:imageIcon];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageIcon.frame)+10, view.frame.size.width, 17)];
    label.textColor = EL_TextColor_Light;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"店铺首页";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    //视图2
    view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, self.frame.size.height)];
    [self addGesture:view];
    view.tag = 101;
    [self addSubview:view];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,  SCREEN_WIDTH/3, 17)];
    label.textColor = EL_TextColor_Light;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"234132";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+10, view.frame.size.width, 17)];
    label.textColor = EL_TextColor_Light;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"全部商品";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    //视图3
    view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3 * 2, 0, SCREEN_WIDTH/3, self.frame.size.height)];
    [self addGesture:view];
    view.tag = 102;
    [self addSubview:view];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,  SCREEN_WIDTH/3, 17)];
    label.textColor = EL_TextColor_Light;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"261";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+10, view.frame.size.width, 17)];
    label.textColor = EL_TextColor_Light;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"上新";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    //上下分割线
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, 0, self.frame.size.width, .5);
    line.backgroundColor = EL_TextColor_Light.CGColor;
    [self.layer addSublayer:line];
    
    line = [CALayer layer];
    line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    line.backgroundColor = EL_TextColor_Light.CGColor;
    [self.layer addSublayer:line];
    
    
    //添加移动分割线
    UIView *scrollLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, SCREEN_WIDTH/3, 1)];
    scrollLine.backgroundColor = [UIColor redColor];
    [self addSubview:scrollLine];
    self.scrollLine = scrollLine;
}

- (void)addGesture:(UIView *)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
    [view addGestureRecognizer:tap];
}


#pragma mark 手势点击
- (void)gestureClick:(UIGestureRecognizer *)gesture
{
    if([gesture.view isEqual:self.tempView])
        return;
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectShopTypeView:typeIndex:)]){
        [self.delegate selectShopTypeView:self typeIndex:(gesture.view.tag - 100)];
    }
    [self updateUiWith:gesture.view];
    self.tempView = gesture.view;
}

- (void)updateUiWith:(UIView *)view
{
    
    for(UIView *subView in self.tempView.subviews){
        if([subView isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)subView;
            label.textColor = EL_TextColor_Light;
        }
    }
    

    for(UIView *subView in view.subviews){
        if([subView isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)subView;
            label.textColor = [UIColor redColor];
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        if(view.tag == 100){
            [self.scrollLine setEl_left:0];
        }else if (view.tag == 101){
            [self.scrollLine setEl_left:SCREEN_WIDTH/3];
        }else if (view.tag == 102){
            [self.scrollLine setEl_left:SCREEN_WIDTH/3 * 2];
        }
    }];
}

@end
