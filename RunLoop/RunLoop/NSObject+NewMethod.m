//
//  NSObject+NewMethod.m
//  RunLoop
//
//  Created by Huxley on 2018/10/31.
//  Copyright © 2018 Huxley. All rights reserved.
//

#import "NSObject+NewMethod.h"

typedef struct {
    id object;//延迟执行方法的接收方
    SEL selector;//延迟执行的方法
    id argument;//延迟执行所使用的参数
    CFRunLoopTimerRef timer;//用于实现改延时的RunLoop定时器
    NSArray *modes;//RunLoop定时器运行的模式
    int retainCount;
} NSDelayedPerformer;//定义用于记录延迟执行的结构体

@implementation NSObject (NewMethod)

- (void)cancelPreviousPerformRequestsWithSelector:(SEL)aSelector
{
    NSRunLoop *rl = NSRunLoop.currentRunLoop;
    
    //所有的延迟执行都NSRunLoop的私有变量‘_dperf’里，它是一个可变数组，字面上猜测‘dperf’是‘Delayed Performer’的缩写？？
    NSMutableArray *perft = (NSMutableArray *)[rl valueForKey:@"_dperf"];
    
    [perft enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //采取逆向遍历这个数组，因为在遍历的时候会改变数组的内容
        CFRunLoopTimerContext ctx;
        CFRunLoopTimerGetContext((CFRunLoopTimerRef)obj, &ctx);
        //获取performer结构体
        NSDelayedPerformer *performer = (NSDelayedPerformer *)ctx.info;
        if (performer->object == self && performer->selector == aSelector)
        {
            //对比object和selector，找出匹配的performer，将其RunLoop定时器取消并将此对象从数组中移除
            CFRunLoopTimerInvalidate((CFRunLoopTimerRef)obj);
            [perft removeObject:obj];
        }
    }];
}

@end
