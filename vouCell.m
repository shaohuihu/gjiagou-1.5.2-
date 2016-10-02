//
//  vouCell.m
//  Ji
//
//  Created by 龙讯科技 on 16/8/17.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "vouCell.h"
#import "VouModel.h"
@interface vouCell()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *useL;
@property (weak, nonatomic) IBOutlet UILabel *availableL;
//@property (weak, nonatomic) IBOutlet UIView *timeL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;

@end
@implementation vouCell


+(vouCell *)cellWithTableView:(UITableView *)tv{
    static NSString * identifier=@"tg_cell";
    vouCell * cell=[tv dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"vouCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
    
}
-(void)setModel:(VouModel *)model{
    _model=model;
    self.nameL.text=[model name];
    self.priceL.text=[model priceL];
    self.useL.text=[model use];
    self.availableL.text=[model available];
    self.timeL.text=[model time];
    self.moneyL.text=[model money];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
