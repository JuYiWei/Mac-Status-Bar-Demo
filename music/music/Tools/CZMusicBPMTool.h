//
//  CZMusicBPMTool.h
//  music
//
//  Created by juyiwei on 2019/11/6.
//  Copyright © 2019 居祎炜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZMusicBPMTool : NSObject

@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSTimeInterval avgTime;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) BOOL start;
@property (nonatomic, assign) BOOL end;

+ (instancetype)sharedInstance;

- (void)musicActionCalculateBlock:(void (^ _Nonnull)(NSString * _Nonnull bpmStr, NSString * _Nonnull accuracyRateStr))calculateBlock;

@end

NS_ASSUME_NONNULL_END
