//
//  CRAuthenticationChallengeSender.m
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import "CRAuthenticationChallengeSender.h"

@implementation CRAuthenticationChallengeSender

+(instancetype)sender:(id)completionHandler
{
    CRAuthenticationChallengeSender *sender = CRAuthenticationChallengeSender.new;
    sender.completionHandler = completionHandler;
    return sender;
}

- (void)cancelAuthenticationChallenge:(nonnull NSURLAuthenticationChallenge *)challenge {
    if (self.completionHandler) {
        self.completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

- (void)continueWithoutCredentialForAuthenticationChallenge:(nonnull NSURLAuthenticationChallenge *)challenge {
    if (self.completionHandler) {
        self.completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
    }
}

- (void)useCredential:(nonnull NSURLCredential *)credential forAuthenticationChallenge:(nonnull NSURLAuthenticationChallenge *)challenge {
    if (self.completionHandler) {
        self.completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

- (void)performDefaultHandlingForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if (self.completionHandler) {
        self.completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (void)rejectProtectionSpaceAndContinueWithChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if (self.completionHandler) {
        self.completionHandler(NSURLSessionAuthChallengeRejectProtectionSpace, nil);
    }
}

@end
