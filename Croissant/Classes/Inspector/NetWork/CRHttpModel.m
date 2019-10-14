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
    
}

@end
