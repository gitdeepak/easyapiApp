//
//  EAPIDictionaryView.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAPIAddView.h"
#import "EAPIKeyValueView.h"
#import "EAPIDictionaryView.h"

@protocol DictionaryProtocol <NSObject>

-(void)addedToHeight:(int)height;

@end

@interface EAPIDictionaryView : UIView <AddViewProtocol, DictionaryProtocol>
{
    int currentYOffset;
}

@property(nonatomic, assign)id<DictionaryProtocol>delegate;
@property(nonatomic, assign)ViewType currentType;

- (id)initWithFrame:(CGRect)frame andType:(ViewType)type;
-(NSMutableArray *)getCurrentValues;

@end
