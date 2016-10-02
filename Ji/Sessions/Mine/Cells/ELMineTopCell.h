//
//  ELMineTopCell.h
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@protocol ELMineTopCellDelegate <NSObject>

@optional
-(void)clickGoodsAtIndex:(NSInteger)index;

-(void)avatarTaps;
//-(void)messageClick;
@end

@interface ELMineTopCell : ELRootCell

-(void)setImageWithUrl:(NSString*)url;

@end
