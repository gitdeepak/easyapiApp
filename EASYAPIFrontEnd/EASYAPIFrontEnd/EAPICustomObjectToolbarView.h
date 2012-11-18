//
//  EAPICustomObjectToolbarView.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/18/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomToolbarProtocol <NSObject>

-(void)createCustomObjectPressed;
-(void)submitButtonPressedWithName:(NSString *)name;
-(void)clearButtonPressed;
-(void)cancelButtonPressed;

@end

@interface EAPICustomObjectToolbarView : UIView

@property(nonatomic, assign)id<CustomToolbarProtocol>delegate;
@end
