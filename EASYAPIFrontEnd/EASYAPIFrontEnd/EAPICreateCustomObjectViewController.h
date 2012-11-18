//
//  EAPICreateCustomObjectViewController.h
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/17/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAPIAddView.h"
#import "EAPIKeyValueView.h"
#import "EAPIDictionaryView.h"
#import "EAPICustomObjectToolbarView.h"


@interface EAPICreateCustomObjectViewController : UIViewController<AddViewProtocol, DictionaryProtocol, CustomToolbarProtocol>
{
    
    UIView *contentView;
    int currentYOffset;
}

@end
