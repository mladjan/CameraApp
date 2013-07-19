//
//  NSTimer+PSYBlockTimer.h
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2012 Imperio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (PSYBlockTimer)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock;
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock;
@end
