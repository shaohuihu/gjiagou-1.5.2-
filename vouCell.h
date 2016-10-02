//
//  vouCell.h
//  Ji
//
//  Created by 龙讯科技 on 16/8/17.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VouModel;
@interface vouCell : UITableViewCell
@property(nonatomic,strong)VouModel * model;

+(vouCell *)cellWithTableView:(UITableView *)tv;
@end
