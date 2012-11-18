//
//  EAPICreateCustomObjectViewController.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPICreateCustomObjectViewController.h"
#import "JSONKit.h"
#import "ESPNNetworkingManager.h"

@interface EAPICreateCustomObjectViewController ()

@end

@implementation EAPICreateCustomObjectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"CREATE" forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width-200, 0, 200, 50);
    [button addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"DISMISS" forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width-300, 0, 100, 50);
    [button addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    currentYOffset = 50;
    
    EAPIAddView *addView = [[EAPIAddView alloc]initWithFrame:CGRectMake(25, currentYOffset, 50, 50) andType:DictionaryViewType];
    addView.tag = 5432;
    addView.delegate = self;
    [self.view addSubview:addView];
    [addView release];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)dismissButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void)
    {
        
    }];
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
        [self.view addSubview:[self createKeyValueViewAtOrigin:CGPointMake(25, currentYOffset)]];
        currentYOffset+= 50;
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
        
    }
    else if([name isEqualToString:@"Dictionary"])
    {
        EAPIDictionaryView *view = [self createDictionaryViewAtOrigin:CGPointMake(25, currentYOffset) andType:DictionaryViewType];
        view.delegate = self;
        [self.view addSubview:view];
        currentYOffset += view.frame.size.height;
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
    }
    else if([name isEqualToString:@"Array"])
    {
        EAPIDictionaryView *view = [self createDictionaryViewAtOrigin:CGPointMake(25, currentYOffset) andType:ArrayViewType];
        view.delegate = self;
        [self.view addSubview:view];
        currentYOffset += view.frame.size.height;
        [self updateAddViewForOrigin:CGPointMake(0, currentYOffset)];
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
    UIView *addView = [self.view viewWithTag:5432];
    currentYOffset+= height;
    [self updateAddViewForOrigin:CGPointMake(addView.frame.origin.x, addView.frame.origin.y+height)];
}

-(NSDictionary *)getCurrentJSONRepresentation
{
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for(UIView *view in self.view.subviews)
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
    }
    
    NSDictionary *returnDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"endpoint", @"type", array, @"value", @"MYFIRSTENDPOINT", @"key", [self getEPID], @"projectID", nil];
    
    return [returnDict autorelease];
    
}

-(IBAction)submitButtonPressed:(id)sender
{
    NSString *url = @"http://easy-api.herokuapp.com/customObject";
    
    NSString *body = [NSString stringWithFormat:@"blob=%@",[[self getCurrentJSONRepresentation] JSONString] ];
    
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
         NSLog(@"Recieved Result:%@", result);
     }];
}

-(NSString *)getEPID
{
    return @"1";
}


@end
