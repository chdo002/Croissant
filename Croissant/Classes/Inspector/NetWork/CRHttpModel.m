//
//  CRHttpModel.m
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import "CRHttpModel.h"

@implementation CRHttpModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.uuid = NSUUID.UUID.UUIDString;
    }
    return self;
}
- (NSMutableData *)responseData
{
    if (!_responseData) {
        _responseData = NSMutableData.data;
    }
    return _responseData;
}

- (NSDictionary *)descriptionDic
{
    NSString *url = self.request.URL.absoluteString;

    id responseObject = [NSJSONSerialization JSONObjectWithData:self.request.HTTPBody options:0 error:nil];
    
    NSMutableDictionary *descDic = [NSMutableDictionary dictionaryWithDictionary:@{
        @"request":@{
                @"url":url,
                @"httpBody":responseObject ?: @"",
                @"HeaderFields":self.request.allHTTPHeaderFields,
                @"HTTPMethod":self.request.HTTPMethod,
                @"uuid":self.uuid,
                @"timeStamp":@([self.startDate timeIntervalSince1970])
        }
    }];
    if (self.responseData) {
        NSString *contentStr = [[NSString alloc] initWithData:self.responseData.copy encoding:NSUTF8StringEncoding];
        [descDic addEntriesFromDictionary:@{
            @"reponseData":contentStr ?: @""
        }];
    }
    if (self.response) {
        [descDic addEntriesFromDictionary:@{
            @"response":@{
                    @"statusCode":@(self.response.statusCode) ?: @"",
                    @"HeaderFields":self.response.allHeaderFields ?: @"",
                    @"MIMEType":self.response.MIMEType ?: @"",
                    @"timeStamp":@([self.endDate timeIntervalSince1970])
            }
        }];
    } else if (self.error){
        [descDic addEntriesFromDictionary:@{
            @"error":self.error.description
        }];
    }
    return descDic.copy;
}

@end
