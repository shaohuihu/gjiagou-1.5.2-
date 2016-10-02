//
//  ActionSheetView.m
//  KeGoal
//
//  Created by sbq on 15/8/6.
//  Copyright (c) 2015年 sbq. All rights reserved.
//

#import "ActionSheetView.h"
#define ALPHA 0.7
@implementation ActionSheetView

-(id)initActionViewWithCancelMessage:(NSString*)cancelMessage ok1Message:(NSString*)ok1Message ok2Message:(NSString*) ok2Message{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.userInteractionEnabled = YES;
    self.cancelMessage = cancelMessage;
    self.ok1Message = ok1Message;
    self.ok2Message = ok2Message;
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.backgroundColor = ALPHA_BG_COLOR;
    }];
    
    if (self) {
        [self crateUI];
    }
    return self;
}

-(void)crateUI{
    //创建取消
    [self createItemsWithHeight:SCREEN_HEIGHT-60 andMessage:self.cancelMessage andTapIndex:CancelIndex];
    //创建ok2
    [self createItemsWithHeight:SCREEN_HEIGHT-118 andMessage:self.ok2Message andTapIndex:Ok2Index];
    //创建ok1
    [self createItemsWithHeight:SCREEN_HEIGHT-156 andMessage:self.ok1Message andTapIndex:Ok1Index];
    //创建分割线
    [self createLine];
}

-(void)createItemsWithHeight:(CGFloat)height andMessage:(NSString*)message andTapIndex:(TapIndex)index{
    UIView*  tmpView = [[UIView alloc]initWithFrame:CGRectMake(15, height, SCREEN_WIDTH-30, 46)];
    tmpView.backgroundColor = [UIColor whiteColor];
    tmpView.userInteractionEnabled = YES;
    tmpView.layer.cornerRadius = 5;
    tmpView.layer.masksToBounds = YES;
    tmpView.tag = index;
    [self addSubview:tmpView];
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [tmpView addGestureRecognizer:tap];
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tmpView.bounds.size.width, tmpView.bounds.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    if (SCREEN_WIDTH==414) {
        label.font = [UIFont systemFontOfSize:17];
    }else{
        label.font = [UIFont systemFontOfSize:15];
    }
    label.text = message;
    [tmpView addSubview:label];
}
-(void)createLine{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT-112-1.5, SCREEN_WIDTH-30, 1)];
    lineView.backgroundColor = RGBA(236, 236, 236, 1);
    [self addSubview:lineView];
}

#pragma mark---触发
-(void)tapClick:(UITapGestureRecognizer*)tap{
    
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickAtIndex:)]) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (tap.view.tag==CancelIndex) {
                [self.delegate actionSheet:self clickAtIndex:CancelIndex];
            }
            if (tap.view.tag==Ok1Index) {
                [self.delegate actionSheet:self clickAtIndex:Ok1Index];
            }
            if (tap.view.tag==Ok2Index) {
                [self.delegate actionSheet:self clickAtIndex:Ok2Index];
            }
            [self removeFromSuperview];
        }];
        
    }
}


@end
