//
//  EAPICustomObjectView.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/18/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPICustomObjectView.h"

@implementation EAPICustomObjectView

- (id)initWithFrame:(CGRect)frame andName:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.name = name;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"["];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label release];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(25, 20, 200, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"All %@s,", name];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 10, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"],"];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        [label release];
    }
    return self;
}

-(NSMutableArray *)getCurrentValues
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"blueprint", @"type", self.name, @"key", nil];
    return dictionary;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
