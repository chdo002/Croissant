//
//  ViewController.m
//  iOS_Example
//
//  Created by chdo on 2019/8/18.
//  Copyright © 2019 chdo. All rights reserved.
//

#import "ViewController.h"
#import <Croissant/Croissant.h>
#import <AFNetworking/AFNetworking.h>
#import "iOS_Example-Swift.h"
//#import "Host-Swift.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int flag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//
//    if (@available(iOS 10.0, *)) {
//        void(^timer)(NSTimer *timer) = ^(NSTimer *timer) { [self request];
//
//        };
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:timer];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.timer invalidate];
//        });
//    } else {
//        // Fallback on earlier versions
//    }
//
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
        
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888"];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
                data：响应体信息（期望的数据）
                response：响应头信息，主要是对服务器端的描述
                error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    }];
    
    //7.执行任务
    [dataTask resume];
    
//    NSString *path = [NSString stringWithFormat:@"http://127.0.0.1:8888?parpa=%d", self.flag];
//    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:path]
//                                        completionHandler:^(NSData *  data,
//                                                            NSURLResponse * response,
//                                                            NSError *  error)
//                                  {
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"收到：%@ -- %@",response.URL.absoluteURL,str);
//    }];
//    NSLog(@"发送：%@",path);
    
//    [task resume];
}

- (IBAction)shareAction:(id)sender {
    [Croissant.shareInstance shareServeURL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",event.description);
    [self request];
//
//    SViewController *vc = SViewController.alloc.init;
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
