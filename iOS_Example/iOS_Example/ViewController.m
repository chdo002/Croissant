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

@interface ViewController ()

@end

@implementation ViewController

- (void)request {
    NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
    
    session = NSURLSession.sharedSession;
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://127.0.0.1:8888?parpa=1"]
                                        completionHandler:^(NSData * _Nullable data,
                                                            NSURLResponse * _Nullable response,
                                                            NSError * _Nullable error)
    {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",str);
    }];
    
    [task resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self request];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [self request];
//    });
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
