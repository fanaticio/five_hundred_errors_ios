//
//  FHEAccountService.h
//  five_hundred_errors_ios
//
//  Created by Kevin Disneur on 09/01/13.
//  Copyright (c) 2013 Fanatic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHEAccount.h"

@interface FHEAccountService : NSObject

+ (FHEAccountService *)sharedService;

- (FHEAccount *)currentAccount;
- (BOOL)createAccountWithEmail:(NSString *)email andToken:(NSString *)token;

@end
