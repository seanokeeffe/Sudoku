//
//  HKSOGridView.m
//  Sudoku
//
//  Created by HMC on 9/12/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOGridView.h"

@interface HKSOGridView (){
    NSMutableArray* gridCells;
    
    id target;
    
    SEL action;
    
}

@end


@implementation HKSOGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        gridCells = [[NSMutableArray alloc] init];
        
        CGFloat x = frame.size.height/24.0;
        CGFloat y = frame.size.height/24.0;
        CGFloat buttonSize = frame.size.height/12.0;
        CGFloat thickBorder = frame.size.height/24.0;
        CGFloat thinBorder = frame.size.height/72.0;
        
        int buttonTag = 0;
        for (int i = 0; i < 9; i++){
            for (int j = 0; j < 9; j++){
                // create and set up a button
                CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
                UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = buttonTag++;
                
                UIImage* image = [self imageWithColor:[UIColor yellowColor]];
                [button setBackgroundImage:image forState:UIControlStateHighlighted];
                [button setShowsTouchWhenHighlighted:YES];
                
                [gridCells addObject:button];
                [self addSubview:button];
                
                [button addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlStateHighlighted];
                
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

- (void) setValueAtRow:(int)row andColumn:(int)col toValue:(int)value
{
    UIButton* button = [gridCells objectAtIndex:9 * col + row];
    
    if (value != 0) {
        [button setTitle:[NSString stringWithFormat:@"%d",value] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
}

- (void) addTarget:(id)theTarget action:(SEL)theAction
{
    target = theTarget;
    action = theAction;
}

- (void) cellSelected:(id)sender
{
    [target performSelector:action withObject:((UIButton*) sender)];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
