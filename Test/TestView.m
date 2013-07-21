//
//  TestView.m
//  Test
//
//  Created by mac on 13-7-11.
//  Copyright (c) 2013年 xiaoran. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    
    UIImage *startImage = [UIImage imageNamed:@"compose-at"];
    // Create the proper sized rect
    CGRect imageRect = rect;
    
    // Create a new bitmap context
    CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, CGImageGetColorSpace(startImage.CGImage), kCGImageAlphaPremultipliedLast);
    
    CGContextSetRGBFillColor(context, 220, 220, 220, 1);
    CGContextFillRect(context, imageRect);
    
    
    
    
    // Cleanup
    CGContextRelease(context);

    
    
    
    
}


@end
