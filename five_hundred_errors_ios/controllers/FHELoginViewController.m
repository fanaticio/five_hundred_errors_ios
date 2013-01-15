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
#import "UIBlockingContentView.h"

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
        [self performSegueManuallyWithIdentifier:@"fromConnectionToList"];
    }
    return YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    UIBlockingContentViewBlockingAction blockingAction = ^{
        UIBlockingContentViewResultMessage resultMessage;
        resultMessage.success = [[FHEAccountService sharedService] createAccountWithEmail:self.email.text
                                                                                 andToken:self.token.text];
        if (!resultMessage.success) {
            resultMessage.message = @"Invalid email or token. Check your informations again";
        }
        
        return resultMessage;
    };
    
    UIBlockingContentViewResultHandler errorAction = ^(UIBlockingContentViewResultMessage result){
        [[[UIAlertView alloc] initWithTitle:@"Connection error"
                                    message:result.message
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Retry", nil] show];
    };
    
    UIBlockingContentView *blockingContentView = [[UIBlockingContentView alloc] initWithTitle:@"Connection"
                                                                                      message:@"Try to sign in to the server"
                                                                                       action:blockingAction
                                                                                      onError:errorAction];
    return [blockingContentView run].success;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FHEListViewController *destination =  segue.destinationViewController;
    destination.account = [[FHEAccountService sharedService] currentAccount];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self performSegueManuallyWithIdentifier:@"fromConnectionToList"];
    }
}

-(void) performSegueManuallyWithIdentifier:(NSString *)identifier
{
    if ([self shouldPerformSegueWithIdentifier:identifier sender:self]) {
        [self performSegueWithIdentifier:identifier sender:self];
    }
}

@end
