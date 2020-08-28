//
//  CRHttpModel.h
//  Croissant
//
//  Created by chdo on 2019/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRHttpModel : NSObject

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) NSHTTPURLResponse *response;

@property (nonatomic, strong, nullable) NSMutableData *responseData;

@property (nonatomic, strong, nullable) NSError *error;

@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, strong) NSDate *endDate;

- (NSDictionary *)descriptionDic;

@end

NS_ASSUME_NONNULL_END
