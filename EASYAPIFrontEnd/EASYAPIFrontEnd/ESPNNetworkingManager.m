//
//  ESPNNetworkingManager.m
//
//  Created by Hyde, Andrew on 9/27/12.
//  Copyright (c) 2012 Hyde, Andrew. All rights reserved.
//

#import "ESPNNetworkingManager.h"
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "JSONKit.h"
#import <UIKit/UIKit.h>

@interface ESPNNetworkingManager (Private)

+(void)setNetworkActivityIndicator:(NSNumber *)visible;
+(BOOL)connectedToNetwork;

@end

@implementation ESPNNetworkingManager

+(void)loadDataFromURL:(NSString *)URL withBlock:(NetworkingBlock)block
{
    [ESPNNetworkingManager loadDataFromRequest:[self getRequestForURL:URL] withBlock:block];
}

+(void)loadDataFromRequest:(NSMutableURLRequest *)request withBlock:(NetworkingBlock)block
{
    //Check network connectivity
    if(![ESPNNetworkingManager connectedToNetwork])
        block(nil, [NSError errorWithDomain:@"ESPNNetworkingManager" code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"No Network Connection", NSLocalizedDescriptionKey, nil]]);
    
    //Turn on network indicator
    [ESPNNetworkingManager performSelectorOnMainThread:@selector(setNetworkActivityIndicator:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:NO];
    
    //iOS 5+
    if([NSURLConnection respondsToSelector:@selector(sendAsynchronousRequest:queue:completionHandler:)])
    {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:
         ^(NSURLResponse *response, NSData *data, NSError *error)
         {
             [ESPNNetworkingManager performSelectorOnMainThread:@selector(setNetworkActivityIndicator:) withObject:[NSNumber numberWithBool:NO] waitUntilDone:NO];
            
             block(data, error);
         }];
    }
    else    //pre iOS 5
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSError *error = nil;
                           NSURLResponse *urlResponse = nil;
                           NSData *responseData =
                           [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
                           
                           dispatch_async(dispatch_get_main_queue(),
                                          ^{
                                              [ESPNNetworkingManager performSelectorOnMainThread:@selector(setNetworkActivityIndicator:) withObject:[NSNumber numberWithBool:NO] waitUntilDone:NO];
                                              
                                              block(responseData, error);
                                          });
                       });
    }
}

+(void)loadJSONFromURL:(NSString *)URL withBlock:(JSONBlock)block
{
    [ESPNNetworkingManager loadJSONFromRequest:[self getRequestForURL:URL] withBlock:block];
}

+(void)loadJSONFromRequest:(NSMutableURLRequest *)request withBlock:(JSONBlock)block
{
//    NSLog(@"%@", request.URL);
    [ESPNNetworkingManager loadDataFromRequest:request withBlock:^(NSData *data, NSError *error){
        if(error)
            block(nil, error);
        NSString *feedString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        
        //TODO: this is a workaround for the feed.esi issue where it's not returning valid json.
        //Ideally this would be fixed on the server side and this code could be removed.
        feedString = [feedString stringByReplacingOccurrencesOfString:@"({" withString:@"[{"];
        feedString = [feedString stringByReplacingOccurrencesOfString:@"})" withString:@"}]"];
        if([feedString length] > 0)
        {
            block([feedString objectFromJSONString], error);
        }
        else {
            //still call the block, just pass nil as the string
            block(nil, error);
        }
    }];
}


#pragma mark -
#pragma mark Utilities

+(NSMutableURLRequest *)getRequestForURL:(NSString *)URL
{
    //NSLog(@"WARNING: SUBCLASSES SHOULD OVERRIDE THIS METHOD TO CUSTOMIZE THE REQUEST");
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData]; // No local cache
    
    return request;
}

+ (void)setNetworkActivityIndicator:(NSNumber *)visible {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = [visible boolValue];
}

+(BOOL)connectedToNetwork {
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	if (!didRetrieveFlags) {
		NSLog(@"Error. Could not recover network reachability flags");
		return 0;
	}
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	return isReachable;
}

@end
