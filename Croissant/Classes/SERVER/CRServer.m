//
//  CRWebServer.m
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import "CRServer.h"

#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import "PSWebSocketServer.h"

@interface CRServer()<PSWebSocketServerDelegate>

@property (nonatomic, strong) GCDWebServer *webServer;

@property (nonatomic, strong) PSWebSocketServer *socketServer;
@property (nonatomic, strong) PSWebSocket *webSocket;

@property (nonatomic, copy) NSString *templeteHtml;

@end

@implementation CRServer

+ (CRServer *)shareInstance
{
    static dispatch_once_t onceToken;
    static CRServer *share;
    dispatch_once(&onceToken, ^{
        share = CRServer.new;
    });
    return share;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.webServer = GCDWebServer.new;
        [self setUpServer];
        [self setUpSocket];
    }
    return self;
}
+ (void)setShareInstance:(CRServer *)shareInstance{}


- (void)setUpServer
{
    __weak typeof(self) weakS = self;
    [self.webServer addDefaultHandlerForMethod:@"GET"
                                  requestClass:GCDWebServerRequest.class
                                  processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request)
    {
        NSString *html = [weakS.templeteHtml stringByReplacingOccurrencesOfString:@"replace_address"
                                                                       withString:[NSString stringWithFormat:@"ws://%@:8080",weakS.webServer.serverURL.host]];
        GCDWebServerResponse *resp = [GCDWebServerDataResponse responseWithHTML:html];
        return resp;
    }];
    
}

- (void)startWebServer
{
    if (!self.webServer.running) {
        [self.webServer startWithPort:9071 bonjourName:nil];
    }
}


- (void)setUpSocket
{
    self.socketServer = [PSWebSocketServer serverWithHost:nil port:8080];
    self.socketServer.delegate = self;
}

- (void)startSocket
{
    [self.socketServer start];
}

- (void)sendMessage:(NSString *)message
{
    [self.webSocket send:message];
}

#pragma mark - GETTER

- (NSString *)templeteHtml
{
    if (!_templeteHtml) {
        NSString * bundlePath = [[NSBundle bundleForClass:self.class].resourcePath stringByAppendingPathComponent:@"Croissant.bundle"];
        bundlePath = [bundlePath stringByAppendingPathComponent:@"Croissant.bundle"];
        NSString *path = [bundlePath stringByAppendingPathComponent:@"index.html"];
        NSMutableString *template = [[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        _templeteHtml = template.copy;
    }
    return _templeteHtml;
}

- (NSURL *)serveUrl
{
    return self.webServer.serverURL ?: @"";
}

#pragma mark - PSWebSocketServerDelegate

- (void)serverDidStart:(PSWebSocketServer *)server
{
    
}

- (void)server:(PSWebSocketServer *)server didFailWithError:(NSError *)error
{
    
}

- (void)serverDidStop:(PSWebSocketServer *)server
{
    
}

- (void)server:(PSWebSocketServer *)server webSocketDidOpen:(PSWebSocket *)webSocket
{
    self.webSocket = webSocket;
}

- (void)server:(PSWebSocketServer *)server webSocket:(PSWebSocket *)webSocket didReceiveMessage:(id)message
{
    
}

- (void)server:(PSWebSocketServer *)server webSocket:(PSWebSocket *)webSocket didFailWithError:(NSError *)error
{
    
}

- (void)server:(PSWebSocketServer *)server webSocket:(PSWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    
}

- (void)server:(PSWebSocketServer *)server webSocketDidFlushInput:(PSWebSocket *)webSocket
{
    
}

- (void)server:(PSWebSocketServer *)server webSocketDidFlushOutput:(PSWebSocket *)webSocket
{
    
}

- (BOOL)server:(PSWebSocketServer *)server acceptWebSocketWithRequest:(NSURLRequest *)request
{
    return YES;
}

- (BOOL)server:(PSWebSocketServer *)server acceptWebSocketWithRequest:(NSURLRequest *)request address:(NSData *)address trust:(SecTrustRef)trust response:(NSHTTPURLResponse **)response
{
    return YES;
}




@end
