//
//  ELMainBannerView.m
//  Ji
//
//  Created by evol on 16/5/19.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMainBannerView.h"

@interface ELMainBannerView ()<UIScrollViewDelegate>
{
    float _viewWidth;
    float _viewHeight;
    
    NSTimer *_autoScrollTimer;
    UITapGestureRecognizer *_tap;
}

@property (nonatomic, strong) UIImageView *firstView;
@property (nonatomic, strong) UIImageView *middleView;
@property (nonatomic, strong) UIImageView *lastView;

@end

@implementation ELMainBannerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _viewWidth = self.bounds.size.width;
        _viewHeight = self.bounds.size.height;
        
        //设置scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
        [_scrollView addSubview:self.firstView];
        [_scrollView addSubview:self.middleView];
        [_scrollView addSubview:self.lastView];
        _scrollView.contentSize = CGSizeMake(_viewWidth * 3, _viewHeight);
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //设置分页
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _viewHeight-30, _viewWidth, 30)];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
        //设置单击手势
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        [_scrollView addGestureRecognizer:_tap];
    }
    return self;
}

#pragma mark 单击手势
-(void)handleTap:(UITapGestureRecognizer*)sender
{
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_currentPage];
    }
}

#pragma mark 设置imageViewAry
-(void)setImageViewAry:(NSArray *)imageViewAry
{
    if (imageViewAry.count == 0) {
        _firstView.image = nil;
        _middleView.image = nil;
        _lastView.image = nil;
        _pageControl.numberOfPages = 0;
        return;
    }
    if (imageViewAry) {
        _imageViewAry = imageViewAry;
        _currentPage = 0; //默认为第0页
        
        _pageControl.numberOfPages = _imageViewAry.count;
    }
    
    [self reloadData];
}

#pragma mark 刷新view页面
-(void)reloadData
{
    
    NSString *first;
    NSString *middle;
    NSString *last;
    
    if (_imageViewAry.count == 1) {
        _scrollView.scrollEnabled = NO;
        middle = [_imageViewAry objectAtIndex:_currentPage];
        [_middleView sd_setImageWithURL:ELIMAGEURL(middle)];
    }else{
        _scrollView.scrollEnabled = YES;
        if (_currentPage==0) {
            first =  [_imageViewAry lastObject];
            middle = [_imageViewAry objectAtIndex:_currentPage];
            last = [_imageViewAry objectAtIndex:_currentPage+1];
        }
        else if (_currentPage == _imageViewAry.count-1)
        {
            first = [_imageViewAry objectAtIndex:_currentPage-1];
            middle = [_imageViewAry objectAtIndex:_currentPage];
            last = [_imageViewAry firstObject];
        }
        else
        {
            first = [_imageViewAry objectAtIndex:_currentPage-1];
            middle = [_imageViewAry objectAtIndex:_currentPage];
            last = [_imageViewAry objectAtIndex:_currentPage+1];
        }
        [_firstView sd_setImageWithURL:ELIMAGEURL(first)];
        [_middleView sd_setImageWithURL:ELIMAGEURL(middle)];
        [_lastView sd_setImageWithURL:ELIMAGEURL(last)];

    }

    
    
    _pageControl.currentPage = _currentPage;
    //显示中间页
    _scrollView.contentOffset = CGPointMake(_viewWidth, 0);
}

#pragma mark scrollvie停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动滑动时候暂停自动替换
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
    
    //得到当前页数
    float x = _scrollView.contentOffset.x;
    
    //往前翻
    if (x<=0) {
        if (_currentPage-1<0) {
            _currentPage = _imageViewAry.count-1;
        }else{
            _currentPage --;
        }
    }
    
    //往后翻
    if (x>=_viewWidth*2) {
        if (_currentPage==_imageViewAry.count-1) {
            _currentPage = 0;
        }else{
            _currentPage ++;
        }
    }
    
    [self reloadData];
}

#pragma mark 自动滚动
-(void)shouldAutoShow:(BOOL)shouldStart
{
    if (shouldStart)  //开启自动翻页
    {
        if (!_autoScrollTimer) {
            _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
        }
    }
    else   //关闭自动翻页
    {
        if (_autoScrollTimer.isValid) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
    }
}

#pragma mark 展示下一页
-(void)autoShowNextImage
{
    if (_currentPage == _imageViewAry.count-1) {
        _currentPage = 0;
    }else{
        _currentPage ++;
    }
    
    [self reloadData];
}

#pragma mark - Getters

- (UIImageView *)firstView{
    if (_firstView == nil) {
        _firstView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
    }
    return _firstView;
}


- (UIImageView *)middleView{
    if (_middleView == nil) {
        _middleView = [[UIImageView alloc] initWithFrame:CGRectMake(_viewWidth, 0, _viewWidth, _viewHeight)];
    }
    return _middleView;
}

- (UIImageView *)lastView {
    if (_lastView == nil) {
        _lastView = [[UIImageView alloc] initWithFrame:CGRectMake(_viewWidth * 2, 0, _viewWidth, _viewHeight)];
    }
    return _lastView;
}

@end
