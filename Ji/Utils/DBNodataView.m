
//
//  DBNodataView.m
//  Ji
//
//  Created by ssgm on 16/5/26.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBNodataView.h"

@implementation DBNodataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_configView];
    }
    return self;
}


//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self p_configView];
//    }
//    return self;
//}

-(void)p_configView {
    self.backgroundColor = [UIColor whiteColor];
    
    self.iconImageView = [UIImageView new];
    [self addSubview:self.iconImageView];
    
    self.upLabel=[ELUtil createLabelFont:15 color:EL_TextColor_Dark];
    self.upLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.upLabel];
    
    self.downLabel=[ELUtil createLabelFont:14 color:EL_TextColor_Light];
    self.downLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.downLabel];
    
    
    UIImage *btnImage = [UIImage imageNamed:@"ic_butn_addAddess"];
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"ic_butn_addAddess"] forState:UIControlStateNormal];
    self.addBtn.titleLabel.font = kFont_System(15);
    [self.addBtn setTitleColor:EL_TextColor_Dark forState:UIControlStateNormal];
    [self addSubview:self.addBtn];
    
    WS(ws);
    [self.iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(70);
        make.centerX.equalTo(ws.centerX);
        make.width.equalTo(ws.iconImageView.width);
        make.height.equalTo(ws.iconImageView.height);
    }];
    
    
    [self.upLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.iconImageView.bottom).offset(5);
        make.width.equalTo(300);
        make.height.equalTo(25);
        make.centerX.equalTo(ws);
    }];
    [self.downLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.upLabel.bottom).offset(10);
        make.width.equalTo(ws.upLabel.width);
        make.height.equalTo(ws.upLabel.height);
        make.centerX.equalTo(ws);
        
    }];
    
    [self.addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.downLabel.bottom).offset(10);
        make.centerX.equalTo(ws);
        make.width.equalTo(btnImage.size.width+40);
        make.height.equalTo(btnImage.size.height+10);
        
    }];
    
    [self.addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setImage:(NSString *)imageName andUpLabel:(NSString *)upLabel andDownLabel:(NSString *)downLabel andBtn:(NSString *)btnName{
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.upLabel.text = upLabel;
    self.downLabel.text = downLabel;
    if (btnName == nil || btnName.length == 0) {
        self.addBtn.hidden = YES;
    }else{
        [self.addBtn setTitle:btnName forState:UIControlStateNormal];
    }
}
-(void)addClick:(UIButton*)btn{
    if (self.addClickBlock) {
        self.addClickBlock(btn);
    }
}
@end
