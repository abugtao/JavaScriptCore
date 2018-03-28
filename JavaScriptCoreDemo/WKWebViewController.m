//
//  WKWebViewController.m
//  JavaScriptCoreDemo
//
//  Created by zht on 2018/3/28.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "JSTestObject.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *wkwebview;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 30;
    
    //内容交互控制器
    WKUserContentController *usercontentController = [[WKUserContentController alloc] init];
    [usercontentController addScriptMessageHandler:self name:@"showName"]; //注册一个name为showName的js方法   可以实现js调用oc
    config.userContentController = usercontentController;
    
    self.wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) configuration:config];
    [self.view addSubview:self.wkwebview];
    self.wkwebview.UIDelegate = self;
    self.wkwebview.navigationDelegate = self;
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"webview.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.wkwebview loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    //oc 调用 js  该方法很好的解决了之前文章中提到的UIWebView使用stringByEvaluatingJavaScriptFromString:方法的两个缺点（1. 返回值只能是NSString。2. 报错无法捕获
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.title = title;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    completionHandler();
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%@",message.body);
    NSLog(@"%@",message.name);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //oc调用js
    [self.wkwebview evaluateJavaScript:@"alertMobile('张海涛')" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        //TODO
        NSLog(@"%@ %@",response,error);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
