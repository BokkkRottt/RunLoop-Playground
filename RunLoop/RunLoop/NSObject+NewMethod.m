//
//  NSObject+NewMethod.m
//  RunLoop
//
//  Created by Huxley on 2018/10/31.
//  Copyright © 2018 Huxley. All rights reserved.
//

#import "NSObject+NewMethod.h"

typedef struct {
    id object;
    SEL selector;
    id argument;
    CFRunLoopTimerRef timer;
    NSArray *modes;
    int retainCount;
} NSDelayedPerformer;

@implementation NSObject (NewMethod)

- (void)cancelPreviousPerformRequestsWithSelector:(SEL)aSelector
{
    //Thread unsafe
    NSRunLoop *rl = NSRunLoop.currentRunLoop;
    NSMutableArray *perft = (NSMutableArray *)[rl valueForKey:@"_dperf"];
    [perft enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CFRunLoopTimerContext ctx;
        CFRunLoopTimerGetContext((CFRunLoopTimerRef)obj, &ctx);
        NSDelayedPerformer *performer = (NSDelayedPerformer *)ctx.info;
        if (performer->object == self && performer->selector == aSelector)
        {
            CFRunLoopTimerInvalidate((CFRunLoopTimerRef)obj);
            [perft removeObject:obj];
        }
    }];
}

@end
