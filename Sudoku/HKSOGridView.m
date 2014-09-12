//
//  HKSOGridView.m
//  Sudoku
//
//  Created by HMC on 9/12/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOGridView.h"

@interface HKSOGridView (){
    NSMutableArray* cells;
    
}

@end


@implementation HKSOGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGFloat x = frame.size.height/24.0;
        CGFloat y = frame.size.height/24.0;
        CGFloat buttonSize = frame.size.height/12.0;
        CGFloat thickBorder = frame.size.height/24.0;
        CGFloat thinBorder = frame.size.height/72.0;
        
        for (int i = 1; i < 10; i++){
            for (int j = 1; j < 10; j++){
                CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
                UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = i*10+j; // tag is a 2 digit number, column-row
                
                [self addSubview:button];
                
                
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlStateHighlighted];
                
                if (j == 9){
                    x = frame.size.height/24.0;
                }

                else if (j%3 == 0 ){
                    x = x + buttonSize + thickBorder;
                }
                else {
                    x = x + buttonSize + thinBorder;

                }
            }
            if (i%3 == 0 ){
                y = y + buttonSize + thickBorder;
            }
            else {
                y = y + buttonSize + thinBorder;
            }
        }
    }
    return self;
}

- (void) buttonPressed:(id)sender
{
    NSLog(@"Button %d was pressed", ((UIButton*)sender).tag);
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
