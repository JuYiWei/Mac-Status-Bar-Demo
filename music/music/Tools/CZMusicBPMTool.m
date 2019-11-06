//
//  CZMusicBPMTool.m
//  music
//
//  Created by juyiwei on 2019/11/6.
//  Copyright © 2019 居祎炜. All rights reserved.
//

#import "CZMusicBPMTool.h"

@implementation CZMusicBPMTool

static CZMusicBPMTool *singleton;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[CZMusicBPMTool alloc] init];
    });
    return singleton;
}

- (void)musicActionCalculateBlock:(void (^ _Nonnull)(NSString * _Nonnull bpmStr, NSString * _Nonnull accuracyRateStr))calculateBlock {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    if ((time - self.lastTime) > 3) {
        self.startTime = time;
        self.count = 0;
        self.lastTime = time;
        self.start = YES;
        self.avgTime = 1;
        if (calculateBlock) {
            calculateBlock(@"Music", @"Start");
        }
    }
    else {
        if (self.start) {
            self.count++;
            self.lastTime = time;
            NSTimeInterval total = self.lastTime - self.startTime;
            NSTimeInterval avg = (total / self.count);
            NSTimeInterval speed = 60 / avg;
            NSTimeInterval rate = (self.avgTime - avg )/ self.avgTime*1000;
            NSString *rateStr = [NSString stringWithFormat:@"%.0f", rate];
            NSString *speedStr = [NSString stringWithFormat:@"%.1f", speed];
            self.avgTime = avg;
            if (fabs(rate) <= 1 && self.count*self.avgTime > 20) {
                self.start = NO;
            }
            if (calculateBlock) {
                calculateBlock(speedStr, rateStr);
            }
        }
        else {
            self.lastTime = time;
        }
    }
}


@end
