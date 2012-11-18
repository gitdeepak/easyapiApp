//
//  EAPIKeyValueView.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    DictionaryViewType,
    ArrayViewType,
    RootTypeView
}ViewType;

@interface EAPIKeyValueView : UIView

-(NSDictionary *)getCurrentValues;
- (id)initWithFrame:(CGRect)frame andType:(ViewType)type;

@property(nonatomic, assign)ViewType currentType;

@end
