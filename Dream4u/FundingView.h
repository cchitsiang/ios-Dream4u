//
//  FundingView.h
//  Dream4u
//
//  Created by Lam Si Mon on 12/7/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"

@interface FundingView : UIView
- (id)initWithDefaultNib;

@property (weak, nonatomic) IBOutlet UIImageView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *totalSponsored;
@property (weak, nonatomic) IBOutlet UILabel *daysLeft;
@property (weak, nonatomic) IBOutlet UIImageView *whiteBG;
@property (weak, nonatomic) IBOutlet UIView *bgHolder;
@property (weak, nonatomic) IBOutlet MDRadialProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@end
