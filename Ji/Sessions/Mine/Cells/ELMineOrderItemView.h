//
//  ELMineOrderItemView.h
//  Ji
//
//  Created by evol on 16/5/23.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELMineOrderItemView : UIButton

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *countLabel;

- (void)setTitle:(NSString*)title image:(NSString *)image count:(NSInteger)count;

@end
