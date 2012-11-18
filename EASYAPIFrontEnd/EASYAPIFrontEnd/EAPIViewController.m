//
//  EAPIViewController.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPIViewController.h"
#import "JSONKit.h"
#import "ESPNNetworkingManager.h"
#import "EAPICustomObjectView.h"
#import "EAPIBottomToolbar.h"
#import "UIColor+Hex.h"

#define kToolbarTag 32221

@interface EAPIViewController ()

@end

@implementation EAPIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"DDDDDD"];
    
    EAPIToolbarView *toolbar = [[EAPIToolbarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    toolbar.tag = kToolbarTag;
    [self.view addSubview:toolbar];
    toolbar.delegate = self;
    [toolbar release];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.tag = 7777;
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    [scrollView addSubview:contentView];
    scrollView.contentSize = contentView.frame.size;
    [self.view addSubview:scrollView];
    [scrollView release];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 20, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"{";
    [contentView addSubview:label];
    [label release];
    
    currentYOffset = 40;
    
    EAPIAddView *addView = [[EAPIAddView alloc]initWithFrame:CGRectMake(25, currentYOffset, 50, 50) andType:RootTypeView];
    addView.tag = 5432;
    addView.delegate = self;
    [contentView addSubview:addView];
    [addView release];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didAddItemWithName:(NSString *)name
{
    if([name isEqualToString:@"KeyPair"])
    {
        [contentView addSubview:[self createKeyValueViewAtOrigin:CGPointMake(25, currentYOffset)]];
        currentYOffset+= 50;
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
        
    }
    else if([name isEqualToString:@"Dictionary"])
    {
        EAPIDictionaryView *view = [self createDictionaryViewAtOrigin:CGPointMake(25, currentYOffset) andType:DictionaryViewType];
        view.delegate = self;
        [contentView addSubview:view];
        currentYOffset += view.frame.size.height;
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
    }
    else if([name isEqualToString:@"Array"])
    {
        EAPIDictionaryView *view = [self createDictionaryViewAtOrigin:CGPointMake(25, currentYOffset) andType:ArrayViewType];
        view.delegate = self;
        [contentView addSubview:view];
        currentYOffset += view.frame.size.height;
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
    }
    else
    {
        NSArray *array = [EAPIAddingPopoverViewViewController sharedInstance].savedArray;
        
        for(NSDictionary *dict in array)
        {
            if([[dict valueForKey:@"name"] isEqualToString:name])
            {
                EAPICustomObjectView *view = [[EAPICustomObjectView alloc]initWithFrame:CGRectMake(25, currentYOffset, 200, 70) andName:name];
                [contentView addSubview:view];
                currentYOffset+= view.frame.size.height;
                [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
            }
        }
        
    }
}

-(void)updateAddViewForOrigin:(CGPoint)origin
{
    UIView *addView = [self.view viewWithTag:5432];
    addView.frame = CGRectMake(addView.frame.origin.x, origin.y, addView.frame.size.width, addView.frame.size.height);
}

-(EAPIKeyValueView *)createKeyValueViewAtOrigin:(CGPoint)origin
{
    EAPIKeyValueView *view = [[EAPIKeyValueView alloc]initWithFrame:CGRectMake(origin.x, origin.y, 310, 44) andType:DictionaryViewType];
    
    return [view autorelease];
}

-(EAPIDictionaryView *)createDictionaryViewAtOrigin:(CGPoint)origin andType:(ViewType)type
{
    EAPIDictionaryView *view = [[EAPIDictionaryView alloc]initWithFrame:CGRectMake(origin.x, origin.y, 310, 75) andType:type];
    return [view autorelease];
}


-(void)addedToHeight:(int)height
{
    UIView *addView = [contentView viewWithTag:5432];
    currentYOffset+= height;
    
    if(currentYOffset >= contentView.frame.size.height-30)
    {
        contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height+(currentYOffset - contentView.frame.size.height+30));
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:7777];
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, contentView.frame.size.height+30);
    }
    
    [self updateAddViewForOrigin:CGPointMake(addView.frame.origin.x, addView.frame.origin.y+height)];
}

-(NSDictionary *)getCurrentJSONRepresentationWithName:(NSString *)name
{
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];

    for(UIView *view in contentView.subviews)
    {
        if([view isKindOfClass:[EAPIDictionaryView class]])
        {
            EAPIDictionaryView *dictionaryView = (EAPIDictionaryView *)view;
            NSArray *returnArray = [dictionaryView getCurrentValues];
            for(int x = 0; x < [returnArray count]; x++)
            {
                [array addObject:[returnArray objectAtIndex:x]];
            }
        }
        if([view isKindOfClass:[EAPIKeyValueView class]])
        {
            EAPIKeyValueView *keyView = (EAPIKeyValueView *)view;
            [array addObject:[keyView getCurrentValues]];
        }
        if([view isKindOfClass:[EAPICustomObjectView class]])
        {
            EAPICustomObjectView *custom = (EAPICustomObjectView *)view;
            [array addObject:[custom getCurrentValues]];
        }
    }
    
    NSDictionary *returnDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"endpoint", @"type", array, @"value", @"key", name, @"projectid", @"1", nil];
    
    return [returnDict autorelease];
    
}

#pragma mark -
#pragma mark Utilities

-(NSString *)getEPID
{
    return @"1";
}

#pragma mark -
#pragma mark Toolbar Utilities

-(void)submitButtonPressedWithName:(NSString *)name;
{
    NSString *url = [NSString stringWithFormat:@"http://api.easyapi.co/endpoints/create?name=%@&projectid=1", name];
    
    NSString *body = [NSString stringWithFormat:@"blob=%@",[[self getCurrentJSONRepresentationWithName:name] JSONString] ];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    
    body = [body stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding]];
    
    [request setValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
    
    [ESPNNetworkingManager loadDataFromRequest:request withBlock:^(NSData *data, NSError *error)
     {
         NSLog(@"Sent Data:%@", body);
         NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         
         NSDictionary *dict = [result objectFromJSONString];
         
         NSLog(@"Recieved Result:%@", result);
         
         EAPIBottomToolbar *bottomToolbar = [[EAPIBottomToolbar alloc]initWithFrame:CGRectMake(0, 1024, 768, 50) andReadURL:[NSString stringWithFormat:@"http://api.easyapi.co/endpoints/render?id=%@", [dict objectForKey:@"id"]] andWriteURL:@""];
         [self.view addSubview:bottomToolbar];
         [UIView animateWithDuration:1 animations:^(void)
          {
              bottomToolbar.frame = CGRectMake(0, 1024-50-20, 768, 50);
          }];
         
     }];
}

-(void)clearButtonPressed
{
    for(UIView *view in contentView.subviews)
    {
        [view removeFromSuperview];
    }
    currentYOffset = 50;
    [self viewDidLoad];
    
    EAPIToolbarView *toolbar = (EAPIToolbarView *)[self.view viewWithTag:kToolbarTag];
    [UIView animateWithDuration:1 animations:^(void)
     {
         toolbar.frame = CGRectMake(0, 1024, toolbar.frame.size.width, 50);
     }];
}

-(void)createCustomObjectPressed
{
    EAPICreateCustomObjectViewController *customObject = [[[EAPICreateCustomObjectViewController alloc]init] autorelease];
    [self presentViewController:customObject animated:YES completion:^(void)
     {
         //NSLog(@"dismissed");
     }];
}

@end
