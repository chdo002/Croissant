//
//  CRInspector.m
//  Croissant
//
//  Created by chdo on 2019/8/18.
//

#import "CRInspector.h"

#import "fishhook.h"

@implementation CRInspector

+ (void)initialize
{
    if (self == [CRInspector class]) {
        
        struct rebinding nslog_rebinding = {"NSLog",cr_nslog,(void*)&orig_nslog};
        rebind_symbols((struct rebinding[1]){nslog_rebinding}, 1);
    }
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

- (CRInspector *)shareInstance
{
    static dispatch_once_t onceToken;
    static CRInspector *share;
    dispatch_once(&onceToken, ^{
        share = CRInspector.new;
    });
    
    return share;
}

+ (void)setShareInstance:(CRInspector *)shareInstance{}


@end
