//
//  EAPIBottomToolbar.m
//  EASYAPIFrontEnd
//
//  Created by Hyde, Andrew on 11/18/12.
//  Copyright (c) 2012 EAPI. All rights reserved.
//

#import "EAPIBottomToolbar.h"

@implementation EAPIBottomToolbar

- (id)initWithFrame:(CGRect)frame andReadURL:(NSString *)readURL andWriteURL:(NSString *)writeURL
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *border = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        border.backgroundColor = [UIColor blackColor];
        [self addSubview:border];
        [border release];
        
        UILabel *readLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 384, 50)];
        readLabel.backgroundColor = [UIColor clearColor];
        readLabel.textAlignment = NSTextAlignmentCenter;
        readLabel.text = readURL;
        [self addSubview:readLabel];
        [readLabel release];
        
        UILabel *writeLabel = [[UILabel alloc]initWithFrame:CGRectMake(384, 0, 384, 50)];
        writeLabel.backgroundColor = [UIColor clearColor];
        writeLabel.textAlignment = NSTextAlignmentCenter;
        writeLabel.text = writeURL;
        [self addSubview:writeLabel];
        [writeLabel release];
        
    }
    return self;
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
