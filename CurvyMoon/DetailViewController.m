//
//  DetailViewController.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailViewController.h"
#import "UISpec.h"

#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface DetailViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    //网页进度条
    NJKWebViewProgressView *progressView;
    NJKWebViewProgress *progressProxy;
}
@property (nonatomic , strong) UIWebView * webView;


@end

@implementation DetailViewController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//   
//self.navigationController.navigationBar.hidden = NO;
//    
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [progressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"💕🐟";
    [self leftBackImg];
    self.webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.webView.userInteractionEnabled = NO;
    progressProxy = [[NJKWebViewProgress alloc]init];

    self.webView.delegate = progressProxy;
    progressProxy.webViewProxyDelegate = self;
    progressProxy.progressDelegate = self;
    
    [self.view addSubview:self.webView];
    
    
    
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    
    progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, navigaitonBarBounds.size.height, navigaitonBarBounds.size.width, 3)];
    
    [progressView setProgress:0];
    
    [self.navigationController.navigationBar addSubview:progressView];
    
    [self loadData];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [progressView setProgress:progress animated:YES];
}


- (void)navigationPop:(UIButton *)sender
{
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
        return;
    }
    
    //    if (WebView.canGoBack) {
    //        [WebView goBack];
    //        return;
    //    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftBackImg{

    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_backBt"]];
    backImg.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    
    [backImg addGestureRecognizer:tap];

}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)loadData{
    
    NSString *cover = [kDetailurl stringByAppendingString:self.detail_url];
    
    
    NSLog(@"%@",cover);
    NSURL *url = [NSURL URLWithString:cover];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


#pragma mark  -UIWebViewDelegate
//开始加载请求
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
//请求加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if(navigationType == UIWebViewNavigationTypeLinkClicked){
        return NO;
    }else{
        return YES;
    }
}

//请求加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //    NSString *htm = [NSString stringWithFormat:@"<html><marquee><h1>%@</h1></marquee></html>",error];
    NSString *html = @"<html><marquee><h1>网络连接异常，请检查网络是否正常打开</h1></marquee></html>";
    [webView loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
