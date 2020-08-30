//
//  ViewController.m
//  iOS_Example
//
//  Created by chdo on 2019/8/18.
//  Copyright © 2019 chdo. All rights reserved.
//

#import "ViewController.h"
#import <CDCroissant/Croissant.h>
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int flag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)request2 {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:@"http://127.0.0.1:8888/"
                                                                                parameters:@{@"name":@"hehe"}
                                                                                     error:nil];
    
    [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"收到：%@ -- %@",response.URL.absoluteURL,str);
    }] resume];
    
}
- (void)request {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@",dict);
        }
    }];
    [dataTask resume];
}

- (IBAction)shareAction:(id)sender {
    [Croissant.shareInstance shareServeURL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",event.description);
    [self request2];
    //
    //    SViewController *vc = SViewController.alloc.init;
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end
