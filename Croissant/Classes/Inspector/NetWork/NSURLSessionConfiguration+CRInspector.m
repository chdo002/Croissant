//
//  NSURLSessionConfiguration+CRInspector.m
//  AFNetworking
//
//  Created by chdo on 2019/10/13.
//

#import "NSURLSessionConfiguration+CRInspector.h"
#import <objc/runtime.h>
#import "CRURLProtocol.h"

@implementation NSURLSessionConfiguration (CRInspector)

+ (void)swizzleDefault
{
    Class aClass = object_getClass(self);
    
    SEL originSel = @selector(defaultSessionConfiguration);
    SEL newSel = @selector(defaultSessionConfiguration_swiz);
    
    Method originM = class_getClassMethod(aClass, originSel);
    Method newM = class_getClassMethod(aClass, newSel);
    
    method_exchangeImplementations(originM, newM);
}

+(NSURLSessionConfiguration *)defaultSessionConfiguration_swiz
{
    NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration_swiz;
    
    NSArray *originArr = conf.protocolClasses;
    
    if ([originArr containsObject:CRURLProtocol.class]) {
        return conf;
    }
    
    NSMutableArray *arr = originArr.mutableCopy;
    
    [arr insertObject:CRURLProtocol.class atIndex:0];
    conf.protocolClasses = arr.copy;
    
    return conf;
}

@end
