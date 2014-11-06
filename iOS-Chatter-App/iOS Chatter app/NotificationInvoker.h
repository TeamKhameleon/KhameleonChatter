//
//  NotificationInvoker.h
//  iOS Chatter app
//
//  Created by Ivan Danov on 11/6/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationInvoker : NSObject

-(void)invokeNotificationWithMessage:(NSString *)message
                       AndAppearDate:(NSDate *)appearDate;

@end
