//
//  DBPingjiaContentCell.h
//  Ji
//
//  Created by ssgm on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELRootCell.h"

@interface DBPingjiaContentCell : ELRootCell<UITextViewDelegate>
@property(nonatomic,strong)UIImageView *pinglunImageView;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *tipLabel;

-(void)remakeConstraints;
@end
