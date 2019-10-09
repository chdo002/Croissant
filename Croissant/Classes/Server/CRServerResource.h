//
//  CRServerResource.h
//  CocoaAsyncSocket
//
//  Created by 陈栋 on 2019/10/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRServerResource : NSObject

- (NSString *)bundlePath;
- (NSString *)templeteHtml;
- (NSString *)templeteHtmlPath;

- (NSString *)getMIMETypeWithCAPIAtFilePath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
