//
//  NotificationInvoker.m
//  iOS Chatter app
//
//  Created by Ivan Danov on 11/6/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "NotificationInvoker.h"

@implementation NotificationInvoker

-(void)invokeNotificationWithMessage:(NSString *)message
                       AndAppearDate:(NSDate *)appearDate;
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = appearDate;
    localNotification.alertBody = message;
    
    //localNotification.alertAction = @"Show me the item";
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber =
        [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];    
}

@end
