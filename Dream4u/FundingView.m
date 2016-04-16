//
//  FundingView.m
//  Dream4u
//
//  Created by Lam Si Mon on 12/7/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import "FundingView.h"

@implementation FundingView

- (id)initWithDefaultNib
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"FundingView" owner:self options:nil];
    
    FundingView *view = [array lastObject];
    
    return view;
}

@end
