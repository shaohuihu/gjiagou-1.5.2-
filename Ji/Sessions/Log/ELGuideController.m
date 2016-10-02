//
//  ELGuideController.m
//  Ji
//
//  Created by evol on 16/6/12.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELGuideController.h"
#import "ELGuideContentController.h"
#import "AppDelegate.h"
@interface ELGuideController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSArray *pageContent;
@property (nonatomic, readonly) UIPageControl *pageControl;

@end

@implementation ELGuideController


- (void)o_configDatas {
    self.pageContent = @[@"guide01",@"guide02",@"guide03",@"guide04"];
}

- (void)o_configViews {
    
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageController.view.frame = self.view.bounds;
    _pageController.dataSource = self;
    _pageController.delegate = self;
    ELGuideContentController *vc = [self viewControllerAtIndex:0];
    [_pageController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-30, SCREEN_WIDTH, 30)];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = self.pageContent.count;
    [self.view addSubview:_pageControl];

}


#pragma mark - Response

- (void)imageTap
{
    [kAppDelegate showMainController];
}
#pragma mark - Getters

- (ELGuideContentController *)viewControllerAtIndex:(NSInteger)index
{
    if (self.pageContent.count == 0 || index >= self.pageContent.count) {
        return nil;
    }
    ELGuideContentController *vc = [[ELGuideContentController alloc] init];
    vc.imageString = [self.pageContent objectAtIndex:index];
    if (index == self.pageContent.count-1) {
        [vc.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)]];
    }
    return vc;
}

- (NSUInteger)indexOfViewController:(ELGuideContentController *)viewController
{
    return [self.pageContent indexOfObject:viewController.imageString];
}

#pragma mark- UIPageViewControllerDataSource

// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(ELGuideContentController *)viewController];
    _pageControl.currentPage = index;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    // 不用我们去操心每个ViewController的顺序问题。
    NSLog(@"index:%lu",(unsigned long)index);
    return [self viewControllerAtIndex:index];
    
    
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(ELGuideContentController *)viewController];
    _pageControl.currentPage = index;
    NSLog(@"index:%lu",(unsigned long)index);

    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
//    return self.pageContent.count;
//}// The number of items reflected in the page indicator.
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
//    return 0;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
