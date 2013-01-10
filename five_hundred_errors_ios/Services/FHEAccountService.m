//
//  FHEAccountService.m
//  five_hundred_errors_ios
//
//  Created by Kevin Disneur on 09/01/13.
//  Copyright (c) 2013 Fanatic. All rights reserved.
//

#import "FHEAccountService.h"
#import "ConnectionManager.h"

@interface FHEAccountService ()
{
    FHEAccount *currentAccount;
}
@end

@implementation FHEAccountService

static FHEAccountService *sharedService;

+ (FHEAccountService *)sharedService
{
    if (sharedService == nil) {
        sharedService = [[FHEAccountService alloc] init];
    }
    
    return sharedService;
}

- (FHEAccount *)currentAccount
{
    NSManagedObjectContext *managedObjectContext = [[ConnectionManager sharedConnection] managedObjectContext];
    
    if (currentAccount == nil) {
        NSEntityDescription *entityDescription = [NSEntityDescription
                                                  entityForName:@"FHEAccount"
                                                  inManagedObjectContext:managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        NSError *error;
        NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
        if (array != nil && [array count] > 0)
        {
            currentAccount = array[0];
        }
    }
    
    return currentAccount;
}

- (void)createAccountWithEmail:(NSString *)email andToken:(NSString *)token
{
    NSManagedObjectContext *managedObjectContext = [[ConnectionManager sharedConnection] managedObjectContext];
    FHEAccount *account = [self currentAccount];
    
    // TODO: check authentication with email and token
    
    if (account == nil) {
        NSEntityDescription *accountEntity = [NSEntityDescription
                                                       entityForName:@"FHEAccount"
                                              inManagedObjectContext:managedObjectContext];
        
        account = (FHEAccount *)[[NSManagedObject alloc]
                                                 initWithEntity:accountEntity
                                 insertIntoManagedObjectContext:managedObjectContext];
        
        
        [managedObjectContext insertObject:account];
    }
    
    account.email = email;
    account.token = token;
    
    NSError *error = nil;
    [managedObjectContext save:&error];
}

@end
