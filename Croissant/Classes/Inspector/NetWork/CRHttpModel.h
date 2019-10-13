//
//  CRHttpModel.h
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRHttpModel : NSObject

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) NSURLResponse *response;

@property (nonatomic, strong) NSMutableData *responseData;

@end

NS_ASSUME_NONNULL_END
