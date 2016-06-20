//
//  ViewController.m
//  SSRHeaderScrollView
//
//  Created by 默默 on 4/26/16.
//  Copyright © 2016年 fishcoder. All rights reserved.
//

#import "ViewController.h"
#import "SSRHeaderScrollView.h"
@interface ViewController ()<SSRScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat view_Width = [UIScreen mainScreen].bounds.size.width;
    SSRHeaderScrollView *header = [[SSRHeaderScrollView alloc] initWithFrame:CGRectMake(0, 64, view_Width, 150)];
    header.delegate = self;
    header.showPageControl = YES;
    header.indicatorColor = [UIColor redColor];
    header.currentColor = [UIColor blackColor];
    UIImage *image1 = [UIImage imageNamed:@"comment-bar-record-click"];
    UIImage *image2 = [UIImage imageNamed:@"friendsTrend_login_click"];
    header.imgArray = @[image1,image2];
    [self.view addSubview:header];
}
#pragma mark --SSRScrollViewDelegate
- (void)scrollViewClick:(NSInteger)number{
    NSLog(@"number == %ld",(long)number);
}

@end
