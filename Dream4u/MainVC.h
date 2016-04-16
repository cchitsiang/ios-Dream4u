//
//  MainVC.h
//  Dream4u
//
//  Created by Lam Si Mon on 12/6/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel/iCarousel.h>

@interface MainVC : UIViewController <iCarouselDataSource,iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@end
