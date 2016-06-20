//
//  SSRHeaderScrollView.m
//  SSRAllBase
//
//  Created by 默默 on 16/6/17.
//  Copyright © 2016年 宋曙冉. All rights reserved.
//

#import "SSRHeaderScrollView.h"
#import "UIImageView+WebCache.h"
#import "NSTimer+SSR.h"
#import "UIView+SSR.h"

@interface SSRHeaderScrollView()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
/***  存放imageView的数组 */
@property (strong, nonatomic) NSMutableArray *imageViewArr;
@end

@implementation SSRHeaderScrollView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       [self setUp];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp{
    UIScrollView *scrollView =  [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    //pageControl的点击时间没做处理，个人感觉没别要
    self.pageControl = pageControl;
    [self insertSubview:pageControl aboveSubview:self.scrollView];
}

-(void)setImgArray:(NSArray *)imgArray{
    _imgArray = imgArray;
    [self addAllChildView];
}
- (void)addAllChildView{
    //判断是否是image对象，或者是image 的 URL
    BOOL isImage = ([self.imgArray[0] isKindOfClass:[UIImage class]]) ? YES : NO;
    
    for (NSInteger i=0; i<self.imgArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        if (isImage) {
            imageView.image = self.imgArray[i];
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString: self.imgArray[i]] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed];
        }
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImageView:)];
        [imageView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:imageView];
        [self.imageViewArr addObject:imageView];
    }
    
    self.pageControl.numberOfPages = self.imgArray.count;
    
    if (self.imgArray.count>1) {
        [self startTimer];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.width = self.width;
    self.scrollView.height = self.height;
    if (self.imageViewArr.count==0)  return;
    
    CGFloat imageViewY = 0;
    CGFloat imageViewX = 0;
    CGFloat imageViewH = self.scrollView.height;
    CGFloat imageViewW = self.scrollView.width;
    for (NSInteger i=0; i<self.imageViewArr.count; i++) {
        UIImageView *imageView = self.imageViewArr[i];
        imageViewX = i*imageViewW;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
    self.scrollView.contentSize = CGSizeMake(imageViewW * self.imageViewArr.count, 0);
    self.pageControl.centerX = self.scrollView.width * 0.5;
    self.pageControl.centerY = self.scrollView.height - 20;
}

#pragma mark -- imageView手势
- (void)didClickImageView:(UIImageView *)imageView{
    if ([self.delegate respondsToSelector:@selector(scrollViewClick:)]) {
        [self.delegate scrollViewClick:self.pageControl.currentPage];
    }
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = self.scrollView.contentOffset.x / self.scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.imageViewArr.count>1) {
        [self startTimer];
    }
}

/***  开启定时器 */
-(void)startTimer{
    NSTimer *timer = [NSTimer SSRScheduledTimerWithTimeInterval:5.0 block:^{
        // 1.判断第几张图片
        NSInteger count = self.imgArray.count;
        NSInteger currentPage = self.pageControl.currentPage;
        NSInteger page = (currentPage == count-1) ? 0 : currentPage + 1;
        // 2.滚动到相应位置
        CGFloat scrollX = page * self.scrollView.frame.size.width;
        CGFloat scrollY = 0;
        [self.scrollView setContentOffset:CGPointMake(scrollX, scrollY) animated:YES];
    } repeat:YES];
    self.timer = timer;
}
/***  停止定时器 */
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setCurrentColor:(UIColor *)currentColor{
    _currentColor = currentColor;
    self.pageControl.currentPageIndicatorTintColor = currentColor;
}
- (void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    self.pageControl.pageIndicatorTintColor = indicatorColor;
}
- (void)setCurrentImage:(UIImage *)currentImage{
    _currentImage = currentImage;
    [self.pageControl setValue:currentImage forKey:@"currentPageImage"];
}
- (void)setIndicatorImage:(UIImage *)indicatorImage{
    _indicatorImage = indicatorImage;
    [self.pageControl setValue:indicatorImage forKey:@"pageImage"];
}
- (void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    self.pageControl.hidden = !showPageControl;
}
-(NSMutableArray *)imageViewArr{
    if (!_imageViewArr) {
        _imageViewArr = [NSMutableArray array];
    }
    return _imageViewArr;
}
@end
