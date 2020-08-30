//
//  CRServerResource.m
//  CocoaAsyncSocket
//
//  Created by 陈栋 on 2019/10/7.
//

#import "CRServerResource.h"

@import CoreServices;

@interface CRServerResource()
{
    NSString * _templeteHtml;
}
@end

@implementation CRServerResource

- (NSString *)bundlePath
{
    NSString * bundlePath = [[NSBundle bundleForClass:self.class].resourcePath
                             stringByAppendingPathComponent:@"Croissant.bundle"];
    bundlePath = [bundlePath stringByAppendingPathComponent:@"Croissant.bundle"];
    return bundlePath;
}

- (NSString *)templeteHtmlPath
{
    NSString *path = [self.bundlePath stringByAppendingPathComponent:@"index.html"];
    
    return path;
}

- (NSString *)templeteHtml
{
    if (!_templeteHtml) {
        
        NSMutableString *template = [[NSMutableString alloc] initWithContentsOfFile:self.templeteHtmlPath
                                                                           encoding:NSUTF8StringEncoding error:nil];
        _templeteHtml = template.copy;
    }
    return _templeteHtml;
}

- (NSString *)getMIMETypeWithCAPIAtFilePath:(NSString *)path
{
    
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                            (__bridge CFStringRef)[path pathExtension],
                                                            NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    NSString *result=(__bridge NSString *)(MIMEType);
    CFRelease(MIMEType);
    return result;
}

@end
