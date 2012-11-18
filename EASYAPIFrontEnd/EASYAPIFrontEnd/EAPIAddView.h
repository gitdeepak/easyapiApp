//
//  EAPIAddView.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAPIAddingPopoverViewViewController.h"
#import "EAPIKeyValueView.h"

@protocol AddViewProtocol <NSObject>

-(void)didAddItemWithName:(NSString *)name;

@end

@interface EAPIAddView : UIView <AddingPopoverProtocol>
{
    UIPopoverController *controller;
}

- (id)initWithFrame:(CGRect)frame andType:(ViewType)type;

@property(nonatomic, assign)id<AddViewProtocol>delegate;
@end
