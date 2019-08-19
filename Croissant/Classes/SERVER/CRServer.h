//
//  CRWebServer.h
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRServer : NSObject

@property (class, nonatomic, strong) CRServer *shareInstance;

@property (nonatomic, strong, readonly) NSURL *serveUrl;

- (void)startWebServer;

- (void)startSocket;

- (void)sendMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
