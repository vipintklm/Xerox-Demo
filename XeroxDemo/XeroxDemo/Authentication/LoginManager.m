//
//  LoginManager.m
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

#import "LoginManager.h"

@implementation LoginManager

- (void)loginWithCompletion:(LoginCompletion)completion {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        completion(@"mock_oauth_token_12345", nil);
    });
}

- (void)silentLoginWithCompletion:(LoginCompletion)completion {

    NSString *token =
    [[NSUserDefaults standardUserDefaults] stringForKey:@"authToken"];

    if (token.length > 0) {
        completion(token, nil);
    } else {
        NSError *error = [NSError errorWithDomain:@"Auth"
                                             code:401
                                         userInfo:@{
                                             NSLocalizedDescriptionKey:
                                             @"No cached token found"
                                         }];
        completion(nil, error);
    }
}


- (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authToken"];
}

@end
