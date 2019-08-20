//
//  CRInspector.h
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRInspector : NSObject

@property (class, nonatomic, strong) CRInspector *shareInstance;

@property (nonatomic, copy) void(^logCallBack)(NSString *log);

- (void)hookNSLog;

@end

NS_ASSUME_NONNULL_END
