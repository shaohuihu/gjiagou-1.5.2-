

//
//  ELDrawItemView.m
//  Ji
//
//  Created by evol on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELDrawItemView.h"
#import "EL0YuanModel.h"

@interface ELDrawItemView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *button;
@end

@implementation ELDrawItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setUp];
    }
    return self;
}

#pragma mark - Private

- (void)p_setUp{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageTap)]];
    [self addSubview:self.imageView = imageView];
    
    UILabel *label = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
    [self addSubview:self.label = label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [UIImage imageNamed:@"ic_butn_line_1"];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button setTitle:@"立即抽奖" forState:UIControlStateNormal];
    [button setTitleColor:EL_MainColor forState:UIControlStateNormal];
    button.titleLabel.font = kFont_System(14.f);
    [button addTarget:self action:@selector(onButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [self addSubview:self.button = button];
    
    WS(ws);
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        make.height.equalTo(imageView.width).multipliedBy(305.0/1180);
    }];
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).offset(-15);
        make.top.equalTo(imageView.bottom).offset(5);
        make.bottom.equalTo(ws).offset(-5);
        make.size.equalTo(img.size);
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(button);
        make.right.equalTo(button.left).offset(-20);
    }];
}

- (void)setType:(NSInteger)type{
    _type = type;
    if (type == 0) {
        [self.button setTitle:@"立即抽奖" forState:UIControlStateNormal];
    }else{
        [self.button setTitle:@"进入查看" forState:UIControlStateNormal];
    }
}


- (void)onButtonTap {
    if ([self.delegate respondsToSelector:@selector(itemViewDidSelectWithModel:)]) {
        [self.delegate itemViewDidSelectWithModel:self.model];
    }
}


- (void)onImageTap {
    if ([self.delegate respondsToSelector:@selector(itemViewImageDidTapWithModel:)]) {
        [self.delegate itemViewImageDidTapWithModel:self.model];
    }
}

- (void)setModel:(ELDrawtomModel *)model {
    _model = model;
    [self setTitle:model.goodsName image:model.goodsPicture];
}
- (void)setTitle:(NSString *)title image:(NSString *)image {
    self.label.text = title;
    [self.imageView sd_setImageWithURL:ELIMAGEURL(image)];
}

@end
