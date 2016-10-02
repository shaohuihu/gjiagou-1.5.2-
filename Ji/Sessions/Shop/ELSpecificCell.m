//
//  ELSpecificCell.m
//  Ji
//
//  Created by 龙讯科技 on 16/9/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELSpecificCell.h"

@interface ELSpecificCell (){
    int i;
    UIButton * showBTN;
    
}

@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UILabel * infoLabel;



@end

@implementation ELSpecificCell
static i=0;
-(void)o_configViews{
    UILabel * titleLabel=[ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [self.contentView addSubview:self.titleLabel=titleLabel ];
    
     UILabel *infoLabel = [ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.infoLabel = infoLabel];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = EL_Color_Line;
    [self.contentView addSubview:lineView];
    
    WS(ws);
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        //make.left.equalTo(13);
        
        make.left.equalTo(44);
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
-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        
        self.titleLabel.text = self.data[@"title"];
        self.infoLabel. text = self.data[@"subTitle"];
        
        
                
        
        

        
        
        
    }
    
    
    
    
    
    
    
    
}
//按钮执行的方法
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
