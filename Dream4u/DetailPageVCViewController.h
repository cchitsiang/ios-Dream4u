//
//  DetailPageVCViewController.h
//  Dream4u
//
//  Created by Lam Si Mon on 12/7/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataInfo.h"
#import <MediaPlayer/MediaPlayer.h>
#import <PayPal-iOS-SDK/PayPalMobile.h>

@interface DetailPageVCViewController : UIViewController <PayPalPaymentDelegate>
@property (weak, nonatomic) IBOutlet UITableView *detailTBV;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAgeAddress;
@property (weak, nonatomic) IBOutlet UILabel *collegeName;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *aboutBtn;
@property (weak, nonatomic) IBOutlet UIButton *goalBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property ( nonatomic , strong ) MPMoviePlayerController *moviePlayerController;
@property ( nonatomic , strong ) DataInfo *info;
@property ( nonatomic , assign ) BOOL showVideo;
@property (strong, nonatomic) IBOutlet UIView *payView;

@property (weak, nonatomic) IBOutlet UITextField *amountTF;
- (IBAction)paypalBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)sponsor:(id)sender;

@end
