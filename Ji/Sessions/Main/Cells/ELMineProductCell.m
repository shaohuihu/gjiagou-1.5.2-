//
//  ELMineProductCell.m
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMineProductCell.h"
#import "ELProductDetailView.h"

@implementation ELMineProductCell

{
    UILabel *titleLabel_;
    UIView *contentView_;
}

- (void)o_configViews {
    titleLabel_ = [ELUtil createLabelFont:16 color:EL_TextColor_Dark];
    titleLabel_.backgroundColor = EL_BackGroundColor;
    titleLabel_.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel_];
    
    contentView_ = [UIView new];
    contentView_.backgroundColor = EL_BackGroundColor;
    [self.contentView addSubview:contentView_];
    
    WS(ws);
    [titleLabel_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.contentView);
        make.height.equalTo(40);
    }];
    
    [contentView_ makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.contentView);
        make.top.equalTo(titleLabel_.bottom);
    }];
    
    CGFloat width = (SCREEN_WIDTH - 2)/3;
    for (int i = 0; i < 3; i++) {
        ELProductDetailView *view = [ELProductDetailView new];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDetailViewTap:)]];
        view.tag = 100+i;
        [contentView_ addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(i*(width+1));
            make.top.bottom.equalTo(contentView_);
            make.width.equalTo(width);
        }];
    }
}

- (void)o_dataDidChanged {
    if ([self.data isKindOfClass:[ELMainProductModel class]]) {
        ELMainProductModel *model = self.data;
        
        titleLabel_.attributedText = [self getName:model.name];
        NSLog(@"******%@",titleLabel_.attributedText);
        for (int i = 0; i<3; i++) {
            ELProductDetailView *view = (ELProductDetailView *)[contentView_ viewWithTag:100+i];
            if (i < model.goodses.count) {
                view.hidden = NO;
                [view setGood:model.goodses[i]];
            }else{
                view.hidden = YES;
            }
        }
    }
}


- (void)onDetailViewTap:(UIGestureRecognizer *)sender
{
    ELProductDetailView *view = (ELProductDetailView *)sender.view;
    if ([self.delegate respondsToSelector:@selector(productCellDidSelectWithModel:)]) {
        [self.delegate productCellDidSelectWithModel:view.good];
    }
}

- (NSMutableAttributedString *)getName:(NSString *)name{
    NSArray *colors = @[UIColorFromRGB(0x4277bc),UIColorFromRGB(0x5f539e),UIColorFromRGB(0xf2aa13),UIColorFromRGB(0xe5388d),UIColorFromRGB(0x497ebf),UIColorFromRGB(0xed6c1b),UIColorFromRGB(0xce2c2a),UIColorFromRGB(0x5f53a0)];
    NSMutableAttributedString *str = [self attributeStringWithString:@"——— " font:14 color:colors[self.indexPath.row]];
    [str appendAttributedString:[self attributeStringWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_hot_icon_%ld",(long)self.indexPath.row]]]];
    [str appendAttributedString:[self attributeStringWithString:[@" " stringByAppendingString:name] font:14 color:colors[self.indexPath.row]]];
    [str appendAttributedString:[self attributeStringWithString:@" ———" font:14 color:colors[self.indexPath.row]]];
    return str;
}

- (NSAttributedString *)attributeStringWithImage:(UIImage *)image{
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    // 设置图片大小
    attch.image  = image;
    attch.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    return string;

}

- (NSMutableAttributedString *)attributeStringWithString:(NSString*)string font:(CGFloat)font color:(UIColor*)color
{
    NSMutableAttributedString *attributeString =[[NSMutableAttributedString alloc] initWithString:string];
    [attributeString setAttributes:@{NSForegroundColorAttributeName:color,
                                     NSFontAttributeName:[UIFont systemFontOfSize:font]
                                     }
                             range:NSMakeRange(0,[string length])];
    return attributeString;
}


@end
