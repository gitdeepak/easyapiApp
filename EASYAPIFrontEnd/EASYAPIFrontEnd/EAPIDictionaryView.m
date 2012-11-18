//
//  EAPIDictionaryView.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPIDictionaryView.h"

@implementation EAPIDictionaryView

- (id)initWithFrame:(CGRect)frame andType:(ViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentType = type;
        
        currentYOffset = 0;
        
        UITextField *keyField = [[UITextField alloc]initWithFrame:CGRectMake(0, currentYOffset, 150, 44)];
        [keyField setBorderStyle:UITextBorderStyleBezel];
        keyField.tag = 53211;
        [self addSubview:keyField];
        [keyField release];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, currentYOffset, 10, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @":";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label release];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(160, currentYOffset, 10, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.text = type == DictionaryViewType ? @"{" : @"[";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label release];
        
        currentYOffset+= 44;
        
        EAPIAddView *addView = [[EAPIAddView alloc]initWithFrame:CGRectMake(100, currentYOffset, 50, 50) andType:type];
        addView.delegate = self;
        addView.tag = 7765;
        [self addSubview:addView];
        [addView release];
    
    }
    return self;
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Dictionary Protocol

-(void)didAddItemWithName:(NSString *)name
{
    if([name isEqualToString:@"KeyPair"])
    {
        [self addSubview:[self createKeyValueViewAtOrigin:CGPointMake(100, currentYOffset+6)]];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+44);
        [self.delegate addedToHeight:44+20];
        currentYOffset+= 50;
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
        
    }
    else if([name isEqualToString:@"Dictionary"])
    {
        EAPIDictionaryView *view = [self createDictionaryViewAtOrigin:CGPointMake(100, currentYOffset+6) withType:DictionaryViewType];
        view.delegate = self;
        [self addSubview:view];
        currentYOffset += view.frame.size.height+20;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+view.frame.size.height);
        [self.delegate addedToHeight:view.frame.size.height+30];
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
    }
    else if([name isEqualToString:@"Array"])
    {
        EAPIDictionaryView *view = [self createDictionaryViewAtOrigin:CGPointMake(100, currentYOffset+6) withType:ArrayViewType];
        view.delegate = self;
        [self addSubview:view];
        currentYOffset += view.frame.size.height+20;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+view.frame.size.height);
        [self.delegate addedToHeight:view.frame.size.height+30];
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
    }
}

#pragma mark -
#pragma mark Create Views

-(EAPIKeyValueView *)createKeyValueViewAtOrigin:(CGPoint)origin
{
    EAPIKeyValueView *view = [[EAPIKeyValueView alloc]initWithFrame:CGRectMake(origin.x, origin.y, 310, 44) andType:self.currentType];
    
    return [view autorelease];
}

-(EAPIDictionaryView *)createDictionaryViewAtOrigin:(CGPoint)origin withType:(ViewType)type
{
    EAPIDictionaryView *view = [[EAPIDictionaryView alloc]initWithFrame:CGRectMake(origin.x, origin.y, 310, 75) andType:type];
    return [view autorelease];
}

#pragma mark -
#pragma mark Updating View

-(void)updateAddViewForOrigin:(CGPoint)origin
{
    UIView *addView = [self viewWithTag:7765];
    addView.frame = CGRectMake(addView.frame.origin.x, origin.y, addView.frame.size.width, addView.frame.size.height);
}

-(void)addedToHeight:(int)height
{
    [self.delegate addedToHeight:height+30];
    currentYOffset += height;
    UIView *addView = [self viewWithTag:7765];
    
    [self updateAddViewForOrigin:CGPointMake(addView.frame.origin.x, addView.frame.origin.y+height)];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+height);
}

#pragma mark -
#pragma mark Get Data Representation

-(NSMutableArray *)getCurrentValues
{
    
    UITextField *field = (UITextField *)[self viewWithTag:53211];
    
    NSMutableArray *overAllArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *entryArray = [[NSMutableArray alloc]init];
    
    for(UIView *view in self.subviews)
    {
        if([view isKindOfClass:[EAPIDictionaryView class]])
        {
            EAPIDictionaryView *dictionaryView = (EAPIDictionaryView *)view;
            NSArray *returnArray = [dictionaryView getCurrentValues];
            for(int x = 0; x < [returnArray count]; x++)
            {
                [entryArray addObject:[returnArray objectAtIndex:x]];
            }
        }
        if([view isKindOfClass:[EAPIKeyValueView class]])
        {
            EAPIKeyValueView *keyView = (EAPIKeyValueView *)view;
            NSDictionary *dictionary = [keyView getCurrentValues];
            [entryArray addObject:dictionary];
        }
    }
    
    [overAllArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.currentType == ArrayViewType ? @"array" : @"dictionary", @"type", field.text, @"key", entryArray, @"value", nil]];
    
    
    return [overAllArray autorelease];
}

@end
