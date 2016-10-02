//
//  ELMineHotCell.m
//  Ji
//
//  Created by evol on 16/5/20.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMineHotCell.h"
#import "ELHotShopModel.h"
@interface ELMineHotCell ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation ELMineHotCell

- (void)o_configViews{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    UIView *scrollContent = [UIView new];
    
    [self.contentView addSubview:self.scrollView = scrollView];
    [scrollView addSubview:scrollContent];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat width = (SCREEN_WIDTH)/4;
    CGFloat height = width*7/8;
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView           = [UIImageView new];
        imageView.tag                    = 100+i;
        imageView.contentMode            = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageTap:)];
        tap.numberOfTapsRequired         = 1;
        [imageView addGestureRecognizer:tap];
        [scrollContent addSubview:imageView];
        
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(width, height));
            make.left.equalTo(i*(width +1));
            make.top.bottom.equalTo(scrollContent);
        }];
        
        if (i!=0) {
            UIView *lineView         = [UIView new];
            lineView.backgroundColor = EL_Color_Line;
            lineView.tag             = 200+i;
            [scrollContent addSubview:lineView];
            
            [lineView makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(imageView.left);
                make.top.equalTo(10);
                make.bottom.equalTo(scrollContent).offset(-10);
                make.width.equalTo(1);
            }];
        }
    }
    WS(ws);
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
    }];
    
    [scrollContent makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH*5/4 + 4);
        make.height.equalTo(scrollView);
    }];
}

- (void)o_dataDidChanged{
    if([self.data isKindOfClass:[NSArray class]]){
        NSArray *datas = self.data;
        self.scrollView.scrollEnabled = datas.count>4;
        for (int i = 0; i<5; i++) {
            UIImageView *img = [self.contentView viewWithTag:100+i];
            UIView *view = [self.contentView viewWithTag:200+i];
            if (i < datas.count) {
                img.hidden = NO;
                view.hidden = NO;
                ELHotShopModel *model = datas[i];
                if ([model isKindOfClass:[ELHotShopModel class]]) {
                    [img sd_setImageWithURL:ELIMAGEURL(model.shopLogo)];
                }
            }else{
                img.hidden = YES;
                view.hidden = YES;
            }
        }
    }
}

- (void)onImageTap:(UIGestureRecognizer *)recognizer{
    if ([self.delegate respondsToSelector:@selector(hotShopDidSelectWithModel:)]) {
        if([self.data isKindOfClass:[NSArray class]]){
            ELHotShopModel *model = self.data[recognizer.view.tag-100];
            if ([model isKindOfClass:[ELHotShopModel class]]) {
                [self.delegate hotShopDidSelectWithModel:model];
            }
        }
    }
}

@end
