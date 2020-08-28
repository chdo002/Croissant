//
//  CRLogger.m
//  Croissant
//
//  Created by chdo on 2019/10/14.
//

#import "CRLogger.h"
#import "fishhook.h"
#import "CRInspector.h"

@implementation CRLogger

void CRLog(NSString *format, ...)
{
    va_list vl;
    va_start(vl, format);
    NSString* str = [[NSString alloc] initWithFormat:format arguments:vl];
    va_end(vl);
    orig_nslog(str);
}

+ (void)hookNSLog
{
    struct rebinding nslog_rebinding = {"NSLog",cr_nslog,(void*)&orig_nslog};
    rebind_symbols((struct rebinding[1]){nslog_rebinding}, 1);
}

static void (*orig_nslog)(NSString *format, ...);

void cr_nslog(NSString *format, ...) {
    
    va_list vl;
    va_start(vl, format);
    NSString* str = [[NSString alloc] initWithFormat:format arguments:vl];
    va_end(vl);
    
    orig_nslog(str);
    
    if (CRInspector.shareInstance.logCallBack) {
        CRInspector.shareInstance.logCallBack(str);
    }
}

@end
