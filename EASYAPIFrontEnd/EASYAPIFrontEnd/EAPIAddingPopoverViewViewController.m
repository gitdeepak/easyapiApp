//
//  EAPIAddingPopoverViewViewController.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPIAddingPopoverViewViewController.h"
#import "ESPNNetworkingManager.h"
#import "JSONKit.h"

@interface EAPIAddingPopoverViewViewController ()

@end

@implementation EAPIAddingPopoverViewViewController

static EAPIAddingPopoverViewViewController *sharedInstance = nil;

+(EAPIAddingPopoverViewViewController *)sharedInstance
{
    
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[EAPIAddingPopoverViewViewController alloc] init];
    });
    
    return sharedInstance;
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 400, 400);
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 400, 400) style:UITableViewStylePlain];
        tableView.tag = 8888;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
       
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customArray = [[NSMutableArray alloc]init];
     [self getPossibleTypes];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

-(void)getPossibleTypes
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://api.easyapi.co/endpoints/get"]];
    
    [ESPNNetworkingManager loadDataFromRequest:request withBlock:^(NSData *data, NSError *error)
     {
         NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         //
         [self saveArray: [string objectFromJSONString]];
     }];
    
}

-(void)saveArray:(NSArray *)array
{
    [EAPIAddingPopoverViewViewController sharedInstance].savedArray = array;
    for(NSDictionary *dict in array)
    {
        [self.customArray addObject:[dict objectForKey:@"name"]];
    }
    UITableView *tableView = (UITableView *)[self.view viewWithTag:8888];
    [tableView reloadData];
    

}

-(NSMutableArray *)getPossibleObjects
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"KeyPair", @"Dictionary", @"Array", nil];
    for(NSString *string in self.customArray)
    {
        [array addObject:string];
    }
    NSLog(@"%@", array);
    return array;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getPossibleObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *string = [[self getPossibleObjects] objectAtIndex:indexPath.row];
    
    if([string isKindOfClass:[NSString class]])
        cell.textLabel.text = string;
        // Configure the cell...
    if([string isKindOfClass:[NSArray class]])
    {
    
    }
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate itemSelectedWithName:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
}


@end
