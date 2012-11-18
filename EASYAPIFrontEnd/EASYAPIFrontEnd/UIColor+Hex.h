//
//  UColor+Hex.h
//  ScoreCenter
//
//  Created by Brandon Tennant on 4/21/09.
//  Copyright 2009 ESPN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (Hex) 

+ (UIColor *)colorWithHexString:(NSString *)string;
+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;
- (UIColor *)lighterBy:(CGFloat)percentage;
- (UIColor *)darkerBy:(CGFloat)percentage;

+ (UIColor *)T1_color;
+ (UIColor *)T2_color;
+ (UIColor *)T3_color;
+ (UIColor *)T4_color;
+ (UIColor *)T5_color;
+ (UIColor *)T6_color;
+ (UIColor *)T7_color;
+ (UIColor *)T8_color;
+ (UIColor *)T9_color;
+ (UIColor *)T10_color;
+ (UIColor *)T11_color;
+ (UIColor *)T12_color;
+ (UIColor *)T13_color;
+ (UIColor *)T14_color;
+ (UIColor *)T15_color;
+ (UIColor *)T16_color;
+ (UIColor *)T17_color;
+ (UIColor *)T18_color;

+ (UIColor *)L1_color;
+ (UIColor *)L2_color;
+ (UIColor *)L3_color;
+ (UIColor *)L4_color;
+ (UIColor *)L5_color;

+ (UIColor *)A1_color;
+ (UIColor *)A2_color;

+ (UIColor*)colorFromConfiguration:(NSString*)colorKey;

- (NSString *)hexString;

+ (UIColor *)darkGreyBackgroundColor;
+ (UIColor *)greyCellBackgroundColor;

@end
