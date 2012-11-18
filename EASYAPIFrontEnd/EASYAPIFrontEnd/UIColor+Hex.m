//
//  UColor+Hex.m
//  ScoreCenter
//
//  Created by Brandon Tennant on 4/21/09.
//  Copyright 2009 ESPN. All rights reserved.
//

#import "UIColor+Hex.h"


@implementation UIColor (Hex) 

+ (UIColor *)colorWithHexString:(NSString *)string
{
	//	NSLog(@"Color string %@", string);
	UIColor *returnColor;
	
	if(string)
	{
		NSScanner *scanner = [NSScanner scannerWithString:string];
		[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
		
		unsigned hexNum;
		if( ![scanner scanHexInt:&hexNum]) hexNum = 0;
		int r = (hexNum >> 16) & 0xFF;
		int g = (hexNum >> 8) & 0xFF;
		int b = (hexNum) & 0xFF;
		
		returnColor =  [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f];		
	}
	
	else
	{
		returnColor = [UIColor lightGrayColor];
	}
	
	return returnColor;
}

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
	UIColor *returnColor;
	
	if (string)	{
		NSScanner *scanner = [NSScanner scannerWithString:string];
		[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
		
		unsigned hexNum;
		if(![scanner scanHexInt:&hexNum]) 
            hexNum = 0;
        
		int r = (hexNum >> 16) & 0xFF;
		int g = (hexNum >> 8) & 0xFF;
		int b = (hexNum) & 0xFF;
		
		returnColor = [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:alpha];		
	} else {
		returnColor = [UIColor lightGrayColor];
	}
	
	return returnColor;
}

- (UIColor *)lighterBy:(CGFloat)percentage {
    CGColorRef color = [self CGColor];
    const CGFloat *colorComponents = CGColorGetComponents(color);
    CGFloat red = colorComponents[0] + percentage;
    CGFloat green = colorComponents[1] + percentage;
    CGFloat blue = colorComponents[2] + percentage;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (UIColor *)darkerBy:(CGFloat)percentage {
    CGColorRef color = [self CGColor];
    const CGFloat *colorComponents = CGColorGetComponents(color);
    CGFloat red = colorComponents[0] - percentage;
    CGFloat green = colorComponents[1] - percentage;
    CGFloat blue = colorComponents[2] - percentage;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)T1_color
{
	return [self colorFromConfiguration:@"T1"];
}

+ (UIColor *)T2_color
{
	return [self colorFromConfiguration:@"T2"];
}

+ (UIColor *)T3_color
{
	return [self colorFromConfiguration:@"T3"];
}

+ (UIColor *)T4_color
{
	return [self colorFromConfiguration:@"T4"];
}

+ (UIColor *)T5_color
{
	return [self colorFromConfiguration:@"T5"];
}

+ (UIColor *)T6_color
{
	return [self colorFromConfiguration:@"T6"];
}

+ (UIColor *)T7_color
{
	return [self colorFromConfiguration:@"T7"];
}

+ (UIColor *)T8_color
{
	return [self colorFromConfiguration:@"T8"];
}

+ (UIColor *)T9_color
{
	return [self colorFromConfiguration:@"T9"];
}

+ (UIColor *)T10_color
{
	return [self colorFromConfiguration:@"T10"];
}

+ (UIColor *)T11_color
{
	return [self colorFromConfiguration:@"T11"];
}

+ (UIColor *)T12_color
{
	return [self colorFromConfiguration:@"T12"];
}

+ (UIColor *)T13_color
{
	return [self colorFromConfiguration:@"T13"];
}

+ (UIColor *)T14_color
{
	return [self colorFromConfiguration:@"T14"];
}

+ (UIColor *)T15_color
{
	return [self colorFromConfiguration:@"T15"];
}

+ (UIColor *)T16_color
{
	return [self colorFromConfiguration:@"T16"];
}

+ (UIColor *)T17_color
{
	return [self colorFromConfiguration:@"T17"];
}

+ (UIColor *)T18_color
{
	return [self colorFromConfiguration:@"T18"];
}


+ (UIColor *)L1_color
{
	return [self colorFromConfiguration:@"L1"];
}

+ (UIColor *)L2_color
{
	return [self colorFromConfiguration:@"L2"];
}

+ (UIColor *)L3_color
{
	return [self colorFromConfiguration:@"L3"];
}

+ (UIColor *)L4_color
{
	return [self colorFromConfiguration:@"L4"];
}

+ (UIColor *)L5_color
{
	return [self colorFromConfiguration:@"L5"];
}

+ (UIColor *)A1_color;
{
	return [self colorFromConfiguration:@"A1"];
}

+ (UIColor *)A2_color;
{
	return [self colorFromConfiguration:@"A2"];
}

+ (UIColor*)colorFromConfiguration:(NSString*)colorKey
{
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	NSDictionary *kUIColorsDictionary = [infoDictionary objectForKey:@"kUIColors"];
	id object = [kUIColorsDictionary valueForKey:colorKey];
	if ([object isKindOfClass:[NSString class]])
	{
		return [UIColor colorWithHexString:object];
	} else {
		NSNumber * num = [(NSDictionary*)object objectForKey:@"alpha"];
		CGFloat alpha = [num intValue]/100.0f;
		return [UIColor colorWithHexString:[(NSDictionary*)object objectForKey:@"color"] alpha:alpha];
	}
	
}

- (NSString *)hexString
{
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return [NSString stringWithFormat:@"%02X%02X%02X", (int)(c[0] * 255), (int)(c[1] * 255), (int)(c[2] * 255)];
}


//[UIColor colorWithRed:0.149 green:0.161 blue:0.173 alpha:1.0]

+ (UIColor *)darkGreyBackgroundColor {
	return [UIColor colorWithRed:0.212 green:0.231 blue:0.247 alpha:1.0];
}

+ (UIColor *)greyCellBackgroundColor  {
	return [UIColor colorWithRed:0.149 green:0.161 blue:0.173 alpha:1.0];
}

@end
