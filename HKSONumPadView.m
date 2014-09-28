//
//  HKSONumPadView.m
//  Sudoku
//
//  Created by Yaxi Gao on 9/19/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import "HKSONumPadView.h"

@interface HKSONumPadView () {
    NSMutableArray* cells;
    int highlightedButton;
}
@end


@implementation HKSONumPadView

- (id)initWithFrame:(CGRect)frame
{
    // Initially no cell is highlighted.
    highlightedButton = -1;
    
    self = [super initWithFrame:frame];
    cells = [[NSMutableArray alloc] init];
    
    if (self) {
        
        // Initialization code
        CGFloat x = frame.size.width / 24.0;
        CGFloat y = frame.size.height / 6.0;
        CGFloat buttonSize = frame.size.width / 12.0;
        CGFloat border = frame.size.width / 45.0;
        
        for (int i = 0; i < 9; ++i) {
            
            CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
            UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
            button.backgroundColor = [UIColor colorWithRed:0.9 green:0.8 blue:1.0 alpha:0.9];
            button.tag = i;
            
            x = x + buttonSize + border;
            
            [button setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            [cells addObject:button];
            [self addSubview:button];

        }
        
    }
    return self;
}

- (void) cellSelected:(id)sender
{
    if (highlightedButton >= 0) {
        // If there is an already highlighted cell, change its background color back to white.
        [[cells objectAtIndex:highlightedButton] setBackgroundColor:[UIColor colorWithRed:0.9 green:0.8 blue:1.0 alpha:0.9]];
    }
    ((UIButton*) sender).backgroundColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.5 alpha:1.0];
    // update the current highlighted cell
    highlightedButton = (int)((UIButton*)sender).tag;
    
}

- (int) getHighlightedButton
{
    return highlightedButton;
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
