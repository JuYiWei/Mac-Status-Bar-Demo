//
//  ViewController.m
//  music
//
//  Created by juyiwei on 2019/11/6.
//  Copyright © 2019 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import "CZMusicBPMTool.h"

@interface ViewController()

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (strong) IBOutlet NSTextField *bpmLabel;
@property (strong) IBOutlet NSTextField *accuracyRateLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bpmLabel.stringValue = @"Music";
    self.accuracyRateLabel.stringValue = @"Start";
    
    // 状态栏控件
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem.button setTitle:@"Music"];
    
    // 监听全局事件
    [NSEvent addGlobalMonitorForEventsMatchingMask:(NSEventMaskKeyDown)  handler:^(NSEvent * event) {
        if (event.type == NSEventTypeKeyDown) {
            if ([event keyCode] == 49) {
                [self musicGlobalAction];
            }
        }
    }];
    
    // 本地事件
    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * _Nonnull event) {
        if (event.type == NSEventTypeKeyDown) {
            if ([event keyCode] == 49) {
                [self musicLocalAction];
            }
        }
        return event;
    }];
}

#pragma mark - Action

- (void)musicGlobalAction {
    // 循环引用哦
    [[CZMusicBPMTool sharedInstance] musicActionCalculateBlock:^(NSString * _Nonnull bpmStr, NSString * _Nonnull accuracyRateStr) {
        NSString *resStr = [NSString stringWithFormat:@"[%@|%@]", bpmStr, accuracyRateStr];
        [self.statusItem.button setTitle:resStr];
    }];
}

- (void)musicLocalAction {
    // 循环引用哦
    [[CZMusicBPMTool sharedInstance] musicActionCalculateBlock:^(NSString * _Nonnull bpmStr, NSString * _Nonnull accuracyRateStr) {
        self.bpmLabel.stringValue = bpmStr;
        self.accuracyRateLabel.stringValue = accuracyRateStr;
    }];
}

@end
