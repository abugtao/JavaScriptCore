//
//  ViewController.m
//  JavaScriptCoreDemo
//
//  Created by zht on 2018/3/28.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)webViewAction:(id)sender {
    UIWebViewController *webVC = [[UIWebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}

- (IBAction)wkwebAction:(id)sender {
    WKWebViewController *wkwebVC = [[WKWebViewController alloc] init];
    [self.navigationController pushViewController:wkwebVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
