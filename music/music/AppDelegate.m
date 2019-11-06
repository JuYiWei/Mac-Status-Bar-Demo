//
//  AppDelegate.m
//  music
//
//  Created by juyiwei on 2019/11/6.
//  Copyright © 2019 居祎炜. All rights reserved.
//

#import "AppDelegate.h"
#import <AppKit/AppKit.h>

@interface AppDelegate ()

@property (nonatomic, strong) NSStatusItem *statusItem;

@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSTimeInterval avgTime;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) BOOL start;
@property (nonatomic, assign) BOOL end;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    self.startTime = [[NSDate date] timeIntervalSince1970];
    self.lastTime = 0;
    self.avgTime = 1;
    self.count = 0;
    self.start = NO;
    self.end = NO;
                 
    // 状态栏控件
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem.button setTitle:@"music"];
    
    // 监听全局事件
    [NSEvent addGlobalMonitorForEventsMatchingMask:(NSEventMaskKeyDown)  handler:^(NSEvent * event) {
        if (event.type == NSEventTypeKeyDown) {
            if ([event keyCode] == 49) {
                [self musicAction];
            }
        }
    }];
}

- (void)musicAction {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    if ((time - self.lastTime) > 3) {
        self.startTime = time;
        self.count = 0;
        self.lastTime = time;
        [self.statusItem.button setTitle:@"start"];
        self.start = YES;
        self.avgTime = 1;
        
    } else {
        if (self.start) {
            self.count++;
            self.lastTime = time;
            NSTimeInterval total = self.lastTime - self.startTime;
            NSTimeInterval avg = (total / self.count);
            NSTimeInterval speed = 60 / avg;
            NSTimeInterval rate = (self.avgTime - avg )/ self.avgTime*1000;
            NSString *speedStr = [NSString stringWithFormat:@"[%.1f | %.1f%%]", speed, rate];
            [self.statusItem.button setTitle:speedStr];
            
            self.avgTime = avg;
            if (fabs(rate) <= 1 && self.count*self.avgTime > 20) {
                self.start = NO;
                // 完成
                NSString *speedStr = [NSString stringWithFormat:@"[%.1f]", speed];
                [self.statusItem.button setTitle:speedStr];
            }
        } else {
            self.lastTime = time;
        }
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end

