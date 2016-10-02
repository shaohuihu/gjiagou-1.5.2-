//
//  ELDeliveryCell.m
//  Ji
//
//  Created by evol on 16/5/30.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELDeliveryCell.h"
#import "ELGoodsDetailModel.h"

@interface ELDeliveryCell ()

@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UILabel *feeLabel;

@end

@implementation ELDeliveryCell

- (void)o_configViews {
    UILabel *fix1 = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    fix1.text = @"同城配送";
    UILabel *fix2 = [ELUtil createLabelFont:14.f color:EL_TextColor_Light];
    fix2.text = @"快递";
    
    UILabel *addressLabel = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    UILabel *feeLabel      = [ELUtil createLabelFont:14.f color:EL_TextColor_Dark];
    
    [self.contentView addSubview:fix1];
    [self.contentView addSubview:fix2];
    
    [self.contentView addSubview:self.addressLabel = addressLabel];
    [self.contentView addSubview:self.feeLabel = feeLabel];
    
    
    WS(ws);
    [fix1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(13);
        make.top.equalTo(8);
    }];
    
    [fix2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fix1.bottom).offset(12);
        make.left.equalTo(fix1);
        make.bottom.equalTo(ws.contentView).offset(-8);
    }];
    
    [addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(fix1);
        make.left.equalTo(fix1.right).offset(15);
    }];
    
    [feeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(fix2);
        make.left.equalTo(fix2.right).offset(15);
    }];
}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[ELGoodsDetailModel class]]) {
        ELGoodsDetailModel *model = self.data;
//        NSString *areaName = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectCityName"];
//        if ([areaName isKindOfClass:[NSString class]] && areaName.length > 0) {
//            self.addressLabel.text = [NSString stringWithFormat:@"%@%@ 至 %@",model.goods.provinceName,model.goods.cityName,areaName];
//        }
        
        if (model.goods.postage == 0) {
            self.feeLabel.text = @"免运费";
        }else{
            self.feeLabel.text = [NSString stringWithFormat:@"%ld",(long)model.goods.postage];
        }
    }
}


@end
