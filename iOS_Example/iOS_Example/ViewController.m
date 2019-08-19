//
//  ViewController.m
//  iOS_Example
//
//  Created by chdo on 2019/8/18.
//  Copyright © 2019 chdo. All rights reserved.
//

#import "ViewController.h"
#import <Croissant/Croissant.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [[NSURLSession.sharedSession dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data,
                                                                             NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }] resume];
}

- (IBAction)shareAction:(id)sender {
    
    [Croissant.shareInstance shareServeURL];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",event.description);
}



@end
