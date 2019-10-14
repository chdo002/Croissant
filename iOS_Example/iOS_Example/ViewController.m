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
    
    
    if (@available(iOS 10.0, *)) {
        void(^timer)(NSTimer *timer) = ^(NSTimer *timer) { [self request]; };
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:timer];
        
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)request {
    
    NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
    
    session = NSURLSession.sharedSession;
    
    self.flag += 1;
    
    NSString *path = [NSString stringWithFormat:@"http://127.0.0.1:8888?parpa=%d", self.flag];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:path]
                                        completionHandler:^(NSData *  data,
                                                            NSURLResponse * response,
                                                            NSError *  error)
                                  {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"收到：%@ -- %@",response.URL.absoluteURL,str);
    }];
    NSLog(@"发送：%@",path);
    
    [task resume];
}

- (IBAction)shareAction:(id)sender {
    
    [Croissant.shareInstance shareServeURL];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",event.description);
    SViewController *vc = SViewController.alloc.init;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
