//
//  FHEAccountService.m
//  five_hundred_errors_ios
//
//  Created by Kevin Disneur on 09/01/13.
//  Copyright (c) 2013 Fanatic. All rights reserved.
//

#import "FHEAccountService.h"
#import "ConnectionManager.h"

@implementation FHEAccountService

static FHEAccountService *sharedService;

+ (FHEAccountService *)sharedService
{
    if (sharedService == nil) {
        sharedService = [[FHEAccountService alloc] init];
    }
    
    return sharedService;
}

- (id)currentAccount
{
    NSManagedObjectContext *managedObjectContext = [[ConnectionManager sharedConnection] managedObjectContext];
    
    if (current_account == nil) {
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"FHEAccount" inManagedObjectContext:managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        NSError *error;
        NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
        if (array != nil && (int)[array count] > 0)
        {
            current_account = array[0];
        }
    }
    
    return current_account;
}

- (void)createAccountWithEmail:(NSString *)email andToken:(NSString *)token
{
    
}

@end
