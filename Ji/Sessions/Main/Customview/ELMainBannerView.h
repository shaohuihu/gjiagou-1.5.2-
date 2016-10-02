//
//  ELMainBannerView.h
//  Ji
//
//  Created by evol on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELMainBannerView;

@protocol ELMainBannerViewDelegate <NSObject>
@optional
- (void)didClickPage:(ELMainBannerView *)view atIndex:(NSInteger)index;

@end

@interface ELMainBannerView : UIView

@property (nonatomic, weak) id <ELMainBannerViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;

-(void)shouldAutoShow:(BOOL)shouldStart;
@end
