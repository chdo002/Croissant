//
//  CRLog.h
//  AFNetworking
//
//  Created by chdo on 2019/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern void CRLog(NSString *format, ...);

@interface CRLogger : NSObject

+ (void)hookNSLog;

@end

NS_ASSUME_NONNULL_END
