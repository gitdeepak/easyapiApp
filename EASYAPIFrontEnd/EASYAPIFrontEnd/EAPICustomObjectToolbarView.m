//
//  EAPICustomObjectToolbarView.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/18/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPICustomObjectToolbarView.h"

@implementation EAPICustomObjectToolbarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"DDDDDD"];
        
        UIView *border = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        border.backgroundColor = [UIColor blackColor];
        [self addSubview:border];
        [border release];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Cancel" forState:UIControlStateNormal];
        [button setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 120, frame.size.height);
        [self addSubview:button];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(175, 0, 240, frame.size.height)];
        textField.placeholder = @"Name";
        textField.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        textField.tag = 10001;
        [textField setBorderStyle:UITextBorderStyleBezel];
        [self addSubview:textField];
        [textField release];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Custom Object" forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        [button setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(customObjectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(225+190, 0, 120, frame.size.height);
        [self addSubview:button];
        
        border = [[UIView alloc]initWithFrame:CGRectMake(225+100+210, 0, 1, 50)];
        border.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:border];
        [border release];
        
        border = [[UIView alloc]initWithFrame:CGRectMake(225+100+180+150, 0, 1, 50)];
        border.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:border];
        [border release];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Clear" forState:UIControlStateNormal];
        [button setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clearButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(225+210+100, 0, 120, frame.size.height);
        [self addSubview:button];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"Submit" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(225+180+150+100, 0, 120, frame.size.height);
        [self addSubview:button];
    }
    return self;
}

-(IBAction)submitButtonPressed:(id)sender
{
    UITextField *textField = (UITextField *)[self viewWithTag:10001];
    
    [self.delegate submitButtonPressedWithName:textField.text];
}

-(IBAction)clearButtonPressed:(id)sender
{
    [self.delegate clearButtonPressed];
}

-(IBAction)customObjectButtonPressed:(id)sender
{
    [self.delegate createCustomObjectPressed];
}

-(IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate cancelButtonPressed];
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
