//
//  DBPingjiaContentCell.m
//  Ji
//
//  Created by ssgm on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPingjiaContentCell.h"

@implementation DBPingjiaContentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)o_configViews{

    _pinglunImageView = [UIImageView new];
    [self.contentView addSubview:_pinglunImageView];
    
    _textView = [UITextView new];
    _textView.font = kFont_System(14);
    _textView.textColor = EL_TextColor_Dark;
    _textView.delegate  =self;
    [self.contentView addSubview:_textView];
    
    _tipLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    _tipLabel.text = @"请写下评论，为其他小伙伴提供参考~";
    _tipLabel.numberOfLines =2;
    [_textView addSubview:_tipLabel];
    WS(ws);
    [_pinglunImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(ws.contentView);
        make.height.equalTo(kRadioValue(70));
        make.width.equalTo(kRadioValue(70));
        make.height.equalTo(ws.contentView).offset(-20);
    }];
    

    [_tipLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(8);
        make.left.equalTo(4);
        make.right.equalTo(0);
    }];
    
}

-(void)remakeConstraints{
    
    if (_pinglunImageView.image==nil) {
        _textView.frame = CGRectMake(5, 5, SCREEN_WIDTH-5, kRadioValue(80));

    }else{
        _textView.frame = CGRectMake(10+kRadioValue(70)+10, 5, SCREEN_WIDTH-20-kRadioValue(70)-5, kRadioValue(70));

    }
    
    if (_textView.text.length==0) {
        _tipLabel.hidden = NO;
    }else{
        _tipLabel.hidden = YES;
    }


}
-(void)o_dataDidChanged{



}

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length==0) {
        _tipLabel.hidden = NO;
    }else{
        _tipLabel.hidden = YES;
    }

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}

@end
