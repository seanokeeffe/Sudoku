//
//  HKSOGridView.m
//  Sudoku
//
//  Created by Sean on 9/12/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import "HKSOGridView.h"

@interface HKSOGridView (){
    
    NSMutableArray* _gridCells;
    id _target;
    SEL _action;
    
}
@end


@implementation HKSOGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        _gridCells = [[NSMutableArray alloc] init];
        
        CGFloat x = frame.size.height / 24.0;
        CGFloat y = frame.size.height / 24.0;
        CGFloat buttonSize = frame.size.height / 12.0;
        CGFloat thickBorder = frame.size.height / 24.0;
        CGFloat thinBorder = frame.size.height / 72.0;
        
        int buttonTag = 0;
        
        for (int i = 0; i < 9; i++){
            for (int j = 0; j < 9; j++){
                
                // create and set up a button
                CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
                UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
                
                [self setBackgroundColorAtRow:i AndCol:j ofButton:button];
                button.tag = buttonTag++;
                [_gridCells addObject:button];
                [self addSubview:button];
                
                // adjusting for the border widths between columns
                if (j == 8){
                    x = frame.size.height / 24.0;
                }
                else if ((j + 1) % 3 == 0 ){
                    x = x + buttonSize + thickBorder;
                }
                else {
                    x = x + buttonSize + thinBorder;
                }
            }
            
            // adjusting for the border widths between rows
            if ((i + 1) % 3 == 0 ){
                y = y + buttonSize + thickBorder;
            }
            else {
                y = y + buttonSize + thinBorder;
            }
        }
    }
    return self;
}

// set cell to user-entered values
- (void) setValueAtRow:(int)row andColumn:(int)col toValue:(int)value
{
    UIButton* button = [_gridCells objectAtIndex:9 * row + col];
    
    [button removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [button addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    if (value != 0) {
        [button setTitle:[NSString stringWithFormat:@"%d",value] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [button setTitle:[NSString stringWithFormat:@" "] forState:UIControlStateNormal];
    }
    
    UIImage* image = [self imageWithColor:[UIColor yellowColor]];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    [button setShowsTouchWhenHighlighted:YES];
    
}

// differentiate initial grid cells with a different size and font
// also removes the target so that the user cannot change its value
-(void)setToInitialAtRow:(int)row andColumn:(int)col
{
    UIButton* button = [_gridCells objectAtIndex:9 * row + col];
    [button removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    UIImage* image = [self imageWithColor:[UIColor redColor]];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    [button setShowsTouchWhenHighlighted:YES];
}

- (void) addTarget:(id)theTarget action:(SEL)theAction
{
    _target = theTarget;
    _action = theAction;
}

- (void) cellSelected:(id)sender
{
    [_target performSelector:_action withObject:((UIButton*) sender)];
}

// set different background colors to differentiate blocks
- (void) setBackgroundColorAtRow:(int)i AndCol:(int)j ofButton:(UIButton*)button
{
    if (((i < 3 || i > 5) && (j > 2 && j < 6)) || ((i > 2 && i < 6) && (j < 3 || j > 5))) {
        button.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.8 alpha:1.0];
    } else {
        button.backgroundColor = [UIColor colorWithRed:1.0 green:0.7 blue:0.6 alpha:1.0];
    }
}

// creates an image of one solid color for the cells highlighted state
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


@end
