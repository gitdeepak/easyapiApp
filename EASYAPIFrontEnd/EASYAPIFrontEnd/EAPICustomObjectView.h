//
//  EAPICustomObjectView.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/18/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAPICustomObjectView : UIView

- (id)initWithFrame:(CGRect)frame andName:(NSString *)name;

@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *identifier;

-(NSMutableArray *)getCurrentValues;

@end
