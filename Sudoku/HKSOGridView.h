//
//  HKSOGridView.h
//  Sudoku
//
//  Created by HMC on 9/12/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSOGridView : UIView

- (void) setValueAtRow:(int)row andColumn:(int)col toValue:(int)value;

- (void) addTarget: (id) theTarget action:(SEL)theAction;

-(void)setToInitialAtRow:(int)row andColumn:(int)col;

@end
