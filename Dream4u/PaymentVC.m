//
//  PaymentVC.m
//  Dream4u
//
//  Created by Lam Si Mon on 12/6/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import "PaymentVC.h"
#import "PaymentCell.h"
@interface PaymentVC ()

@property (weak, nonatomic) IBOutlet UITableView *paymentTBV;
@property ( nonatomic , strong ) NSArray *denominations;
@property ( nonatomic , strong ) NSString *amount;
@property ( nonatomic , strong , readwrite ) PayPalConfiguration *ppConfiguration;
@end

//Paypal Environment
#define PayPalEnvironment  PayPalEnvironmentSandbox

/*Paypal*/
static NSString *const Currency = @"USD";
static NSString *const Merchant = @"Hacktivist";
static NSString *const ItemName = @"Funding";
static NSString *const ShortDescription = @"Funding for the needy";

/*Cell Identifier*/
static NSString *const  PaymentCellIdentifier = @"PaymentCellIdentifier";



@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.paymentTBV registerNib:[UINib nibWithNibName:NSStringFromClass([PaymentCell class]) bundle:nil] forCellReuseIdentifier:PaymentCellIdentifier];
    
    self.denominations = @[@"1.00",
                           @"3.00",
                           @"5.00",
                           @"10.00",
                           @"15.00",
                           @"20.00",
                           @"30000.00"];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironment];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.denominations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:PaymentCellIdentifier];
    
    cell.denomimationLabel.text = [NSString stringWithFormat:@"%@ %@" ,Currency, self.denominations[indexPath.row]];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.amount = self.denominations[indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[NSString stringWithFormat:@"Pay %@%@ to %@",Currency,self.amount,Merchant]
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        //User agree
        
        NSLog(@"Agree");
        [self initializePaypal];
        [self initializeItem];
    }
    else
    {
        NSLog(@"Disagree");
    }
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



/*
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                willCompletePayment:(PayPalPayment *)completedPayment
                    completionBlock:(PayPalPaymentDelegateCompletionBlock)completionBlock
{
    
}
*/

#pragma mark - Private Method

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
                                      withPrice:[NSDecimalNumber decimalNumberWithString:self.amount]
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


@end
