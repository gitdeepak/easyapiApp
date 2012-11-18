//
//  EAPIKeyValueView.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPIKeyValueView.h"

#define kKeyTag 13533
#define kValueTag 5432

@implementation EAPIKeyValueView

- (id)initWithFrame:(CGRect)frame andType:(ViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentType = type;
        
        UITextField *keyField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
        [keyField setBorderStyle:UITextBorderStyleBezel];
        [keyField setBackgroundColor:[UIColor whiteColor]];
        keyField.tag = kKeyTag;
        [self addSubview:keyField];
        [keyField release];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 10, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.text = self.currentType == ArrayViewType ? @"," : @":";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label release];
        
        if(type == DictionaryViewType)
        {
            UITextField *valueField = [[UITextField alloc]initWithFrame:CGRectMake(160, 0, 150, 44)];
            [valueField setBorderStyle:UITextBorderStyleBezel];
            valueField.tag = kValueTag;
            [valueField setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:valueField];
            [valueField release];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(310, 0, 10, 44)];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"," ;
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [label release];
            
        }
    }
    return self;
}

-(NSDictionary *)getCurrentValues
{
    UITextField *keyField = (UITextField *)[self viewWithTag:kKeyTag];
    UITextField *valueField = (UITextField *)[self viewWithTag:kValueTag];
    if(self.currentType == DictionaryViewType)
        return [NSDictionary dictionaryWithObjectsAndKeys:@"tuple", @"type", keyField.text, @"key", valueField.text, @"value", nil];
    else if(self.currentType == ArrayViewType)
         return [NSDictionary dictionaryWithObjectsAndKeys:@"value", @"type", keyField.text, @"value", nil];
    else
        return [NSDictionary dictionaryWithObjectsAndKeys: nil];
}   

@end
