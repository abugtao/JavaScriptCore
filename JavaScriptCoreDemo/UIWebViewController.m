//
//  UIWebViewController.m
//  JavaScriptCoreDemo
//
//  Created by zht on 2018/3/28.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "UIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSTestObject.h"
@interface UIWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) JSContext *context;


@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"webview.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",[request.URL absoluteString]);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"start");
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finish");
    //oc调用js
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *value = [self.context evaluateScript:@"document.title"];
    self.title = value.toString;
    
    
    
    //js 调用 oc     通过block 将方法暴露给js   
    self.context[@"share"] = ^(){
        NSArray *args = [JSContext currentArguments];
        
        NSMutableArray *messages = [NSMutableArray array];
        for (JSValue *obj in args) {
            [messages addObject:[obj toObject]];
        }
        
        NSLog(@"%@",messages);
    };
    
    
    
    
    
    //创建JSTestObject对象，赋值给js对象 实现js调取oc
    JSTestObject *test = [JSTestObject new];
    self.context[@"testobject"] = test;
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.context evaluateScript:@"alertMobile('张海涛')"];
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
