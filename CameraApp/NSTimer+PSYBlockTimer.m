//
//  NSTimer+PSYBlockTimer.m
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import "NSTimer+PSYBlockTimer.h"


typedef void (^PSYTimerBlock)(NSTimer *);

#define SELF_EXECUTING 1

#if defined(SELF_EXECUTING) && SELF_EXECUTING

@interface NSTimer (PSYBlockTimer_private)
+ (void)PSYBlockTimer_executeBlockWithTimer:(NSTimer *)timer;
@end


@implementation NSTimer (PSYBlockTimer)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock
{
    return [self scheduledTimerWithTimeInterval:seconds target:self selector:@selector(PSYBlockTimer_executeBlockWithTimer:) userInfo:[fireBlock copy]  repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock
{
    return [self timerWithTimeInterval:seconds target:self selector:@selector(PSYBlockTimer_executeBlockWithTimer:) userInfo:[fireBlock copy]  repeats:repeats];
}
@end


@implementation NSTimer (PSYBlockTimer_private)
+ (void)PSYBlockTimer_executeBlockWithTimer:(NSTimer *)timer
{
    PSYTimerBlock block = [timer userInfo];
    block(timer);
}
@end

#else

// Private helper class
__attribute__((visibility("hidden")))
@interface _PSYBlockTimer : NSObject { PSYTimerBlock block; }
+ (id)blockTimer;
@property(copy) PSYTimerBlock block;
- (void)executeBlockWithTimer:(NSTimer *)timer;
@end

@implementation NSTimer (PSYBlockTimer)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock
{
    _PSYBlockTimer *blkTimer = [_PSYBlockTimer blockTimer];
    [blkTimer setBlock:fireBlock];
    return [self scheduledTimerWithTimeInterval:seconds target:blkTimer selector:@selector(executeBlockWithTimer:) userInfo:nil repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock
{
    _PSYBlockTimer *blkTimer = [_PSYBlockTimer blockTimer];
    [blkTimer setBlock:fireBlock];
    return [self timerWithTimeInterval:seconds target:blkTimer selector:@selector(executeBlockWithTimer:) userInfo:nil repeats:repeats];
}
@end

@implementation _PSYBlockTimer
@synthesize block;

+ (id)blockTimer { return [[[self alloc] init] autorelease]; }
- (void)executeBlockWithTimer:(NSTimer *)timer
{
    block(timer);
}
- (void)dealloc
{
    [block release];
    [super dealloc];
}
@end

#endif