//
//  MainVC.m
//  Dream4u
//
//  Created by Lam Si Mon on 12/6/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import "MainVC.h"
#import "SideTBV.h"
#import "FundingView.h"
#import "DataInfo.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "DetailPageVCViewController.h"

@interface MainVC ()
@property ( nonatomic , strong ) SideTBV *sideMenu;
@property ( nonatomic , strong ) FundingView *fundingView;
@property ( nonatomic , assign ) NSUInteger atIndex;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.revealSideViewController setDirectionsToShowBounce: PPRevealSideDirectionLeft];
    self.carousel.bounces = NO;
    self.carousel.pagingEnabled = YES;
    
//    UIImage *titleImage = [UIImage imageNamed:@"logo.png"];
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:titleImage];
//    [titleView addSubview:imageView];
//    
//    self.navigationController.navigationBar.topItem.titleView = titleView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"logobar.png"] forBarMetrics:UIBarMetricsDefault];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"menu.png"];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    [backButton addTarget:self action:@selector(menuBarTouch) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backButtonView = [[UIView alloc] initWithFrame:backButton.frame];
    [backButtonView addSubview:backButton];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

- (void)menuBarTouch
{
    
    if (self.sideMenu == nil)
    {
        self.sideMenu = [[SideTBV alloc] init];
    }
    
    [self.revealSideViewController pushViewController:self.sideMenu onDirection:PPRevealSideDirectionLeft withOffset:100.0 animated:YES];

    
    NSLog(@"Menu Bar Touch");
}


#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [[[Function instance] data] count];
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    DataInfo *info = [[Function instance] data][index];
    
    if (view == nil)
    {
        self.fundingView = [[FundingView alloc] initWithDefaultNib];

        UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAtVideo)];
        [self.fundingView.videoView addGestureRecognizer:rec];

        UITapGestureRecognizer *rec2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAtVideo2)];
        [self.fundingView.secondView addGestureRecognizer:rec2];

        
        self.fundingView.videoView.userInteractionEnabled = YES;
        
    }
    self.fundingView.videoView.image = info.userImage;
    self.fundingView.title.text = info.title;
    self.fundingView.totalSponsored.text = info.totalSponsored;
    self.fundingView.daysLeft.text = info.daysLeft;
    
    self.fundingView.progressView.progressTotal = [info.totalFundNeeded intValue];
    self.fundingView.progressView.progressCounter = [info.fundsCollected intValue];
    self.fundingView.progressView.theme.completedColor = [UIColor colorWithRed:54.0/255.0 green:169.0/255.0 blue:255.0/255.0 alpha:1.0];
    //NSLog(@"NEeded : %i",[info.totalFundNeeded intValue]);
    
    float total = [info.fundsCollected floatValue]/[info.totalFundNeeded floatValue];
    
    self.fundingView.progressView.theme.sliceDividerHidden = YES;
    self.fundingView.progressView.label.text = [NSString stringWithFormat:@"%.0f%%",total * 100];
    self.fundingView.progressView.label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25.0];

    return self.fundingView;
}


//#pragma mark - iCarouselDelegate
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    self.atIndex = carousel.currentItemIndex;
}

- (void)tappedAtVideo
{
    DetailPageVCViewController *vc = [[DetailPageVCViewController alloc] init];
    vc.info = [[Function instance] data][self.atIndex];
    vc.showVideo = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tappedAtVideo2
{
    DetailPageVCViewController *vc = [[DetailPageVCViewController alloc] init];
    vc.info = [[Function instance] data][self.atIndex];
    vc.showVideo = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
