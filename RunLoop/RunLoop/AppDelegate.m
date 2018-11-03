//
//  AppDelegate.m
//  RunLoop
//
//  Created by Huxley on 2018/10/31.
//  Copyright © 2018 Huxley. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+NewMethod.h"



@interface AppDelegate ()

@property (assign) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@"%s -BEGIN-", __func__);
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%s %@", __func__, NSRunLoop.currentRunLoop.currentMode);
        CFRunLoopStop(NSRunLoop.currentRunLoop.getCFRunLoop);
    }];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:@"PraviteMode"];
//    [NSRunLoop.currentRunLoop runMode:@"PraviteMode" beforeDate:NSDate.distantFuture];
    CFRunLoopAddCommonMode(NSRunLoop.currentRunLoop.getCFRunLoop, (CFRunLoopMode)@"PraviteMode");
    NSLog(@"%s %@", __func__, CFRunLoopCopyAllModes(NSRunLoop.currentRunLoop.getCFRunLoop));
    NSLog(@"%s -END- %@", __func__, NSRunLoop.currentRunLoop.currentMode);
    CFRunLoopStop(CFRunLoopRef rl);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
