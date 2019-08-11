//
//  ViewController.m
//  ReusableView
//
//  Created by Zhiwei on 2019/8/10.
//  Copyright © 2019 Zhiwei. All rights reserved.
//

#import "ViewController.h"
#import "ReusableView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *reusableArray;
@property (nonatomic, assign) NSUInteger lastIndex;
@property (nonatomic, assign) NSInteger numberOfViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.delegate = self;
    self.reusableArray = @[].mutableCopy;
    
    self.numberOfViews = 7;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.numberOfViews, kScreenHeight - 64 - self.tabBarController.tabBar.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollsToTop = YES;
    [self prepareViewsForBothEndsAtIndex:0];
    [self setupViewAtIndex:0];
}

- (void)prepareViewsForBothEndsAtIndex:(NSInteger)index {
    BOOL leftReady = index == 0 ? YES : NO;
    BOOL rightReady = index == self.numberOfViews - 1 ? YES : NO;
    for (ReusableView *view in self.reusableArray) {
        if (view.index == index - 1) {
            leftReady = YES;
        }
        if (view.index == index + 1) {
            rightReady = YES;
        }
    }
    if (!leftReady) {
        [self setupViewAtIndex:index - 1];
    }
    if (!rightReady) {
        [self setupViewAtIndex:index + 1];
    }
}

- (void)setupViewAtIndex:(NSInteger)index {
    [self reuseViewWithIndex:index];
    ReusableView *view = [self dequeueReusableViewWithindex:index];
    view.frame = CGRectMake(kScreenWidth * index, 0, kScreenWidth, kScreenHeight - 64 - self.tabBarController.tabBar.frame.size.height);
    view.label.text = [NSString stringWithFormat:@"address is %p \r page index is %ld", view, (long)index];
    [self.scrollView addSubview:view];
    NSLog(@"View %ld is added",view.index);
}

- (void)reuseViewWithIndex:(NSInteger)index {
    for (ReusableView *view in self.reusableArray) {
        if (view.index == -1) {
            continue;
        }
        if (view.index < index - 2 || view.index > index + 2) {
            NSLog(@"view %ld is removed and will be reused",(long)view.index);
            view.index = -1 ;
            [view removeFromSuperview];
        }
    }
}

- (ReusableView *)dequeueReusableViewWithindex:(NSUInteger)index {
    for (ReusableView *view in self.reusableArray) {
        if (view.index == index) {
            NSLog(@"Existing view %ld is reused",view.index);
            return view;
        }
        
        if (!view.superview) {
            view.index = index;
            return view;
        }
    }
    ReusableView *view = [ReusableView new];
    view.index = index;
    NSLog(@"view %ld is created",(long)view.index);
    [self.reusableArray addObject:view];
    return view;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / kScreenWidth;
    if (self.lastIndex == index) {
        return;
    }
    self.lastIndex = index;
    [self prepareViewsForBothEndsAtIndex:index];
    [self setupViewAtIndex:index];
    NSLog(@"Counf of array %ld",self.reusableArray.count);
}

@end
