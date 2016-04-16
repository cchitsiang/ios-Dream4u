//
//  SecondRowCell.h
//  Dream4u
//
//  Created by Lam Si Mon on 12/7/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"

@interface SecondRowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fundRaised;
@property (weak, nonatomic) IBOutlet UILabel *totalSponsored;
@property (weak, nonatomic) IBOutlet UILabel *daysLeft;
@property (weak, nonatomic) IBOutlet MDRadialProgressView *radialProgress;

@end
