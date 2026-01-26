//
//  LoginManager.h
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^LoginCompletion)(NSString * _Nullable token,
                                NSError * _Nullable error);

@protocol LoginManaging <NSObject>


- (void)loginWithCompletion:(LoginCompletion)completion;
- (void)silentLoginWithCompletion:(LoginCompletion)completion;
- (void)logout;

@end

@interface LoginManager : NSObject <LoginManaging>
@end

NS_ASSUME_NONNULL_END
