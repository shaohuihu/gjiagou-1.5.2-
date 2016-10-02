//
//  ELRemarkCell.m
//  Ji
//
//  Created by 龙讯科技 on 16/9/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRemarkCell.h"

@interface ELRemarkCell (){
    int i;
    UIButton * showBTN;
}

@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UILabel * infoLabel;


@end




@implementation ELRemarkCell
static i=0;
-(void)o_configViews{
    UILabel * titleLabel=[ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    [ self.contentView addSubview:self.titleLabel=titleLabel ] ;
    
    UILabel * infoLabel=[ELUtil createLabelFont:13.f color:EL_TextColor_Light];
    [self.contentView addSubview:self.infoLabel=infoLabel];
    UIView * lineView=[UIView new];
    lineView.backgroundColor=EL_Color_Line;
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
-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        self.titleLabel.text=self.data[@"title"];
        self.infoLabel.text=self.data[@"subTitle"];
        
    
    
    
    
    
}


}
    @end

