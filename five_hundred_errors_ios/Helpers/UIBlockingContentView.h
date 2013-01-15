//
//  UIBlockingContentView.h
//  five_hundred_errors_ios
//
//  Created by Kevin Disneur on 15/01/13.
//  Copyright (c) 2013 Fanatic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    BOOL success;
    __unsafe_unretained NSString *message;
} UIBlockingContentViewResultMessage;

typedef void (^UIBlockingContentViewResultHandler)(UIBlockingContentViewResultMessage);
typedef UIBlockingContentViewResultMessage (^UIBlockingContentViewBlockingAction)(void);

@interface UIBlockingContentView : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *message;

@property(nonatomic, strong) UIBlockingContentViewResultHandler successAction;
@property(nonatomic, strong) UIBlockingContentViewResultHandler errorAction;
@property(nonatomic, strong) UIBlockingContentViewBlockingAction blockingAction;

- (id)initWithTitle:(NSString *)title
             message:(NSString *)message
              action:(UIBlockingContentViewBlockingAction)blockingAction
           onSuccess:(UIBlockingContentViewResultHandler)successAction
             onError:(UIBlockingContentViewResultHandler)errorAction;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
             action:(UIBlockingContentViewBlockingAction)blockingAction
            onError:(UIBlockingContentViewResultHandler)errorAction;

- (UIBlockingContentViewResultMessage)run;

@end
