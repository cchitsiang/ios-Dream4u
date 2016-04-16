//
//  DetailPageVCViewController.m
//  Dream4u
//
//  Created by Lam Si Mon on 12/7/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import "DetailPageVCViewController.h"
#import "FirstRowCell.h"
#import "SecondRowCell.h"
#import "ThirdRowCell.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "AppDelegate.h"
#import "PaymentVC.h"

//Paypal Environment
#define PayPalEnvironment  PayPalEnvironmentSandbox

/*Paypal*/
static NSString *const Currency = @"USD";
static NSString *const Merchant = @"Hacktivist";
static NSString *const ItemName = @"Funding";
static NSString *const ShortDescription = @"Funding for the needy";

/*Cell Identifier*/
static NSString *const  PaymentCellIdentifier = @"PaymentCellIdentifier";


@interface DetailPageVCViewController ()
@property ( nonatomic , strong , readwrite ) PayPalConfiguration *ppConfiguration;

@end

@implementation DetailPageVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"logobar.png"] forBarMetrics:UIBarMetricsDefault];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIImage *titleImage = [UIImage imageNamed:@"logo.png"];
//        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:titleImage];
//        [titleView addSubview:imageView];
//        
//        self.navigationController.navigationBar.topItem.titleView = titleView;
//    });

    
    [self.detailTBV registerNib:[UINib nibWithNibName:NSStringFromClass([FirstRowCell class]) bundle:nil] forCellReuseIdentifier:@"1"];
    
    [self.detailTBV registerNib:[UINib nibWithNibName:NSStringFromClass([SecondRowCell class]) bundle:nil] forCellReuseIdentifier:@"2"];
    
    [self.detailTBV registerNib:[UINib nibWithNibName:NSStringFromClass([ThirdRowCell class]) bundle:nil] forCellReuseIdentifier:@"3"];

    self.userImage.image = self.info.userImage;
    self.userName.text = self.info.name;
    self.userAgeAddress.text = [NSString stringWithFormat:@"%@, %@",self.info.age,self.info.placeOfBirth];
    self.collegeName.text = self.info.courseStudy;
    self.titleLbl.text = self.info.title;
    
    [self resetAllButtons];
    self.aboutBtn.selected = YES;
    
    if (self.showVideo)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self playVideo];
        });
    }
    
    self.userImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo)];
    [self.userImage addGestureRecognizer:rec];
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self.payView];
    
    self.payView.alpha = 0;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironment];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}


- (void)playVideo
{
    NSString *filepath   =   [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp4"];
    NSURL    *fileURL    =   [NSURL fileURLWithPath:filepath];
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlaybackComplete:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayerController];
    
    [self.view addSubview:self.moviePlayerController.view];
    self.moviePlayerController.fullscreen = YES;
    [self.moviePlayerController play];
}


- (void)moviePlaybackComplete:(MPMoviePlayerController*)controller
{
    NSLog(@"Done");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.aboutBtn.selected)
    {
        return 363;
    }
    else if (self.goalBtn.selected)
    {
        return 135;
    }
    else if (self.commentBtn.selected)
    {
        return 135;
    }
    
    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.aboutBtn.selected)
    {
        FirstRowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
        return cell;
    }
    else if (self.goalBtn.selected)
    {
        SecondRowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"2"];

        cell.radialProgress.progressTotal = [self.info.totalFundNeeded intValue];
        cell.radialProgress.progressCounter = [self.info.fundsCollected intValue];
        
        //NSLog(@"NEeded : %i",[info.totalFundNeeded intValue]);
        
        float total = [self.info.fundsCollected floatValue]/[self.info.totalFundNeeded floatValue];
        cell.radialProgress.theme.sliceDividerHidden = YES;
        cell.radialProgress.label.text = [NSString stringWithFormat:@"%.0f%%",total * 100];
    
        cell.fundRaised.text = self.info.fundsCollected;
        cell.totalSponsored.text = self.info.totalSponsored;
        cell.daysLeft.text = self.info.daysLeft;
        cell.radialProgress.theme.completedColor = [UIColor colorWithRed:54.0/255.0 green:169.0/255.0 blue:255.0/255.0 alpha:1.0];

        cell.radialProgress.label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:28];

        return cell;
    }
    else if (self.commentBtn.selected)
    {
        ThirdRowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"3"];
        return cell;
    }
    
    return nil;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - IBAction

- (IBAction)buttonPressed:(id)sender
{
    [self resetAllButtons];
    
    switch ([sender tag])
    {
        case 0:
            self.aboutBtn.selected = YES;
            break;
        case 1:
            self.goalBtn.selected = YES;
            break;
        case 2:
            self.commentBtn.selected = YES;
            break;
        default:
            break;
    }
    
    [self.detailTBV reloadData];
}

- (IBAction)sponsor:(id)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.payView.alpha = 1;
    }];
    
    [self.amountTF becomeFirstResponder];
}


- (IBAction)paypalBtn:(id)sender
{
    self.payView.alpha = 0;

    [self initializePaypal];
    [self initializeItem];

//    PaymentVC *vc = [[PaymentVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)cancelBtn:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.payView.alpha = 0.0;
    }];
}


#pragma mark - Private Method

- (void)resetAllButtons
{
    self.aboutBtn.selected = NO;
    self.goalBtn.selected = NO;
    self.commentBtn.selected = NO;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)initializePaypal
{
    self.ppConfiguration = [[PayPalConfiguration alloc] init];
    self.ppConfiguration.acceptCreditCards = NO;
    self.ppConfiguration.merchantName = Merchant;
    self.ppConfiguration.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    self.ppConfiguration.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
}


- (void)initializeItem
{
    PayPalItem *item = [PayPalItem itemWithName:ItemName
                                   withQuantity:1
                                      withPrice:[NSDecimalNumber decimalNumberWithString:self.amountTF.text]
                                   withCurrency:Currency
                                        withSku:nil];
    
    NSArray *items = @[item];
    NSDecimalNumber *subTotal = [PayPalItem totalPriceForItems:items];
    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails
                                            paymentDetailsWithSubtotal:subTotal
                                            withShipping:nil
                                            withTax:nil];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = subTotal;
    payment.currencyCode = Currency;
    payment.shortDescription = ShortDescription;
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable)
    {
        //Payment cannot be processed
    }
    
    self.ppConfiguration.acceptCreditCards = NO;
    
    [self payWithPayPalPayment:payment withTotal:subTotal];
    
}


- (void)payWithPayPalPayment:(PayPalPayment *)payment withTotal:(NSDecimalNumber*)total
{
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                          
                                                                                                configuration:self.ppConfiguration
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}


#pragma mark - PayPalPaymentDelegate

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Payment Cancelled"
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment
{
    NSLog(@"Paypal Complete with confirmation : %@" , completedPayment.confirmation);
    
    NSString *message = nil;
    
    if (paymentViewController.state == PayPalPaymentViewControllerStateUnsent)
    {
        //Payment not sent
        message = @"Payment not sent.";
    }
    else
    {
        message = @"Your transaction is successfull";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    
    [alert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
