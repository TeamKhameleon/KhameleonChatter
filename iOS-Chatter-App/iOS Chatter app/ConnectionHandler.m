#import "ConnectionHandler.h"

@implementation ConnectionHandler

-(BOOL) isConnectedToInternet {
    // Should work fine, unless you are in China
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    return ( URLString != NULL ) ? YES : NO;
}

@end
