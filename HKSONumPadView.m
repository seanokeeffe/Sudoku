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
    highlightedButton = -1;
    
    self = [super initWithFrame:frame];
    cells = [[NSMutableArray alloc] init];
    
    if (self) {
        // Initialization code
        
        CGFloat x = frame.size.width/24.0;
        CGFloat y = frame.size.height/6.0;
        CGFloat buttonSize = frame.size.width/12.0;
        CGFloat border = frame.size.width/45.0;
        
        for (int i = 0; i < 9; ++i) {
            
            CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
            UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
            button.backgroundColor = [UIColor whiteColor];
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
        [[cells objectAtIndex:highlightedButton] setBackgroundColor:[UIColor whiteColor]];
    }
    ((UIButton*) sender).backgroundColor = [UIColor yellowColor];
    highlightedButton = ((UIButton*)sender).tag;
    
}

- (int) highlightedButton
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
