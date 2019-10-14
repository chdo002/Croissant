//
//  CRInspector.h
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import <Foundation/Foundation.h>
#import "CRHttpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRInspector : NSObject

@property (class, nonatomic, strong) CRInspector *shareInstance;

@property (nonatomic, copy) void(^logCallBack)(NSString *log);

@property (nonatomic, copy) void(^networkCallBack)(CRHttpModel *model);

- (void)hookNSLog;
- (void)hookNetWork;

@end

NS_ASSUME_NONNULL_END
