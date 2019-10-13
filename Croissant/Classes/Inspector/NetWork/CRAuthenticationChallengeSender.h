//
//  CRAuthenticationChallengeSender.h
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRAuthenticationChallengeSender : NSObject

@property (nonatomic, copy) void (^completionHandler)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable);

+(instancetype)sender:(id)completionHandler;

@end

NS_ASSUME_NONNULL_END
