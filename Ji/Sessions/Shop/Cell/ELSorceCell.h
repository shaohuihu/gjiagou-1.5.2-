//
//  ELSorceCell.h
//  Ji
//
//  Created by 谢威 on 16/8/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *ELSorceCellID = @"ELSorceCellID";
@interface ELSorceCell : ELRootCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@end
