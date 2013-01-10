//
//  FHELoginViewController.m
//  five_hundred_errors_ios
//
//  Created by Kevin Disneur on 09/01/13.
//  Copyright (c) 2013 Fanatic. All rights reserved.
//

#import "FHELoginViewController.h"
#import "FHEAccountService.h"
#import "FHEListViewController.h"

@interface FHELoginViewController ()

@end

@implementation FHELoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[FHEAccountService sharedService] currentAccount] != nil) {
        [self performSegueWithIdentifier:@"fromConnectionToList"
                                  sender:self];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textfield
{
    if(textfield == self.email) {
        [self.token becomeFirstResponder];
    }else {
        // try to do transition to List View
        // * code below doesn't work because it doesn't call shouldPerform...
        //   [self performSegueWithIdentifier:@"fromConnectionToList" sender:self];
        // * another idea could be manually trigger click on save button
        //   [saveButton .....] // But I don't know what method I can call
    }
    return YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    [[FHEAccountService sharedService] createAccountWithEmail:self.email.text
                                                     andToken:self.token.text];
    
    return [[FHEAccountService sharedService] currentAccount] != nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FHEListViewController *destination =  segue.destinationViewController;
    destination.account = [[FHEAccountService sharedService] currentAccount];
}


@end
