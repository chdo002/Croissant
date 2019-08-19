//
//  Croissant.m
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import "Croissant.h"

#import "CRInspector.h"
#import "CRServer.h"


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
    }
}


- (void)setUpInspect
{
    CRInspector.shareInstance.logCallBack = ^(NSString * _Nonnull log) {
        [CRServer.shareInstance sendMessage:log];
    };
}

- (void)shareServeURL
{
    UIActivityViewController *act = [[UIActivityViewController alloc] initWithActivityItems:@[CRServer.shareInstance.serveUrl] applicationActivities:nil];
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:act animated:YES completion:nil];
}

@end
