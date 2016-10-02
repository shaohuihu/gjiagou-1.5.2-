//
//  ELCheckoutBottomCell.m
//  Ji
//
//  Created by evol on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELCheckoutBottomCell.h"

@interface ELCheckoutBottomCell (){
    int i;
    UIButton * showBTN;
  
   
}

@property (nonatomic, weak) UILabel *titleLabel;
/*****************这里有我改动的地方,将原来的label设置成按钮*****************************/
@property (nonatomic, weak) UILabel *infoLabel;
//@property(nonatomic,weak)UIButton * infoButton;

@end

@implementation ELCheckoutBottomCell
static i =0;
- (void)o_configViews {

    UILabel *titleLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [self.contentView addSubview:self.titleLabel = titleLabel];
/***********这里对于右边的那个详情的label进行下改变,将Label变成button*************************************/
    UILabel *infoLabel = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    //UIButton *infoButton = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
//    UIButton * infoButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [infoButton setTintColor:EL_TextColor_Light];
//   infoButton.titleLabel.font= [UIFont systemFontOfSize: 13.f];
    
    [self.contentView addSubview:self.infoLabel = infoLabel];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(13);
        //make.left.equalTo(26);
    }];
    
    [infoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-13);
        make.centerY.equalTo(ws.contentView);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.contentView);
        make.height.equalTo(0.5);
    }];
}



- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        self.titleLabel.text = self.data[@"title"];
      self.infoLabel. text = self.data[@"subTitle"];
    
        
//        if ([self.infoLabel.text isEqual:@""]) {
//
//            UIImageView * imageV=[[UIImageView alloc]init];
//            imageV.image=[UIImage imageNamed:@"ic_unchecked"];
//            [self.contentView addSubview:imageV];
//
//            WS(ws);
//            
//            [imageV makeConstraints:^(MASConstraintMaker *make) {
//                [imageV makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(ws.contentView).offset(-13);
//                    make.centerY.equalTo(ws.contentView);
//                }];
//                
//                
//            }];

       // }
      
        
        
    }
}
-(void)doCheck:sender{
    NSLog(@"点击了按钮");
    i+=1;
    DDLog(@"点击了多少次%d",i);
   
        
    if (i %2==1) {
      
           [showBTN setImage:[UIImage imageNamed:@"ic_checked"] forState:UIControlStateNormal];
        
        
        
        
    }
    else{

        [showBTN setImage:[UIImage imageNamed:@"ic_unchecked"] forState:UIControlStateNormal];
        
    }
    


    
    
}
@end
