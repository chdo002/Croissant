//
//  CRHttpModel.m
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import "CRHttpModel.h"

@implementation CRHttpModel

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
    NSString *contentStr = [[NSString alloc] initWithData:self.responseData.copy encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *descDic = [NSMutableDictionary dictionaryWithDictionary:@{
        @"request":@{
                @"url":url,
                @"HeaderFields":self.request.allHTTPHeaderFields,
                @"HTTPMethod":self.request.HTTPMethod
        },
        @"data":contentStr ?: @""
    }];
    if (self.response) {
        [descDic addEntriesFromDictionary:@{
            @"response":@{
                    @"statusCode":@(self.response.statusCode) ?: @"",
                    @"HeaderFields":self.response.allHeaderFields ?: @"",
                    @"MIMEType":self.response.MIMEType ?: @"",
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
