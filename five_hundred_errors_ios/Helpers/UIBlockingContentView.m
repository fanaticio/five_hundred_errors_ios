//
//  UIBlockingContentView.m
//  five_hundred_errors_ios
//
//  Created by Kevin Disneur on 15/01/13.
//  Copyright (c) 2013 Fanatic. All rights reserved.
//

#import "UIBlockingContentView.h"
#import <UIKit/UIKit.h>

@implementation UIBlockingContentView

- (id)initWithTitle:(NSString *)title
             message:(NSString *)message
              action:(UIBlockingContentViewBlockingAction)blockingAction
           onSuccess:(UIBlockingContentViewResultHandler)successAction
             onError:(UIBlockingContentViewResultHandler)errorAction
{
    self = [super init];
    if (self) {
        self.title          = title;
        self.message        = message;
        self.blockingAction = blockingAction;
        self.successAction  = successAction;
        self.errorAction    = errorAction;
        
        if (self.successAction == nil) {
            self.successAction = ^(UIBlockingContentViewResultMessage resultMessage) {};
        }
        
        if (self.errorAction == nil) {
            self.errorAction = ^(UIBlockingContentViewResultMessage resultMessage) {};
        }
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
             action:(UIBlockingContentViewBlockingAction)blockingAction
            onError:(UIBlockingContentViewResultHandler)errorAction
{
    return [self initWithTitle:title message:message
                        action:blockingAction
                     onSuccess:nil
                       onError:errorAction];
}

- (UIBlockingContentViewResultMessage)run
{
    UIAlertView *processLoginView = [[UIAlertView alloc] initWithTitle:self.title
                                                               message:self.message
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:nil];
    
    UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loader startAnimating];
    [loader setFrame:CGRectMake(125, 70, 37, 37)];
    [processLoginView addSubview:loader];
    
    [processLoginView show];
    
    UIBlockingContentViewResultMessage resultMessage = self.blockingAction();
    
    [processLoginView dismissWithClickedButtonIndex:0 animated:YES];
    
    resultMessage.success ? self.successAction(resultMessage) : self.errorAction(resultMessage);
    
    return resultMessage;
}

@end
