//
//  DBOrderLabelCell.m
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBOrderLabelCell.h"

@implementation DBOrderLabelCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    CGFloat x=self.contentView.frame.origin.x;
    CGFloat y=self.contentView.frame.origin.y;
    CGFloat w=self.contentView.frame.size.width;
    CGFloat h=self.contentView.frame.size.height;
    
    self.leftLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.rightLabel];
    
//    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _commentBtn.titleLabel.font = kFont_System(12);
//    [_commentBtn setTitle:@"评价" forState:UIControlStateNormal];
//    
//    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"ic_butn_line_3"] forState:UIControlStateNormal];
//    [_commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [_commentBtn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_commentBtn];
    
    WS(ws);
//    [_commentBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(y);
//        make.right.equalTo(x).offset(-10);
//        make.height.equalTo(15);
//        make.width.equalTo(60);
//        
//
//    }];
    
    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView).offset(10);
        make.left.equalTo(5);
        make.height.equalTo(kRadioValue(30)).offset(10);
        make.height.equalTo(ws.contentView).offset(10);

    }];
    
    [self.rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView).offset(10);
        make.right.equalTo(-5);
        make.height.equalTo(kRadioValue(30)).offset(10);
        make.height.equalTo(ws.contentView).offset(10);
    }];
    

    
}


-(void)setLeft:(NSString *)left right:(NSString *)right{

    self.leftLabel.text  = left;
    self.rightLabel.text = right;
    if ([left isEqualToString:@"订单总价"]) {
        self.leftLabel.textColor = EL_TextColor_Dark;
        self.rightLabel.textColor = EL_TextColor_Dark;
    }else if ([left isEqualToString:@"实付款"]) {
        self.leftLabel.textColor = EL_TextColor_Dark;
        self.leftLabel.font = kFont_Bold(14);
        self.rightLabel.font = kFont_Bold(14);
        self.rightLabel.textColor = [UIColor redColor];
    }else{
        self.leftLabel.font = kFont_System(13);
        self.rightLabel.font = kFont_System(13);

        self.leftLabel.textColor = EL_TextColor_Light;
        self.rightLabel.textColor = EL_TextColor_Light;
    }

}
-(void)btn{
    
}
@end
