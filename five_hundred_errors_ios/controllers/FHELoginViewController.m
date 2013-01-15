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
        [self performSegueManuallyWithIdentifier:@"fromConnectionToList"];
    }
    return YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return [self processBlockingContentWithTitle:@"Connection"
                                  message:@"Try to sign in to the server"
                                   action:^{
                                       return [[FHEAccountService sharedService] createAccountWithEmail:self.email.text
                                                         andToken:self.token.text];
                                   }
                                onSuccess:^{}
                                  onError:^{
                                      [[[UIAlertView alloc] initWithTitle:@"Connection error"
                                                                  message:@"Invalid email or token. Check your informations again"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"Retry", nil] show];
                                  }
     
     ];
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

- (BOOL)processBlockingContentWithTitle:(NSString *)title message:(NSString *)message action:(BOOL (^)(void))blockingAction onSuccess:(void (^)(void))successAction onError:(void (^)(void))errorAction
{
    UIAlertView *processLoginView = [[UIAlertView alloc] initWithTitle:title
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:nil];
    
    UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loader startAnimating];
    [loader setFrame:CGRectMake(125, 70, 37, 37)];
    [processLoginView addSubview:loader];
    
    [processLoginView show];
    
    BOOL blocking_action_return = blockingAction();
    
    [processLoginView dismissWithClickedButtonIndex:0 animated:YES];
    
    blocking_action_return ? successAction() : errorAction();
    
    return blocking_action_return;
}

-(void) performSegueManuallyWithIdentifier:(NSString *)identifier
{
    if ([self shouldPerformSegueWithIdentifier:identifier sender:self]) {
        [self performSegueWithIdentifier:identifier sender:self];
    }
}


@end
