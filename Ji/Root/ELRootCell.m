//
//  ELRootCell.m
//  WaiDian
//
//  Created by evol on 16/4/28.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@implementation ELRootCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self o_configViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self o_layoutViews];
}

- (void)setData:(id)data {
    _data = data;
    [self o_dataDidChanged];

}


- (void)setData:(id)data index:(NSIndexPath*)indexPath {
    _indexPath = indexPath;
    self.data = data;
}

#pragma mark - Sub Implement

- (void)o_configViews {}
- (void)o_layoutViews {}
- (void)o_dataDidChanged {};



@end
