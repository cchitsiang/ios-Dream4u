//
//  Function.m
//  Dream4u
//
//  Created by Lam Si Mon on 12/6/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import "Function.h"
#import "DataInfo.h"

@implementation Function

+ (instancetype)instance
{
    static Function *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Function alloc] init];
    });
    
    return instance;
}


- (void)prepareData
{
    DataInfo *info1 = [[DataInfo alloc] init];
    info1.name = @"Sara Robinson";
    info1.age = @"70";
    info1.placeOfBirth = @"California";
    info1.courseStudy = @"Designing";
    info1.totalSponsored = @"3713";
    info1.daysLeft = @"11";
    info1.title = @"Being a designing student at 60 years old!";
    info1.introduction = @"I am a second year student at College of Business, currently studying Business Management.But I realised my passion is still with designing. However, my family is tight with financial and I can’t get loan. The only way that I can pursue my passion is by getting financial aid myself.";
    info1.aim = @"I wish to apply a design course with an annual tuition fees of$15,000 at College of Art andCommunication. I will be able to sort out only 50% of the tuition fees, so would hope to get aid for the rest";
    info1.fundsCollected = @"1000";
    info1.totalFundNeeded = @"15000";
    info1.userImage = [UIImage imageNamed:@"face3.png"];

    DataInfo *info2 = [[DataInfo alloc] init];
    info2.name = @"Robinson Crusoe";
    info2.age = @"40";
    info2.placeOfBirth = @"Texas";
    info2.courseStudy = @"Part time jobs all the time.";
    info2.title = @"I need a full time job! AS SOON AS POSSIBLE !!!";
    info2.totalSponsored = @"2000";
    info2.daysLeft = @"30";
    info2.introduction = @"I lost my job during financial crisis. Since then I have been getting job here and there. But there is no consistent stream of income. I realized everyone needs an accountant, I wish to be one but I have no knowledge of it.";
    info2.aim = @"Tuition fee of accounting courses is $12, 000 in Texas, I wish to get aid and start the courses as soon as posible. ";
    info2.fundsCollected = @"7000";
    info2.totalFundNeeded = @"7500";
    info2.userImage = [UIImage imageNamed:@"face2.png"];

    DataInfo *info3 = [[DataInfo alloc] init];
    info3.name = @"Mikee Agustin";
    info3.age = @"22";
    info3.placeOfBirth = @"Philipines";
    info3.courseStudy = @"Waitress";
    info3.totalSponsored = @"20155";
    info3.daysLeft = @"60";
    
    info3.title = @"I wish to earn a better living through programming.";
    
    info3.introduction = @"I am from the Philippines, I have started waitering since I was 14. The earning isjust enough to cover my daily expenses but I want a better life for my family and I. Both my parents do not work anymore so they won't have enough money to sponsor me a course.";
    
    info3.aim = @"I wish to apply a computer science course with an annual tuition fees of $15,000 at College of Technology. I will never be able to because I have no fund for it, so would like to seek help from here";
    
    info3.fundsCollected = @"13000";
    info3.totalFundNeeded = @"20000";
    info3.userImage = [UIImage imageNamed:@"face1.png"];

    self.data = @[info1,info2,info3];
}
@end
