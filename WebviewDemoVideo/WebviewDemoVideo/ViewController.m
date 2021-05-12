//
//  ViewController.m
//  WebviewDemoVideo
//
//  Created by waitwalker on 2020/9/24.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [[UIImage alloc]init];
    
    NSLog(@"image是一个指针,指向的是[[UIImage alloc]init]创建出来的对象,\n这个UIImage对象的地址是:%p \nimage指针自己的地址是:%p",image, &image);
    
    UIImage *secondImage = [[UIImage alloc]init];
    NSLog(@"secondImage指向的对象地址:%p\nsecondImage自己的地址:%p",secondImage,&secondImage);
    
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
//
//    // 是否允许airPlay
//    config.allowsAirPlayForMediaPlayback = true;
//
//    // 是否页面内播放
//    config.allowsInlineMediaPlayback = true;
//    WKWebView *webview = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
//    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://swift-webview-video.now.sh/"]]];
//    [self.view addSubview:webview];
}


@end
