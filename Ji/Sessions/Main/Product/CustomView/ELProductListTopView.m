//
//  ELProductListTopView.m
//  Ji
//
//  Created by evol on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELProductListTopView.h"

@interface ELProductListTopView ()

@property (nonatomic, weak) UIButton *orderButton;
@end

@implementation ELProductListTopView
{
    UIButton *lastButton_;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}

- (void)p_setUp {
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderButton setTitle:@"综合排序" forState:UIControlStateNormal];
    [orderButton setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    [orderButton setTitleColor:EL_MainColor forState:UIControlStateSelected];
    [orderButton setImage:[UIImage imageNamed:@"ic_drop_down_gray"] forState:UIControlStateNormal];
    [orderButton setImage:[UIImage imageNamed:@"ic_drop_down_red"] forState:UIControlStateSelected];
    [orderButton addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [orderButton setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, -40)];
    [orderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    orderButton.tag = 100;
    orderButton.titleLabel.font = kFont_System(14.f);
    orderButton.selected = YES;
    lastButton_ = orderButton;
    [self addSubview:self.orderButton = orderButton];
    
    UIButton *marketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [marketButton setTitle:@"销量优先" forState:UIControlStateNormal];
    [marketButton setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    [marketButton setTitleColor:EL_MainColor forState:UIControlStateSelected];
    [marketButton addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    marketButton.tag = 101;
    marketButton.titleLabel.font = kFont_System(14.f);
    [self addSubview:marketButton];

    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseButton setTitle:@"筛选" forState:UIControlStateNormal];
    [chooseButton setTitleColor:EL_TextColor_Light forState:UIControlStateNormal];
    [chooseButton setTitleColor:EL_MainColor forState:UIControlStateSelected];
    [chooseButton setImage:[UIImage imageNamed:@"ic_drop_down_gray"] forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:@"ic_drop_down_red"] forState:UIControlStateSelected];
    [chooseButton addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [chooseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -40)];
    [chooseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    chooseButton.tag = 102;
    chooseButton.titleLabel.font = kFont_System(14.f);
    [self addSubview:chooseButton];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = EL_Color_Line;
    [self addSubview:lineView];
    
    WS(ws);
    [orderButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws).multipliedBy(1.0/3);
        make.left.top.bottom.equalTo(ws);
    }];

    [marketButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws).multipliedBy(1.0/3);
        make.top.bottom.centerX.equalTo(ws);
    }];
    
    [chooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws).multipliedBy(1.0/3);
        make.right.top.bottom.equalTo(ws);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.equalTo(1);
    }];
}


- (void)onButtonTap:(UIButton *)button{
    if (lastButton_) {
        lastButton_.selected = NO;
    }
    button.selected = YES;
    lastButton_ = button;
    if (self.selectBlock) {
        self.selectBlock(button.tag - 100);
    }
}

- (void)setLeftButtonType:(NSInteger)tag
{
    if (tag == 0) {
        [self.orderButton setImage:[UIImage imageNamed:@"ic_drop_down_red"] forState:UIControlStateSelected];
    }else{
        UIImage *ratationImage = [self image:[UIImage imageNamed:@"ic_drop_down_red"] rotation:UIImageOrientationDown];
        [self.orderButton setImage:ratationImage forState:UIControlStateSelected];
    }
}

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
