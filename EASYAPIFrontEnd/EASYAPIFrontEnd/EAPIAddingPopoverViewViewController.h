//
//  EAPIAddingPopoverViewViewController.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol AddingPopoverProtocol <NSObject>

-(void)itemSelectedWithName:(NSString *)name;

@end

@interface EAPIAddingPopoverViewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, assign)id<AddingPopoverProtocol>delegate;
@property(nonatomic, retain)NSMutableArray *customArray;
@property(nonatomic, retain)NSArray *savedArray;

+(EAPIAddingPopoverViewViewController *)sharedInstance;

@end
