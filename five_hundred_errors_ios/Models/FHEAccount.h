//
//  FHEAccount.h
//  five_hundred_errors_ios
//
//  Created by Kevin Disneur on 09/01/13.
//  Copyright (c) 2013 Fanatic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FHEAccount : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * token;

@end
