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

-(NSData * _Nullable)getDataFromStream:(NSInputStream *)stream
{
    if (!stream) {
        return nil;
    }
    NSInteger maxLength = 1024;
    uint8_t d[maxLength];
    NSMutableData *data = [[NSMutableData alloc] init];
    [stream open];
    BOOL endOfStreamReached = NO;
    //不能用 [stream hasBytesAvailable]) 判断，处理图片文件的时候这里的[stream hasBytesAvailable]会始终返回YES，导致在while里面死循环。
    while (!endOfStreamReached) {
        NSInteger bytesRead = [stream read:d maxLength:maxLength];
        if (bytesRead == 0) { //文件读取到最后
            endOfStreamReached = YES;
        } else if (bytesRead == -1) { //文件读取错误
            endOfStreamReached = YES;
        } else if (stream.streamError == nil) {
            [data appendBytes:(void *)d length:bytesRead];
        }
    }
    [stream close];
    return [data copy];
}

- (NSDictionary *)descriptionDic
{
    NSString *url = self.request.URL.absoluteString;
    
    NSMutableDictionary *descDic = [NSMutableDictionary dictionary];
    
    // request
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                      @"url":url,
                                                                                      @"HeaderFields":self.request.allHTTPHeaderFields,
                                                                                      @"HTTPMethod":self.request.HTTPMethod,
                                                                                      @"uuid":self.uuid,
                                                                                      @"timeStamp":@([self.startDate timeIntervalSince1970])
                                                                                      }];
    
    NSData *body = [self getDataFromStream:self.request.HTTPBodyStream];
    if (body) {
        NSString *bodyStr = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
        if (bodyStr) {
            requestDic[@"httpBody"] = bodyStr;
        } else {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:body options:kNilOptions error:nil];
            requestDic[@"httpBody"] = dict;
        }
    }
    [descDic addEntriesFromDictionary:@{@"request":requestDic}];
    
    // reponse
    if (self.response) {
        NSMutableDictionary *responseDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                           @"statusCode":@(self.response.statusCode) ?: @"",
                                                                                           @"HeaderFields":self.response.allHeaderFields ?: @"",
                                                                                           @"MIMEType":self.response.MIMEType ?: @"",
                                                                                           @"timeStamp":@([self.endDate timeIntervalSince1970])
                                                                                           }];
        if (self.responseData) {
            NSString *contentStr = [[NSString alloc] initWithData:self.responseData.copy encoding:NSUTF8StringEncoding];
            responseDic[@"httpBody"] = contentStr;
        }
        [descDic addEntriesFromDictionary:@{@"response":responseDic}];
    }
  
    // error
    if (self.error){
        [descDic addEntriesFromDictionary:@{
                                            @"error":self.error.description
                                            }];
    }
    return descDic.copy;
}

@end
