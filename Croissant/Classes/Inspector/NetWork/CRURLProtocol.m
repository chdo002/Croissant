//
//  CRURLProtocol.m
//  Croissant
//
//  Created by chdo on 2019/10/13.
//

#import "CRURLProtocol.h"
#import "CRHttpModel.h"
#import "CRAuthenticationChallengeSender.h"
#import "NSURLSessionConfiguration+CRInspector.h"
#import "CRLogger.h"
#import "CRInspector.h"

NSCache *crRequestCache()
{
    static dispatch_once_t onceToken;
    static NSCache *cache;
    dispatch_once(&onceToken, ^{
        cache = NSCache.new;
    });
    return cache;
}

@interface CRURLProtocol()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) CRHttpModel *httpModel;

@end

@implementation CRURLProtocol

+ (void)load
{
    [NSURLSessionConfiguration swizzleDefault];
}

+ (NSString *)crurlInternalKey
{
    return @"com.CRURLProtocol.crurlInternalKey";
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task
{
    return [self canMockRequest:task.currentRequest];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    return [self canMockRequest:request];
}

+ (BOOL)canMockRequest:(NSURLRequest *)request
{
    if (!request) {
        return NO;
    }
    
    id tagged = [NSURLProtocol propertyForKey:self.crurlInternalKey inRequest:request];
    NSURL *url = request.URL;
    BOOL isHttpRequest = [url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"];
    if (!tagged && url && isHttpRequest) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    NSMutableURLRequest *updateRequest = self.request.mutableCopy;
    
    [NSURLProtocol setProperty:@1 forKey:CRURLProtocol.crurlInternalKey inRequest:updateRequest];
    
    self.httpModel.request = updateRequest.copy;
    
    self.httpModel.startDate = NSDate.date;
    
    [[self.session dataTaskWithRequest:self.httpModel.request] resume];
}

- (void)stopLoading
{
    [self.session getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks,
                                                  NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks,
                                                  NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks)
     {
        for (NSURLSessionTask *task in dataTasks) {
            [task cancel];
        }
    }];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.httpModel.responseData appendData:data];
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    if ([response isKindOfClass:NSHTTPURLResponse.class]) {
        self.httpModel.response = response;
    }
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    self.httpModel.error = error;
    self.httpModel.endDate = NSDate.date;
    if (CRInspector.shareInstance.networkCallBack){
        CRInspector.shareInstance.networkCallBack(self.httpModel);
    }
    
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        [self.client URLProtocolDidFinishLoading:self];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler
{
    NSURLRequest *updateRequest = request;
    if (![NSURLProtocol propertyForKey:CRURLProtocol.crurlInternalKey inRequest:request]){
        NSMutableURLRequest *req = request.mutableCopy;
        [NSURLProtocol removePropertyForKey:CRURLProtocol.crurlInternalKey inRequest:req];
        updateRequest = req.copy;
    }
    [self.client URLProtocol:self wasRedirectedToRequest:updateRequest redirectResponse:response];
    completionHandler(updateRequest);
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    CRAuthenticationChallengeSender *sender = [CRAuthenticationChallengeSender sender:completionHandler];
    NSURLAuthenticationChallenge *wrappedChallenge = [NSURLAuthenticationChallenge.alloc initWithAuthenticationChallenge:challenge sender:sender];
    [self.client URLProtocol:self didReceiveAuthenticationChallenge:wrappedChallenge];
}

#pragma mark - GETTER
- (NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration
                                                 delegate:self
                                            delegateQueue:nil];
    }
    return _session;
}

- (CRHttpModel *)httpModel
{
    if (!_httpModel) {
        _httpModel = CRHttpModel.new;
    }
    return _httpModel;
}

@end
