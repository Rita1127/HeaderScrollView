//
//  NSTimer+SSR.h
//  SSRAllBase
//
//  Created by 默默 on 4/26/16.
//  Copyright © 2016年 fishcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SSR)
+ (instancetype)SSRScheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeat:(BOOL)repeat;

@end
