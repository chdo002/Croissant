//
//  CRInspector.m
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import "CRInspector.h"
#import "CRURLProtocol.h"
#import "CRLogger.h"

@implementation CRInspector

+ (CRInspector *)shareInstance
{
    static dispatch_once_t onceToken;
    static CRInspector *share;
    dispatch_once(&onceToken, ^{
        share = CRInspector.new;
    });
    
    return share;
}

+ (void)setShareInstance:(CRInspector *)shareInstance{}

- (void)hookNSLog
{
    [CRLogger hookNSLog];
}

- (void)hookNetWork
{
    [NSURLProtocol registerClass:CRURLProtocol.class];
}

@end
