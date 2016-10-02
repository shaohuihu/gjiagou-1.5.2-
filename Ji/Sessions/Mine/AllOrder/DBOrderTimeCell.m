//
//  DBOrderTimeCell.m
//  Ji
//
//  Created by ssgm on 16/6/1.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBOrderTimeCell.h"

@implementation DBOrderTimeCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    
    self.leftLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Light];
    [self.contentView addSubview:self.leftLabel];
    WS(ws);
    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(kRadioValue(30));
        make.height.equalTo(ws.contentView);
    }];
    
}


-(void)o_dataDidChanged{
    
    if ([self.data isKindOfClass:[NSString class]]) {
        self.leftLabel.text = self.data;
     
        
    }
    
}
@end
