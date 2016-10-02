//
//  CustomSheetView.m
//  KeGoal
//
//  Created by sbq on 16/2/16.
//  Copyright © 2016年 sbq. All rights reserved.
//

#import "CustomSheetView.h"
@implementation CustomSheetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.upView.layer.masksToBounds = YES;
    self.upView.layer.cornerRadius = 5.0;
    self.downView.layer.masksToBounds = YES;
    self.downView.layer.cornerRadius = 5.0;
    self.backgroundColor = ALPHA_BG_COLOR;
}

-(void)initCustomSheetWithTipString:(NSString*)tipMessage andSureMessage:(NSString*)sureMessage andCancelMessage:(NSString*)cancelMessage {
    if (tipMessage.length==0 &&sureMessage.length==0 && cancelMessage.length==0 ) {
        return;
    }
    self.tipMessageLabel.text = tipMessage;
    [self.sureBtn setTitle:sureMessage forState:UIControlStateNormal];
    [self.cancelBtn setTitle:cancelMessage forState:UIControlStateNormal];
    [self show];
}
-(void)show{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
        self.backgroundColor = ALPHA_BG_COLOR;
    } completion:^(BOOL finished) {
        
    }];
}



- (IBAction)sureBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(customSheetView:clickAtIndex:)]) {
        [self.delegate customSheetView:self clickAtIndex:1];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (IBAction)cancelBtnClick:(id)sender {

    
    if ([self.delegate respondsToSelector:@selector(customSheetView:clickAtIndex:)]) {
        [self.delegate customSheetView:self clickAtIndex:0];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
