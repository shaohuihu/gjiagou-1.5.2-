//
//  ELSearchTextField.m
//  Ji
//
//  Created by evol on 16/5/27.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELSearchTextField.h"

@interface ELSearchTextField ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *searchIcon;
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation ELSearchTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUp];
    }
    return self;
}

- (void)p_setUp{
    
    self.delegate = self;
    self.font = kFont_System(14.f);
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_index_search_icon"]];
    [self addSubview:self.searchIcon = icon];
    
    UILabel *label = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    [self addSubview:self.placeholderLabel = label];
    WS(ws);
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(ws);
    }];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws);
        make.left.equalTo(icon.right).offset(5);
    }];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    self.searchIcon.hidden = self.placeholderLabel.hidden = YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.searchIcon.hidden = self.placeholderLabel.hidden = YES;
    if (self.beginEditing) {
        self.beginEditing();
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        self.searchIcon.hidden = self.placeholderLabel.hidden = NO;
    }
    
    if (self.textDidChange) {
        NSString *text = textField.text ?:@"";
        self.textDidChange(text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.completion) {
        NSString *text = textField.text ?:@"";
        self.completion(text);
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)setPlaceholder:(NSString *)placeholder{
    self.placeholderLabel.text = placeholder;
}

@end
