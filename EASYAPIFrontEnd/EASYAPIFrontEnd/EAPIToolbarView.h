//
//  EAPIToolbarView.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/18/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolbarProtocol <NSObject>

-(void)createCustomObjectPressed;
-(void)submitButtonPressedWithName:(NSString *)name;
-(void)clearButtonPressed;

@end

@interface EAPIToolbarView : UIView

@property(nonatomic, assign)id<ToolbarProtocol>delegate;

@end
