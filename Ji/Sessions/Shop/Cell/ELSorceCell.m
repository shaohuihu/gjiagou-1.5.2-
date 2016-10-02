//
//  ELSorceCell.m
//  Ji
//
//  Created by 谢威 on 16/8/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELSorceCell.h"


@interface ELSorceCell ()



@end

@implementation ELSorceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.iconBtn.selected = YES;
    }else{
        self.iconBtn.selected = NO ;
    }
    
}



@end
