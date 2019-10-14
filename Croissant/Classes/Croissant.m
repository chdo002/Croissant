//
//  Croissant.m
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import "Croissant.h"

#import "CRInspector.h"
#import "CRServer.h"
#import "CRLogger.h"

@interface Croissant()

@end

@implementation Croissant

static Croissant *share;
+ (Croissant *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = Croissant.new;
    });
    return share;
}

+ (void)setShareInstance:(Croissant *)shareInstance
{
    share = shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _enabled = NO;
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    if (enabled) {
        
        [CRServer.shareInstance startWebServer];
        [CRServer.shareInstance startSocket];
        
        [self setUpInspect];
        
    } else {
        
        
    }
}

- (void)setUpInspect
{
    [CRInspector.shareInstance hookNSLog];
    
    [CRInspector.shareInstance hookNetWork];
    
    // 日志
    CRInspector.shareInstance.logCallBack = ^(NSString * _Nonnull log) {
        NSDictionary *logDic = @{
            @"type":@1,
            @"content":log ?: @""
        };
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:logDic options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *message = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [CRServer.shareInstance sendMessage:message];
    };
    
    // 请求
    CRInspector.shareInstance.networkCallBack = ^(CRHttpModel * _Nonnull model) {
        
        
        NSData *data = model.responseData.copy;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
//        CRLog(@"%@",dic);
    };
}

- (void)shareServeURL
{
    UIActivityViewController *act = [[UIActivityViewController alloc] initWithActivityItems:@[CRServer.shareInstance.serveUrl] applicationActivities:nil];
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:act animated:YES completion:nil];
}

@end
