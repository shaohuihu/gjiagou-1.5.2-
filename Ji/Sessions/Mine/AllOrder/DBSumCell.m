//
//  DBSumCell.m
//  Ji
//
//  Created by ssgm on 16/5/31.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBSumCell.h"
#import "DBOrder.h"
@implementation DBSumCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)o_configViews{
    self.sumLabel = [ELUtil createLabelFont:13 color:EL_TextColor_Dark];
    self.sumLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.sumLabel];

    WS(ws);
    [self.sumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-5);
        make.centerY.equalTo(ws.contentView);
    }];
    
    self.sumLabel.text = @"共1件商品 合计￥110元含运费(￥0.0)";
}


-(void)o_dataDidChanged{
    if ([self.data isKindOfClass:[DBOrder class]]) {
        DBOrder *order = self.data;
        NSString *countMoney = [NSString stringWithFormat:@"%.2f",order.countMoney];
        NSString *shipping = [NSString stringWithFormat:@"%.2f",order.shipping];
        
        NSString *mes = [NSString stringWithFormat:@"共%lu件商品 合计￥%@元含运费(￥%@)",(long)order.amount,DBPRICE(countMoney),DBPRICE(shipping)];
        self.sumLabel.text = mes;
    }

}
@end
