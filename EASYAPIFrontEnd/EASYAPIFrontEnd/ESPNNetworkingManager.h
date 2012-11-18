//
//  ESPNNetworkingManager.h
//
//  Created by Hyde, Andrew on 9/27/12.
//  Copyright (c) 2012 Hyde, Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkingBlock)(NSData *, NSError *);
typedef void (^JSONBlock)(NSDictionary *, NSError *);

@interface ESPNNetworkingManager : NSObject

//Takes NSString and block. Block is always executed on MAIN thread when returning.
+(void)loadDataFromURL:(NSString *)URL withBlock:(NetworkingBlock)block;
+(void)loadDataFromRequest:(NSMutableURLRequest *)request withBlock:(NetworkingBlock)block;
+(void)loadJSONFromURL:(NSString *)URL withBlock:(JSONBlock)block;
+(void)loadJSONFromRequest:(NSMutableURLRequest *)request withBlock:(JSONBlock)block;
//Subclases should override to set custom request variables rather then setting in base class
+(NSMutableURLRequest *)getRequestForURL:(NSString *)URL;

@end
