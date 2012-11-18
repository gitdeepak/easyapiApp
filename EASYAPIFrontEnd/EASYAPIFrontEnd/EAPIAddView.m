//
//  EAPIAddView.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPIAddView.h"
#import "EAPIAppDelegate.h"
#import "EAPIViewController.h"

@implementation EAPIAddView

- (id)initWithFrame:(CGRect)frame andType:(ViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        button.frame = CGRectMake(0, 0, 20, 20);
        [button addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-10, 20, 20, 20)];
        label.backgroundColor = [UIColor clearColor];
        if(type == DictionaryViewType)
            label.text = @"},";
        else if(type == RootTypeView)
            label.text = @"}";
        else if(type == ArrayViewType)
            label.text = @"],";
        [self addSubview:label];
        [label release];
        
        // Initialization code
    }
    return self;
}

-(IBAction)addButtonPressed:(id)sender
{
    EAPIAddingPopoverViewViewController *popoverView = [[EAPIAddingPopoverViewViewController alloc]init];
    popoverView.delegate = self;
    controller = [[UIPopoverController alloc]initWithContentViewController:popoverView];
    controller.popoverContentSize = popoverView.view.frame.size;
    [controller presentPopoverFromRect:CGRectMake(45, self.center.y-15, 1, 1) inView:[self getTopViewController].view permittedArrowDirections:nil animated:YES];
}

-(void)itemSelectedWithName:(NSString *)name
{
    [controller dismissPopoverAnimated:YES];
    
    [self.delegate didAddItemWithName:name];
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

-(UIViewController *)getTopViewController
{
    return ((EAPIAppDelegate *)[[UIApplication sharedApplication] delegate]).viewController;
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
