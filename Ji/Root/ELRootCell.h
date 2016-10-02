//
//  ELRootCell.h
//  WaiDian
//
//  Created by evol on 16/4/28.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELRootCell : UITableViewCell

@property (nonatomic, strong) id data;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)setData:(id)data index:(NSIndexPath*)indexPath;

#pragma mark - Sub Implement
- (void)o_configViews;
- (void)o_layoutViews;
- (void)o_dataDidChanged;

@end
