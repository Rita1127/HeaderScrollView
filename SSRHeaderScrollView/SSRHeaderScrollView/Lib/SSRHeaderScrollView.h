//
//  SSRHeaderScrollView.h
//  SSRAllBase
//
//  Created by 默默 on 16/6/17.
//  Copyright © 2016年 宋曙冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSRHeaderScrollView;
@protocol SSRScrollViewDelegate <NSObject>
@optional
/**
 *  传递出去点击了第几个图片
 */
- (void)scrollViewClick:(NSInteger)number;

@end


@interface SSRHeaderScrollView : UIView

//是否显示pageControl
@property (assign, nonatomic) BOOL showPageControl;

//传入的图片数组（可以是图片对象，也可以是图片的url）
@property (strong, nonatomic) NSArray *imgArray;

/**  pageControl选中时颜色 */
@property (weak, nonatomic)UIColor *currentColor;
@property (weak, nonatomic)UIColor *indicatorColor;

/** pageControl选中时背景图片 */
@property (strong, nonatomic) UIImage *currentImage;
@property (strong, nonatomic) UIImage *indicatorImage;

//点击图片后的代理
@property (weak, nonatomic) id <SSRScrollViewDelegate> delegate;
@end
