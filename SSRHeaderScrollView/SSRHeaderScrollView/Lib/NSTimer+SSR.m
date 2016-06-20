//
//  NSTimer+SSR.m
//  SSRAllBase
//
//  Created by 默默 on 4/26/16.
//  Copyright © 2016年 fishcoder. All rights reserved.
//

#import "NSTimer+SSR.h"

@implementation NSTimer (SSR)
+ (instancetype)SSRScheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeat:(BOOL)repeat{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(ssrBlockInvoke:) userInfo:[block copy] repeats:repeat];
}

+ (void)ssrBlockInvoke:(NSTimer *)timer{
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
