//
//  Function.h
//  Dream4u
//
//  Created by Lam Si Mon on 12/6/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Function : NSObject
+ (instancetype)instance;

- (void)prepareData;

@property ( nonatomic , strong ) NSArray *data;
@end
