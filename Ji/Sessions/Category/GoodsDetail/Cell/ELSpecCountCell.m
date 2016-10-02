//
//  ELSpecCountCell.m
//  Ji
//
//  Created by evol on 16/6/2.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELSpecCountCell.h"

@interface ELSpecCountCell (){
    NSString *textS;
    UIView *view ;
    UIButton *addButton;
    UIButton *delButton;
    UITextField * textField;
}

@property (nonatomic, weak) UILabel *countLabel;
//这个是我改动的地方，我把原来的label，换成textField
@property(nonatomic,weak)UITextField * textField;

@end

@implementation ELSpecCountCell

- (void)o_configViews {
    //在这里注册一个接受库存的通知
    //注册通知
    //
    
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
#pragma mark-我在这里面注册了通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    //监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //添加手势点击空白处键盘消失
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.contentView addGestureRecognizer:tapGestureRecognizer];
    

    
   
    
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
   view = [UIView new];
  
    [self.contentView addSubview:view];
    
    UILabel *fixLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    fixLabel.text = @"购买数量";
    [self.contentView addSubview:fixLabel];
    
    
    [fixLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.contentView);
    }];
    //这个是添加数量的按钮
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"ic_plus_add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(onAddTap) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addButton];
    //这个是减少数量的按钮
    delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delButton setImage:[UIImage imageNamed:@"ic_plus_jian"] forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(onDelTap) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:delButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_plus_1"]];
    [self.contentView addSubview:imageView];
    
//    UILabel *countLabel = [ELUtil createLabelFont:14 color:EL_TextColor_Dark];
//    
//     countLabel.text = @"1";
//    
//    [imageView addSubview:self.countLabel = countLabel];
#warning 这里有我改动的地方，我把label换成textfield
    //初始化一个输入框
 textField=[[UITextField alloc]init];
    textField.text=@"1";
    textField.font=[UIFont systemFontOfSize:14];
    textField.textColor=EL_TextColor_Dark;
    textField.borderStyle=UITextBorderStyleNone;
    //添加键盘的样式
    textField.keyboardType=UIKeyboardTypeNumberPad;//数字全键盘
    textField.textAlignment=NSTextAlignmentCenter;
    //设置方法直接兼职textfield值得改变
    [textField addTarget:self  action:@selector(TFValueChanged)  forControlEvents:UIControlEventAllEditingEvents];
    //[imageView addSubview:self.textField = textField];
    [self.contentView addSubview:self.textField=textField];
    
        

    
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(70);
        make.edges.equalTo(self.contentView);
    }];
    
    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        //make.right.equalTo(self.contentView).offset(-8);
        make.centerY.equalTo(self.contentView);
        
    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addButton.left).offset(-1);
        make.centerY.equalTo(self.contentView);
        
        make.width.equalTo(40);
    }];
    
    [delButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageView.left).offset(-1);
        make.centerY.equalTo(self.contentView);
       
        
    }];
    
    
#warning 这里我把原来label的屏幕适配换成了textfield
//    [countLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(imageView);
//    }];
    
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imageView);
        make.height.equalTo(40);
        make.width.equalTo(30);
    }];
   // DDLog(@"时刻监听textfield的数值%@",textField.text);
    
    
    
    
}
////键盘出现的方法
-(void)keyboardWasShown:(NSNotification * )note{
    
    NSString * tagS=@"1";
    NSUserDefaults * keyboardNSU=[NSUserDefaults standardUserDefaults];
    [keyboardNSU setObject:tagS forKey:@"keyboard"];

    
      DDLog(@"我在cell里面监听到了键盘出现了");
    
    
    
    
}

- (void)tongzhi:(NSNotification *)text{
    
    NSLog(@"－－－－－接收到通知------");
    NSString *stockS=text.userInfo[@"stock"];
    DDLog(@"在接收到的通知的方法里打印库存%@",stockS);
    DDLog(@"在接收到通知的方法里打印textField%@",textField.text);
   

    [self TFValueChanged];
    
}


#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
//    NSString * str=@"0";
//    
//    NSUserDefaults * shareNameNSU=[NSUserDefaults standardUserDefaults];
//    [shareNameNSU setObject:str forKey:@"tagN"];
//    
//    [view makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(70);
//        make.edges.equalTo(self.contentView);
//    }];
    DDLog(@"我在cell里面监听到了键盘消失");
        
}


////取消键盘的方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    //[text resignFirstResponder];
    //    for (UIView * view in [self.view subviews]) {
    //        [view removeFromSuperview];
    //    }
    //    [self o_configViews];
    DDLog(@"我cell里面点击了空白的地方取消键盘");
    
//    NSString * tagS=@"";
//    NSUserDefaults * keyboardNSU=[NSUserDefaults standardUserDefaults];
//    [keyboardNSU setObject:tagS forKey:@"keyboard"];
//
//    
//    CGFloat CX=self.contentView.frame.origin.x;
//    CGFloat CY=self.contentView.frame.origin.y;
//    CGFloat CWith=self.contentView.frame.size.width;
//    CGFloat CHeight=self.contentView.frame.size.height;
//    DDLog(@"xYWH的坐标%f,%f,%f,%f",CX,CY,CWith,CHeight);
//    self.contentView.frame=CGRectMake(CX, CY, CWith, CHeight);
//    [self.contentView setNeedsDisplay];

   // [_textField resignFirstResponder];
    
//    NSUserDefaults *storgerNum=[NSUserDefaults standardUserDefaults];
//    NSString * storegerSS=[storgerNum objectForKey:@"storgerNum"];
//    NSInteger storegerNI=[storegerSS integerValue];
    
    
   
    
}



//这个方法是监听textField值得变化
-(void)TFValueChanged{
   //storgerNum
    NSUserDefaults *storgerNum=[NSUserDefaults standardUserDefaults];
    NSString * storegerSS=[storgerNum objectForKey:@"storgerNum"];
    NSInteger storegerNI=[storegerSS integerValue];
    
    DDLog(@"这个商品的存库量%ld",(long)storegerNI);
    NSInteger textNI=[_textField.text integerValue];
    if (textNI==0) {
         [self el_makeToast:@"请输入大于0的商品数量"];
    }
    
    
    
    
    if (textNI>storegerNI) {
        _textField.text=[NSString stringWithFormat:@"%ld",(long)storegerNI];
        addButton.enabled=NO;
        NSString * showS=[NSString stringWithFormat:@"您最多只能买%ld件",(long)storegerNI];
     [self el_makeToast:showS];
        
    }
   
   
    
    DDLog(@"textfield的值改变了%@",_textField.text);
    if (addButton.selected==NO && delButton.selected==NO) {
        textS=_textField.text;
        NSInteger count = textS.integerValue;
        
        // self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)count];
        if ([self.delegate respondsToSelector:@selector(countCellDidChange:)]) {
            [self.delegate countCellDidChange:count];
        }
        
        if ([self.delegate respondsToSelector:@selector(getOriginCount)]) {
            self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.delegate getOriginCount]];
            DDLog(@"在规格里面测试一下这个textField:%ld",self.textField.text.integerValue);
            
#warning 这里也有改动
            // self.textField.text = [NSString stringWithFormat:@"%ld",(long)[self.delegate getOriginCount]];
            
            
        }

    }
    
    

    
}
//这个是点击规格走的方法
- (void)o_dataDidChanged {
    if ([self.delegate respondsToSelector:@selector(getOriginCount)]) {
       self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.delegate getOriginCount]];
DDLog(@"在规格里面测试一下这个textField:%ld",self.textField.text.integerValue);
        
#warning 这里也有改动
       // self.textField.text = [NSString stringWithFormat:@"%ld",(long)[self.delegate getOriginCount]];
       
        
    }
}

- (void)onAddTap {
    
    
    NSUserDefaults *storgerNum=[NSUserDefaults standardUserDefaults];
    NSString * storegerSS=[storgerNum objectForKey:@"storgerNum"];
    NSInteger storegerNI=[storegerSS integerValue];
    
#warning 这里也有改动的地方
   // NSInteger count = self.countLabel.text.integerValue;
    DDLog(@"在加法里面测试一下这个textField:%ld",self.textField.text.integerValue);
    NSInteger count = self.textField.text.integerValue;
    if (count>=storegerNI) {
        addButton.enabled=NO;
        
    }
    else{
        
        count++;
    }
   // count++;
    DDLog(@"加完之后的%ld",(long)count);
//    if (count>=storegerNI-1) {
//        addButton.enabled=NO;
//       
//        
//    }
//    else{
//        addButton.enabled=YES;
//    }
   // self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
     self.textField.text = [NSString stringWithFormat:@"%ld",(long)count];
    if ([self.delegate respondsToSelector:@selector(countCellDidChange:)]) {
        [self.delegate countCellDidChange:count];
    }
}

- (void)onDelTap {
#warning 这里也有我改动的地方
    
    //NSInteger count = self.countLabel.text.integerValue;
        NSInteger count = self.textField.text.integerValue;
    DDLog(@"在减法里面测试一下textField的值%ld",self.textField.text.integerValue);
    if (count == 1) {
        return;
    }
    count--;
  
    //self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)count];
    if ([self.delegate respondsToSelector:@selector(countCellDidChange:)]) {
        [self.delegate countCellDidChange:count];
    }
    NSUserDefaults *storgerNum=[NSUserDefaults standardUserDefaults];
    NSString * storegerSS=[storgerNum objectForKey:@"storgerNum"];
    NSInteger storegerNI=[storegerSS integerValue];
    if (count<storegerNI) {
        addButton.enabled=YES;
    }
}
-(void)dealloc{
    DDLog(@"1111111111111");
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    

}

@end
