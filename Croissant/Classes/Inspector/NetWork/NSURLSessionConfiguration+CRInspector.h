//
//  NSURLSessionConfiguration+CRInspector.h
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSessionConfiguration (CRInspector)

+ (void)swizzleDefault;

@end

NS_ASSUME_NONNULL_END
